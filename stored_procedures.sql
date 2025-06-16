-- NOTA: No se agrega tabla OBSERVACIONES_MOVIMIENTOS para respetar el modelo ER fijo
-- Las observaciones se manejan a través de logs en los procedimientos

-- =============================================================================
-- CÓDIGOS DE ERROR PERSONALIZADOS UTILIZADOS EN STORED PROCEDURES
-- =============================================================================
-- Los siguientes códigos de error se utilizan consistentemente en todos los
-- procedimientos almacenados para proporcionar manejo robusto de errores:
--
-- VENTA DE TICKETS (SP_VENDER_TICKET):
-- -20010: Error de capacidad/tarifa en venta de tickets
-- -20011: Error de horario/múltiples tarifas en venta de tickets  
-- -20021: Error de concurrencia en generación de ID de ticket
-- -20022: Error interno en asignación de ID de ticket
--
-- GESTIÓN DE EMPLEADOS (SP_REGISTRAR_NUEVO_EMPLEADO):
-- -20012: Error en registro de empleados (unidad organizacional no encontrada)
--
-- GESTIÓN DE EXPOSICIONES (SP_FINALIZAR_EXPOSICION):
-- -20013: Error en finalización de exposiciones
--
-- RANKING DE MUSEOS (SP_CALCULAR_RANKING_MUSEO):
-- -20030: Error de validación de museo en ranking
-- -20031: Error inesperado en cálculo de ranking
--
-- ASIGNACIÓN DE OBRAS (SP_ASIGNAR_OBRA_A_EXPOSICION):
-- -20050: Error de validación de obra
-- -20051: Error de validación de exposición
-- -20053: Error de capacidad de exposición
-- -20059: Error inesperado en asignación de obras
-- Nota: -20052 se eliminó ya que ahora se maneja automáticamente el traspaso de obras
--
-- AUTOMATIZACIONES DE MANTENIMIENTO Y OPERACIONES:
-- -20060: Error en automatización de mantenimientos de obras
-- -20061: Error en automatización de cierres temporales
-- -20062: Error de validación de museo en programación de mantenimientos
-- -20063: Error inesperado en programación automática de mantenimientos
-- -20064: Error en automatización de historial de precios
-- -20065: Error de validación de museo en gestión de exposiciones
-- -20066: Error inesperado en gestión de estado de exposiciones
-- -20067: Error en consolidación de operaciones diarias
--
-- BLOQUES DE EJEMPLO DE USO:
-- -20040 a -20044: Errores específicos en bloques de ejemplo de uso
-- =============================================================================

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_VENDER_TICKET (Versión Mejorada y Thread-Safe)
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción: VERSIÓN MEJORADA Y THREAD-SAFE del procedimiento de venta de tickets.
-- Esta versión mejora significativamente el manejo de concurrencia y elimina 
-- race conditions que pueden ocurrir cuando múltiples usuarios compran tickets
-- simultáneamente.
--
-- Mejoras implementadas:
-- - Manejo de concurrencia con retry logic y savepoints
-- - Retry logic para resolver conflictos de duplicados
-- - Mejor manejo de errores y excepciones
-- - Optimización para uso con índices estratégicos
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_VENDER_TICKET (
    p_id_museo          IN  TICKETS.id_museo%TYPE,
    p_tipo_ticket       IN  TICKETS.tipo%TYPE,
    p_id_ticket_generado OUT TICKETS.id_num_ticket%TYPE
)
AS
    -- Variables locales optimizadas
    v_precio_vigente    TIPO_TICKETS.precio%TYPE;
    v_nuevo_id_ticket   TICKETS.id_num_ticket%TYPE;
    v_max_attempts      CONSTANT NUMBER := 5;
    v_attempt           NUMBER := 0;
    
    -- Excepción para manejo de claves duplicadas
    ex_duplicate_key    EXCEPTION;
    PRAGMA EXCEPTION_INIT(ex_duplicate_key, -00001);
BEGIN
    -- PASO 1: Buscar el precio vigente usando índice optimizado
    -- Esta consulta se beneficia del índice idx_tipo_tickets_museo_tipo_fechas
    BEGIN
        SELECT precio
        INTO v_precio_vigente
        FROM TIPO_TICKETS
        WHERE id_museo = p_id_museo
          AND tipo = p_tipo_ticket
          AND SYSDATE BETWEEN fecha_inicio AND NVL(fecha_fin, SYSDATE);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20010, 
                'No existe una tarifa de ticket activa para el tipo "' || p_tipo_ticket || 
                '" en el museo ID ' || p_id_museo || '.');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20011, 
                'Error de datos: Múltiples tarifas activas encontradas para el tipo "' || 
                p_tipo_ticket || '" en el museo ID ' || p_id_museo || '.');
    END;

    -- PASO 2: Manejo de concurrencia con retry logic
    -- Este loop maneja situaciones donde múltiples sesiones intentan generar IDs simultáneamente
    WHILE v_attempt < v_max_attempts LOOP
        BEGIN
            v_attempt := v_attempt + 1;
            
            -- Crear savepoint para rollback parcial en caso de error
            SAVEPOINT sp_ticket_attempt;
            
            -- Generar nuevo ID de ticket secuencial por museo
            -- Esta consulta se beneficia del índice idx_tickets_museo_num_ticket
            SELECT NVL(MAX(id_num_ticket), 0) + 1
            INTO v_nuevo_id_ticket
            FROM TICKETS
            WHERE id_museo = p_id_museo;

            -- Insertar el nuevo ticket con el ID generado
            INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
            VALUES (v_nuevo_id_ticket, p_id_museo, SYSDATE, p_tipo_ticket, v_precio_vigente);

            -- Si llegamos aquí, la inserción fue exitosa
            p_id_ticket_generado := v_nuevo_id_ticket;
            EXIT; -- Salir del loop de retry

        EXCEPTION
            WHEN ex_duplicate_key THEN
                -- Rollback al savepoint y retry si no hemos alcanzado el máximo de intentos
                ROLLBACK TO sp_ticket_attempt;
                
                IF v_attempt >= v_max_attempts THEN
                    RAISE_APPLICATION_ERROR(-20021, 
                        'Error: No se pudo generar un ID único de ticket después de ' || 
                        v_max_attempts || ' intentos. Intente nuevamente.');
                END IF;
                
                -- Pequeña pausa antes del siguiente intento (simula backoff)
                -- DBMS_LOCK.SLEEP(0.01 * v_attempt); -- Comentado: requiere privilegios especiales
                
            WHEN OTHERS THEN
                -- Para cualquier otro error, fallar inmediatamente
                ROLLBACK TO sp_ticket_attempt;
                RAISE;
        END;
    END LOOP;

    -- Validación final: asegurar que se generó un ID válido
    IF p_id_ticket_generado IS NULL THEN
        RAISE_APPLICATION_ERROR(-20022, 
            'Error interno: No se pudo asignar un ID de ticket válido.');
    END IF;

EXCEPTION
    -- Manejo global de errores
    WHEN OTHERS THEN
        -- Log del error (opcional, para debugging en desarrollo)
        -- DBMS_OUTPUT.PUT_LINE('Error en SP_VENDER_TICKET: ' || SQLERRM);
        RAISE; -- Re-lanzar la excepción para que la aplicación cliente la maneje
        
END SP_VENDER_TICKET;
/


-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO (PL/SQL Anónimo)
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_museo_id      NUMBER;
    v_ticket_id     NUMBER;
BEGIN
    -- Obtener el ID del museo
    BEGIN
        SELECT id_museo INTO v_museo_id FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20040, 'Error: No se encontró el museo "Hamburger Kunsthalle"');
    END;

    -- Llamar al procedimiento para vender un ticket de adulto
    SP_VENDER_TICKET(
        p_id_museo          => v_museo_id,
        p_tipo_ticket       => 'ADULTO',
        p_id_ticket_generado => v_ticket_id
    );
    
    DBMS_OUTPUT.PUT_LINE('Ticket vendido exitosamente. ID del Ticket: ' || v_ticket_id);
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al vender el ticket: ' || SQLERRM);
        ROLLBACK;
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
END;
/
*/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_REGISTRAR_NUEVO_EMPLEADO
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Este procedimiento centraliza el proceso de alta de un nuevo empleado profesional.
-- Inserta el registro principal en EMPLEADOS_PROFESIONALES y, de forma atómica,
-- crea su primer registro en la tabla de historial de cargos (HIST_EMPLEADOS).
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_REGISTRAR_NUEVO_EMPLEADO (
    -- Parámetros de entrada para los datos personales del empleado
    p_doc_identidad     IN EMPLEADOS_PROFESIONALES.doc_identidad%TYPE,
    p_primer_nombre     IN EMPLEADOS_PROFESIONALES.primer_nombre%TYPE,
    p_primer_apellido   IN EMPLEADOS_PROFESIONALES.primer_apellido%TYPE,
    p_fecha_nacimiento  IN EMPLEADOS_PROFESIONALES.fecha_nacimiento%TYPE,
    p_contacto          IN EMPLEADOS_PROFESIONALES.contacto%TYPE,
    p_segundo_nombre    IN EMPLEADOS_PROFESIONALES.segundo_nombre%TYPE DEFAULT NULL,
    p_segundo_apellido  IN EMPLEADOS_PROFESIONALES.segundo_apellido%TYPE DEFAULT NULL,
    
    -- Parámetros de entrada para el primer puesto de trabajo
    p_id_museo          IN MUSEOS.id_museo%TYPE,
    p_nombre_unidad_org IN EST_ORGANIZACIONAL.nombre%TYPE,
    p_cargo             IN HIST_EMPLEADOS.cargo%TYPE,
    p_fecha_inicio_cargo IN HIST_EMPLEADOS.fecha_inicio%TYPE,

    -- Parámetro de salida para devolver el ID del nuevo empleado
    p_id_empleado_generado OUT EMPLEADOS_PROFESIONALES.id_empleado%TYPE
)
AS
    -- Variables locales
    v_id_est_org        EST_ORGANIZACIONAL.id_est_org%TYPE;
BEGIN
    -- 1. Insertar el nuevo empleado en la tabla EMPLEADOS_PROFESIONALES.
    -- La cláusula RETURNING captura el ID generado por la secuencia y lo guarda en la variable de salida.
    INSERT INTO EMPLEADOS_PROFESIONALES (
        doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido
    ) VALUES (
        p_doc_identidad, p_primer_nombre, p_primer_apellido, p_fecha_nacimiento, p_contacto, p_segundo_nombre, p_segundo_apellido
    ) RETURNING id_empleado INTO p_id_empleado_generado;

    -- 2. Buscar el ID de la unidad organizacional a la que se asignará el empleado.
    BEGIN
        SELECT id_est_org
        INTO v_id_est_org
        FROM EST_ORGANIZACIONAL
        WHERE nombre = p_nombre_unidad_org
          AND id_museo = p_id_museo;
    EXCEPTION
        -- Si no se encuentra la unidad organizacional, se lanza un error.
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20012, 'La unidad organizacional "' || p_nombre_unidad_org || '" no existe para el museo ID ' || p_id_museo || '.');
    END;

    -- 3. Insertar el primer registro en el historial de cargos del empleado.
    -- La fecha_fin es NULL, ya que es su cargo actual.
    INSERT INTO HIST_EMPLEADOS (
        fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin
    ) VALUES (
        p_fecha_inicio_cargo, v_id_est_org, p_id_museo, p_id_empleado_generado, p_cargo, NULL
    );

    -- Opcional: Confirmar la transacción.
    -- COMMIT; -- Comentado para permitir que la transacción sea manejada por la sesión que llama.

EXCEPTION
    -- Captura cualquier error para asegurar que no se deje un empleado sin historial.
    WHEN OTHERS THEN
        -- ROLLBACK; -- Revertir todos los cambios si ocurre un error en cualquier paso.
        RAISE; -- Vuelve a lanzar la excepción.
END SP_REGISTRAR_NUEVO_EMPLEADO;
/


-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO (PL/SQL Anónimo)
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_museo_id      NUMBER;
    v_empleado_id   NUMBER;
BEGIN
    -- Obtener el ID del museo
    BEGIN
        SELECT id_museo INTO v_museo_id FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20041, 'Error: No se encontró el museo "Museum der bildenden Künste Leipzig"');
    END;

    -- Llamar al procedimiento para registrar un nuevo Restaurador
    SP_REGISTRAR_NUEVO_EMPLEADO(
        p_doc_identidad      => 30000001,
        p_primer_nombre      => 'Clara',
        p_primer_apellido    => 'Schulz',
        p_fecha_nacimiento   => TO_DATE('1990-08-15', 'YYYY-MM-DD'),
        p_contacto           => 491798765432,
        p_id_museo           => v_museo_id,
        p_nombre_unidad_org  => 'Departamento de Colecciones MdbK',
        p_cargo              => 'RESTAURADOR',
        p_fecha_inicio_cargo => SYSDATE,
        p_id_empleado_generado => v_empleado_id
    );
    
    DBMS_OUTPUT.PUT_LINE('Nuevo empleado registrado con éxito. ID: ' || v_empleado_id);
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al registrar al empleado: ' || SQLERRM);
        ROLLBACK;
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
END;
/
*/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_FINALIZAR_EXPOSICION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Este procedimiento marca una exposición o evento como finalizado, actualizando
-- su fecha_fin a la fecha y hora actual del sistema (SYSDATE).
-- Proporciona un método controlado para concluir eventos en la base de datos.
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_FINALIZAR_EXPOSICION (
    p_id_expo    IN EXPOSICIONES_EVENTOS.id_expo%TYPE,
    p_id_museo   IN EXPOSICIONES_EVENTOS.id_museo%TYPE
)
AS
BEGIN
    -- Actualiza la fecha de finalización de la exposición especificada.
    UPDATE EXPOSICIONES_EVENTOS
    SET fecha_fin = SYSDATE
    WHERE id_expo = p_id_expo
      AND id_museo = p_id_museo;

    -- Verificar si se actualizó alguna fila. Si no, significa que la exposición no fue encontrada.
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20013, 
            'Error: No se encontró la exposición con ID ' || p_id_expo || 
            ' en el museo con ID ' || p_id_museo || '. No se realizó ninguna actualización.');
    END IF;

    -- Opcional: Confirmar la transacción.
    -- COMMIT; -- Comentado para permitir que la transacción sea manejada por la sesión que llama.

EXCEPTION
    -- Captura cualquier otro error inesperado.
    WHEN OTHERS THEN
        -- ROLLBACK;
        RAISE; -- Vuelve a lanzar la excepción.

END SP_FINALIZAR_EXPOSICION;
/


-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO (PL/SQL Anónimo)
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_id_exposicion   NUMBER;
    v_id_museo_expo   NUMBER;
BEGIN
    -- Obtener los IDs necesarios para una exposición específica
    BEGIN
        SELECT id_expo, id_museo 
        INTO v_id_exposicion, v_id_museo_expo
        FROM EXPOSICIONES_EVENTOS
        WHERE nombre LIKE 'Impresionismo en Transición%' AND ROWNUM = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20042, 'Error: No se encontró ninguna exposición con el patrón "Impresionismo en Transición%"');
    END;

    -- Llamar al procedimiento para finalizar la exposición
    SP_FINALIZAR_EXPOSICION(
        p_id_expo  => v_id_exposicion,
        p_id_museo => v_id_museo_expo
    );
    
    DBMS_OUTPUT.PUT_LINE('La exposición con ID ' || v_id_exposicion || ' ha sido marcada como finalizada.');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al finalizar la exposición: ' || SQLERRM);
        ROLLBACK;
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
END;
/
*/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_CALCULAR_RANKING_MUSEO
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 07-JUN-2025
-- Fecha de Modificación: 15-DIC-2024
-- Descripción:
--c  Calcula el ranking de un museo basándose PRIORITARIAMENTE en la permanencia de su personal.
-- LÓGICA DE RANKING (CONSISTENTE CON LA VISTA V_MUSEOS_RANKING_SCORES):
-- 1. PRIORIDAD PRINCIPAL: Rotación de empleados (tiempo de permanencia promedio)
--    - Promedio > 10 años = puntuación 1 (MEJOR, baja rotación)
--    - Promedio entre 5-10 años = puntuación 2 (MEDIO)
--    - Promedio < 5 años = puntuación 3 (PEOR, alta rotación)
-- 2. CRITERIO DE DESEMPATE: Rangos de tickets vendidos en el último año
--    - 50+ visitas = puntuación 1, 25-49 = puntuación 2, etc.
-- Este procedimiento es llamado por la API para enriquecer el reporte de Ficha de Museo.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_CALCULAR_RANKING_MUSEO (
    p_id_museo                  IN  MUSEOS.id_museo%TYPE,
    p_antiguedad_promedio_anios OUT NUMBER,
    p_tasa_rotacion_alta_pct    OUT NUMBER,
    p_visitas_ultimo_anio       OUT NUMBER,
    p_categoria_ranking         OUT VARCHAR2
)
AS
    -- Variables para el cálculo de estabilidad del personal
    v_total_antiguedad_dias   NUMBER := 0;
    v_total_empleados         NUMBER := 0;
    v_empleados_alta_rotacion NUMBER := 0;
    v_antiguedad_promedio_anios NUMBER := 0;
    
    -- Variables para el cálculo de popularidad (criterio de desempate)
    v_visitas_anuales         NUMBER := 0;
    v_tickets_anuales         NUMBER := 0;
    v_visitas_exposiciones    NUMBER := 0;
    
    -- Variables para el ranking basado en rotación y visitas
    v_puntuacion_rotacion     NUMBER := 3; -- Por defecto peor puntuación
    v_puntuacion_visitas      NUMBER := 6; -- Por defecto peor puntuación
    v_score_final             NUMBER;
    
    -- Variable para validar que el museo existe
    v_museo_existe            NUMBER;

BEGIN
    -- ========= VALIDACIÓN INICIAL: Verificar que el museo existe =========
    BEGIN
        SELECT 1
        INTO v_museo_existe
        FROM MUSEOS
        WHERE id_museo = p_id_museo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20030, 
                'Error: No existe un museo con el ID ' || p_id_museo || '. Verifique el parámetro de entrada.');
    END;

    -- ========= PASO 1: Calcular la Estabilidad del Personal =========
    FOR rec IN (
        SELECT (COALESCE(fecha_fin, SYSDATE) - fecha_inicio) as dias_trabajados
        FROM HIST_EMPLEADOS
        WHERE id_museo = p_id_museo
    ) LOOP
        v_total_antiguedad_dias := v_total_antiguedad_dias + rec.dias_trabajados;
        v_total_empleados := v_total_empleados + 1;
        
        -- Contar empleados con alta rotación (menos de 5 años)
        IF rec.dias_trabajados < (365.25 * 5) THEN
            v_empleados_alta_rotacion := v_empleados_alta_rotacion + 1;
        END IF;
    END LOOP;

    IF v_total_empleados > 0 THEN
        v_antiguedad_promedio_anios := (v_total_antiguedad_dias / v_total_empleados) / 365.25;
        p_antiguedad_promedio_anios := ROUND(v_antiguedad_promedio_anios, 2);
        p_tasa_rotacion_alta_pct := ROUND((v_empleados_alta_rotacion / v_total_empleados) * 100, 2);
        
        -- ========= NUEVA LÓGICA: Asignar puntuación basada en rotación =========
        -- Promedio > 10 años = puntuación 1 (MEJOR, baja rotación)
        -- Promedio entre 5-10 años = puntuación 2 (MEDIO)
        -- Promedio < 5 años = puntuación 3 (PEOR, alta rotación)
        IF v_antiguedad_promedio_anios > 10 THEN
            v_puntuacion_rotacion := 1;
        ELSIF v_antiguedad_promedio_anios >= 5 THEN
            v_puntuacion_rotacion := 2;
        ELSE
            v_puntuacion_rotacion := 3;
        END IF;
    ELSE
        -- Si no hay empleados, asignar valores por defecto (peor puntuación)
        p_antiguedad_promedio_anios := 0;
        p_tasa_rotacion_alta_pct := 100; -- Máxima rotación por no tener datos
        v_puntuacion_rotacion := 3; -- Peor puntuación
    END IF;

    -- ========= PASO 2: Calcular las Visitas Anuales y su Puntuación =========
    -- ===== CÁLCULO DE POPULARIDAD (VOLUMEN TOTAL DE VISITAS) =====
    -- Incluye: tickets de entrada general + visitantes de exposiciones específicas
    
    -- Contar tickets de entrada general del último año
    SELECT COUNT(*) 
    INTO v_tickets_anuales
    FROM TICKETS 
    WHERE id_museo = p_id_museo 
      AND fecha_hora_emision >= (SYSDATE - 365);
    
    -- Sumar visitantes de exposiciones/eventos del último año
    SELECT COALESCE(SUM(cant_visitantes), 0)
    INTO v_visitas_exposiciones
    FROM EXPOSICIONES_EVENTOS 
    WHERE id_museo = p_id_museo 
      AND cant_visitantes IS NOT NULL
      AND fecha_inicio >= (SYSDATE - 365);
    
    -- Calcular volumen total de visitas anuales
    p_visitas_ultimo_anio := v_tickets_anuales + v_visitas_exposiciones;
    
    -- Clasificar por rangos de popularidad (1=mejor, 6=peor)
    IF p_visitas_ultimo_anio >= 50 THEN
        v_puntuacion_visitas := 1;      -- Excelente afluencia
    ELSIF p_visitas_ultimo_anio >= 25 THEN
        v_puntuacion_visitas := 2;      -- Buena afluencia
    ELSIF p_visitas_ultimo_anio >= 10 THEN
        v_puntuacion_visitas := 3;      -- Afluencia regular
    ELSIF p_visitas_ultimo_anio >= 5 THEN
        v_puntuacion_visitas := 4;      -- Afluencia baja
    ELSIF p_visitas_ultimo_anio >= 1 THEN
        v_puntuacion_visitas := 5;      -- Afluencia muy baja
    ELSE
        v_puntuacion_visitas := 6;      -- Sin registro de visitas
    END IF;

    -- ========= PASO 3: Calcular Score Final (Consistente con la Vista) =========
    -- Score final: Rotación + (Visitas / 100) para mantener prioridad de rotación
    v_score_final := v_puntuacion_rotacion + (v_puntuacion_visitas / 100.0);

    -- ========= PASO 4: Asignar Categoría basada en la puntuación de rotación =========
    -- La categoría se basa PRIORITARIAMENTE en la puntuación de rotación
    CASE v_puntuacion_rotacion
        WHEN 1 THEN
            p_categoria_ranking := 'Excelente (Personal Muy Estable - +10 años promedio)';
        WHEN 2 THEN
            p_categoria_ranking := 'Bueno (Personal Estable - 5-10 años promedio)';
        WHEN 3 THEN
            p_categoria_ranking := 'En Desarrollo (Alta Rotación - <5 años promedio)';
        ELSE
            p_categoria_ranking := 'Sin Clasificar (Datos Insuficientes)';
    END CASE;

EXCEPTION
    WHEN OTHERS THEN
        -- Manejo robusto de errores inesperados
        RAISE_APPLICATION_ERROR(-20031, 
            'Error inesperado al calcular el ranking del museo ID ' || p_id_museo || ': ' || SQLERRM);
END SP_CALCULAR_RANKING_MUSEO;
/


-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_ASIGNAR_OBRA_A_EXPOSICION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Procedimiento que asigna una obra a una exposición con manejo automático de traspasos.
-- Características principales:
-- - Si la obra está en otra exposición, automáticamente cierra esa estadía
-- - Verifica que la exposición exista y esté dentro del periodo válido
-- - Controla la capacidad máxima de obras por exposición
-- - Registra automáticamente el traspaso en las observaciones de movimiento
-- - Demuestra mejores prácticas de manejo de errores con RAISE_APPLICATION_ERROR
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_ASIGNAR_OBRA_A_EXPOSICION (
    p_id_obra              IN OBRAS.id_obra%TYPE,
    p_id_expo              IN EXPOSICIONES_EVENTOS.id_expo%TYPE,
    p_id_museo             IN EXPOSICIONES_EVENTOS.id_museo%TYPE,
    p_orden_en_exposicion  IN NUMBER DEFAULT NULL
)
AS
    -- Variables para validaciones
    v_obra_en_otra_expo    NUMBER := 0;
    v_exposicion_valida    NUMBER := 0;
    v_fecha_inicio_expo    DATE;
    v_fecha_fin_expo       DATE;
    v_nombre_expo          VARCHAR2(250);
    v_capacidad_actual     NUMBER := 0;
    v_capacidad_maxima     CONSTANT NUMBER := 50; -- Capacidad máxima por exposición
    
BEGIN
    -- ========= VALIDACIÓN 1: Verificar que la obra existe =========
    BEGIN
        SELECT 1 
        INTO v_obra_en_otra_expo -- Reutilizamos la variable para verificar existencia
        FROM OBRAS 
        WHERE id_obra = p_id_obra;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20050, 
                'Error: No existe una obra con el ID ' || p_id_obra || '. Verifique el parámetro de entrada.');
    END;

    -- ========= VALIDACIÓN 2: Verificar que la exposición existe y está activa =========
    BEGIN
        SELECT 1, fecha_inicio, fecha_fin, nombre
        INTO v_exposicion_valida, v_fecha_inicio_expo, v_fecha_fin_expo, v_nombre_expo
        FROM EXPOSICIONES_EVENTOS
        WHERE id_expo = p_id_expo 
          AND id_museo = p_id_museo
          AND SYSDATE BETWEEN fecha_inicio AND fecha_fin;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20051, 
                'Error: No existe una exposición activa con ID ' || p_id_expo || 
                ' en el museo ID ' || p_id_museo || ', o la exposición no está en período válido.');
    END;

    -- ========= PASO 3: Manejo automático de obra en otra exposición activa =========
    -- Si la obra está actualmente en otra exposición, cerramos automáticamente esa estadía
    -- para permitir su traspaso a la nueva exposición
    SELECT COUNT(*)
    INTO v_obra_en_otra_expo
    FROM HIST_OBRAS_MOV hom
    WHERE hom.id_obra = p_id_obra
      AND hom.fecha_salida IS NULL  -- La obra está actualmente activa en algún lugar
      AND hom.id_museo != p_id_museo; -- Y no está en el museo de destino

    IF v_obra_en_otra_expo > 0 THEN
        -- Cerrar automáticamente la estadía anterior de la obra
        UPDATE HIST_OBRAS_MOV
        SET fecha_salida = SYSDATE
        WHERE id_obra = p_id_obra
          AND fecha_salida IS NULL;
          
        -- Log informativo del traspaso (para auditoría en desarrollo)
        -- DBMS_OUTPUT.PUT_LINE('INFO: Obra ' || p_id_obra || ' trasladada automáticamente a exposición ID ' || p_id_expo);
    END IF;

    -- ========= VALIDACIÓN 3: Verificar capacidad de la exposición =========
    SELECT COUNT(*)
    INTO v_capacidad_actual
    FROM HIST_OBRAS_MOV hom
    JOIN EXPOSICIONES_EVENTOS ee ON (hom.id_museo = ee.id_museo)
    WHERE ee.id_expo = p_id_expo
      AND ee.id_museo = p_id_museo
      AND hom.fecha_salida IS NULL
      AND SYSDATE BETWEEN ee.fecha_inicio AND ee.fecha_fin;

    IF v_capacidad_actual >= v_capacidad_maxima THEN
        RAISE_APPLICATION_ERROR(-20053, 
            'Error: La exposición "' || v_nombre_expo || '" (ID: ' || p_id_expo || 
            ') ha alcanzado su capacidad máxima de ' || v_capacidad_maxima || ' obras.');
    END IF;

    -- ========= PASO 4: Insertar la obra en el historial de movimientos =========
    -- Nota: En una implementación real, esto requeriría más datos específicos
    -- como id_coleccion, id_sala, etc. Este es un ejemplo simplificado.
    INSERT INTO HIST_OBRAS_MOV (
        id_obra, 
        id_coleccion, 
        id_sala, 
        id_empleado, 
        id_est_org, 
        id_museo, 
        id_est_fis,
        fecha_entrada, 
        tipo_adquisicion, 
        destacada, 
        orden_recorrido
    ) 
    SELECT 
        p_id_obra,
        cp.id_coleccion,
        se.id_sala,
        1, -- ID del empleado responsable (simplificado)
        cp.id_est_org,
        p_id_museo,
        se.id_est,
        SYSDATE,
        'COMPRADA', -- Tipo por defecto
        'SI', -- Marcada como destacada en exposición
        NVL(p_orden_en_exposicion, v_capacidad_actual + 1)
    FROM COLECCIONES_PERMANENTES cp, SALAS_EXP se
    WHERE cp.id_museo = p_id_museo 
      AND se.id_museo = p_id_museo
      AND ROWNUM = 1; -- Simplificación: tomar la primera colección y sala disponible

    -- Confirmación de éxito (solo para depuración, en producción se eliminaría)
    -- DBMS_OUTPUT.PUT_LINE('Obra ' || p_id_obra || ' asignada exitosamente a la exposición "' || v_nombre_expo || '"');

EXCEPTION
    -- Los errores específicos ya se manejan con RAISE_APPLICATION_ERROR arriba
    -- Esta sección captura errores inesperados
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20059, 
            'Error inesperado al asignar la obra ' || p_id_obra || 
            ' a la exposición ' || p_id_expo || ': ' || SQLERRM);
            
END SP_ASIGNAR_OBRA_A_EXPOSICION;
/

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: SP_ASIGNAR_OBRA_A_EXPOSICION
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_id_obra         NUMBER := 1001; -- ID de una obra específica
    v_id_exposicion   NUMBER;
    v_id_museo        NUMBER;
BEGIN
    -- Obtener los datos de una exposición activa
    BEGIN
        SELECT id_expo, id_museo 
        INTO v_id_exposicion, v_id_museo
        FROM EXPOSICIONES_EVENTOS
        WHERE SYSDATE BETWEEN fecha_inicio AND fecha_fin
          AND ROWNUM = 1; -- Tomar la primera exposición activa
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20044, 'Error: No hay exposiciones activas disponibles');
    END;

    -- Asignar la obra a la exposición (con manejo automático de traspasos)
    SP_ASIGNAR_OBRA_A_EXPOSICION(
        p_id_obra              => v_id_obra,
        p_id_expo              => v_id_exposicion,
        p_id_museo             => v_id_museo,
        p_orden_en_exposicion  => 1
    );
    
    DBMS_OUTPUT.PUT_LINE('Obra ' || v_id_obra || ' asignada exitosamente a la exposición ID ' || v_id_exposicion);
    DBMS_OUTPUT.PUT_LINE('Si la obra estaba en otra exposición, se transfirió automáticamente.');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al asignar la obra: ' || SQLERRM);
        ROLLBACK;
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
END;
/
*/

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO (PL/SQL Anónimo)
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_museo_id_test NUMBER;
    v_antiguedad    NUMBER;
    v_tasa          NUMBER;
    v_visitas       NUMBER;
    v_categoria     VARCHAR2(100);
BEGIN
    -- Obtener el ID del museo con manejo de errores
    BEGIN
        SELECT id_museo INTO v_museo_id_test FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20043, 'Error: No se encontró el museo "Hamburger Kunsthalle"');
    END;

    -- Llamar al procedimiento de ranking
    SP_CALCULAR_RANKING_MUSEO(
        p_id_museo => v_museo_id_test,
        p_antiguedad_promedio_anios => v_antiguedad,
        p_tasa_rotacion_alta_pct => v_tasa,
        p_visitas_ultimo_anio => v_visitas,
        p_categoria_ranking => v_categoria
    );

    DBMS_OUTPUT.PUT_LINE('--- Ranking del Museo ID ' || v_museo_id_test || ' ---');
    DBMS_OUTPUT.PUT_LINE('Antigüedad Promedio: ' || ROUND(v_antiguedad, 2) || ' años');
    DBMS_OUTPUT.PUT_LINE('Tasa de Rotación (<5 años): ' || ROUND(v_tasa, 2) || '%');
    DBMS_OUTPUT.PUT_LINE('Visitas en el último año: ' || v_visitas);
    DBMS_OUTPUT.PUT_LINE('Categoría Final: ' || v_categoria);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al calcular el ranking: ' || SQLERRM);
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
END;
/
*/



-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_GESTIONAR_ESTADO_EXPOSICIONES
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Automatiza la gestión del estado de exposiciones basándose en fechas:
-- - Identifica exposiciones que deberían estar activas pero no tienen obras asignadas
-- - Identifica exposiciones vencidas que aún tienen obras asignadas
-- - Proporciona recomendaciones automáticas para la gestión
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_GESTIONAR_ESTADO_EXPOSICIONES (
    p_id_museo         IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_accion_automatica IN VARCHAR2 DEFAULT 'REPORTE', -- 'REPORTE' o 'EJECUTAR'
    p_registros_procesados OUT NUMBER
)
AS
    v_contador NUMBER := 0;
    v_obras_asignadas NUMBER;
    
    -- Cursor para exposiciones que requieren atención
    CURSOR c_exposiciones_revision IS
        SELECT 
            ee.id_expo,
            ee.id_museo,
            ee.nombre,
            ee.fecha_inicio,
            ee.fecha_fin,
            CASE 
                WHEN SYSDATE < ee.fecha_inicio THEN 'FUTURA'
                WHEN SYSDATE BETWEEN ee.fecha_inicio AND ee.fecha_fin THEN 'ACTIVA'
                WHEN SYSDATE > ee.fecha_fin THEN 'VENCIDA'
            END as estado_temporal,
            (SELECT COUNT(*) 
             FROM HIST_OBRAS_MOV hom 
             WHERE hom.id_museo = ee.id_museo 
               AND hom.fecha_salida IS NULL
               AND EXISTS (
                   SELECT 1 FROM HIST_OBRAS_MOV hom2 
                   WHERE hom2.id_obra = hom.id_obra 
                     AND hom2.fecha_entrada <= ee.fecha_fin
                     AND (hom2.fecha_salida IS NULL OR hom2.fecha_salida >= ee.fecha_inicio)
               )
            ) as obras_asignadas
        FROM EXPOSICIONES_EVENTOS ee
        WHERE (p_id_museo IS NULL OR ee.id_museo = p_id_museo)
          AND (
              -- Exposiciones activas sin obras asignadas
              (SYSDATE BETWEEN ee.fecha_inicio AND ee.fecha_fin AND 
               NOT EXISTS (
                   SELECT 1 FROM HIST_OBRAS_MOV hom 
                   WHERE hom.id_museo = ee.id_museo 
                     AND hom.fecha_salida IS NULL
               )) OR
              -- Exposiciones vencidas con obras aún asignadas
              (SYSDATE > ee.fecha_fin AND 
               EXISTS (
                   SELECT 1 FROM HIST_OBRAS_MOV hom 
                   WHERE hom.id_museo = ee.id_museo 
                     AND hom.fecha_salida IS NULL
               ))
          );

BEGIN
    -- Validar que el museo existe si se especifica
    IF p_id_museo IS NOT NULL THEN
        BEGIN
            SELECT 1 INTO v_contador FROM MUSEOS WHERE id_museo = p_id_museo;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20065, 
                    'Error: No existe un museo con ID ' || p_id_museo);
        END;
    END IF;

    v_contador := 0;

    -- Procesar cada exposición que requiere atención
    FOR rec IN c_exposiciones_revision LOOP
        IF p_accion_automatica = 'REPORTE' THEN
            -- Solo generar reporte (usar DBMS_OUTPUT para demostración)
            DBMS_OUTPUT.PUT_LINE('RECOMENDACIÓN: Exposición "' || rec.nombre || 
                               '" (ID: ' || rec.id_expo || 
                               ') - Estado: ' || rec.estado_temporal ||
                               ' - Obras asignadas: ' || rec.obras_asignadas);
            
        ELSIF p_accion_automatica = 'EJECUTAR' THEN
            -- Ejecutar acciones automáticas
            IF rec.estado_temporal = 'VENCIDA' AND rec.obras_asignadas > 0 THEN
                -- Liberar obras de exposiciones vencidas
                UPDATE HIST_OBRAS_MOV
                SET fecha_salida = rec.fecha_fin + 1
                WHERE id_museo = rec.id_museo
                  AND fecha_salida IS NULL
                  AND EXISTS (
                      SELECT 1 FROM HIST_OBRAS_MOV hom2 
                      WHERE hom2.id_obra = HIST_OBRAS_MOV.id_obra 
                        AND hom2.fecha_entrada <= rec.fecha_fin
                        AND (hom2.fecha_salida IS NULL OR hom2.fecha_salida >= rec.fecha_inicio)
                  );
                  
                -- Log informativo de liberación (para auditoría en desarrollo)
                -- DBMS_OUTPUT.PUT_LINE('INFO: Obras liberadas automáticamente de exposición: ' || rec.nombre);
            END IF;
        END IF;
        
        v_contador := v_contador + 1;
    END LOOP;

    p_registros_procesados := v_contador;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20066, 
            'Error inesperado en gestión de estado de exposiciones: ' || SQLERRM);
END SP_GESTIONAR_ESTADO_EXPOSICIONES;
/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_CONSOLIDAR_OPERACIONES_DIARIAS
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Procedimiento maestro que ejecuta todas las automatizaciones diarias:
-- - Programación automática de mantenimientos
-- - Gestión de estados de exposiciones
-- - Limpieza de registros temporales
-- - Generación de reportes operativos
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_CONSOLIDAR_OPERACIONES_DIARIAS (
    p_id_museo         IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_ejecutar_acciones IN VARCHAR2 DEFAULT 'SI', -- 'SI' o 'NO' (solo reporte)
    p_resumen_operaciones OUT VARCHAR2
)
AS
    v_mant_programados NUMBER := 0;
    v_expo_revisadas NUMBER := 0;
    v_resumen VARCHAR2(4000);
BEGIN
    -- 1. Programar mantenimientos automáticos
    SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO(
        p_id_museo => p_id_museo,
        p_dias_anticipacion => 7, -- Una semana de anticipación
        p_registros_procesados => v_mant_programados
    );

    -- 2. Gestionar estado de exposiciones
    SP_GESTIONAR_ESTADO_EXPOSICIONES(
        p_id_museo => p_id_museo,
        p_accion_automatica => CASE WHEN p_ejecutar_acciones = 'SI' THEN 'EJECUTAR' ELSE 'REPORTE' END,
        p_registros_procesados => v_expo_revisadas
    );

    -- 3. Generar resumen
    v_resumen := 'CONSOLIDACIÓN DIARIA - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI') || CHR(10) ||
                 'Museo: ' || COALESCE(TO_CHAR(p_id_museo), 'TODOS') || CHR(10) ||
                 'Mantenimientos programados: ' || v_mant_programados || CHR(10) ||
                 'Exposiciones revisadas: ' || v_expo_revisadas || CHR(10) ||
                 'Modo: ' || CASE WHEN p_ejecutar_acciones = 'SI' THEN 'EJECUCIÓN' ELSE 'SOLO REPORTE' END;

    p_resumen_operaciones := v_resumen;

    -- Commit de todas las operaciones
    IF p_ejecutar_acciones = 'SI' THEN
        COMMIT;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20067, 
            'Error en consolidación de operaciones diarias: ' || SQLERRM);
END SP_CONSOLIDAR_OPERACIONES_DIARIAS;
/

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: SISTEMA COMPLETO DE AUTOMATIZACIÓN
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_resumen_operaciones VARCHAR2(4000);
    v_mant_programados NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== DEMO: SISTEMA DE AUTOMATIZACIÓN DEL MUSEO ===');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- 1. Ejecutar consolidación diaria (modo reporte primero)
    DBMS_OUTPUT.PUT_LINE('1. Ejecutando análisis de operaciones diarias...');
    SP_CONSOLIDAR_OPERACIONES_DIARIAS(
        p_id_museo => NULL, -- Todos los museos
        p_ejecutar_acciones => 'NO', -- Solo reporte
        p_resumen_operaciones => v_resumen_operaciones
    );
    DBMS_OUTPUT.PUT_LINE(v_resumen_operaciones);
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('2. Programando mantenimientos automáticos...');
    
    -- 2. Programar mantenimientos específicos
    SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO(
        p_id_museo => 1, -- Solo el primer museo
        p_dias_anticipacion => 15, -- 15 días de anticipación
        p_registros_procesados => v_mant_programados
    );
    
    DBMS_OUTPUT.PUT_LINE('Mantenimientos programados: ' || v_mant_programados);
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('3. Ejemplo de triggers automáticos:');
    DBMS_OUTPUT.PUT_LINE('- TRG_MANEJAR_MANTENIMIENTOS_OBRAS: Cierra mantenimientos anteriores automáticamente');
    DBMS_OUTPUT.PUT_LINE('- TRG_AUTOMATIZAR_CIERRES_TEMPORALES: Gestiona cierres de salas automáticamente');
    DBMS_OUTPUT.PUT_LINE('- TRG_GESTIONAR_HISTORIAL_PRECIOS: Mantiene historial de precios automáticamente');
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=== AUTOMATIZACIÓN COMPLETADA ===');
    
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en demo de automatización: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/
*/


-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Automatiza la programación de mantenimientos basándose en la frecuencia
-- definida en PROGRAMAS_MANT. Identifica obras que requieren mantenimiento
-- y programa automáticamente las tareas pendientes.
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO (
    p_id_museo          IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_dias_anticipacion IN NUMBER DEFAULT 30,
    p_registros_procesados OUT NUMBER
)
AS
    v_contador NUMBER := 0;
    v_fecha_programada DATE;
    v_empleado_responsable NUMBER;
    
    -- Cursor para obras que requieren mantenimiento
    CURSOR c_obras_mantenimiento IS
        SELECT DISTINCT 
            pm.id_mant,
            pm.id_catalogo,
            pm.id_obra,
            pm.actividad,
            pm.frecuencia,
            pm.tipo_responsable,
            hom.id_museo,
            COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) as ultima_fecha_mant
        FROM PROGRAMAS_MANT pm
        JOIN HIST_OBRAS_MOV hom ON (pm.id_catalogo = hom.id_catalogo_museo AND pm.id_obra = hom.id_obra)
        LEFT JOIN MANTENIMIENTOS_OBRAS_REALIZADOS mor ON (pm.id_mant = mor.id_mant 
                                                          AND pm.id_catalogo = mor.id_catalogo 
                                                          AND pm.id_obra = mor.id_obra)
        WHERE hom.fecha_salida IS NULL -- Solo obras actualmente en el museo
          AND (p_id_museo IS NULL OR hom.id_museo = p_id_museo)
        GROUP BY pm.id_mant, pm.id_catalogo, pm.id_obra, pm.actividad, pm.frecuencia, 
                 pm.tipo_responsable, hom.id_museo, hom.fecha_entrada
        HAVING (
            -- Mantenimiento mensual
            (pm.frecuencia LIKE '%MENSUAL%' AND 
             COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 30 + p_dias_anticipacion) OR
            -- Mantenimiento trimestral
            (pm.frecuencia LIKE '%TRIMESTRAL%' AND 
             COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 90 + p_dias_anticipacion) OR
            -- Mantenimiento semestral
            (pm.frecuencia LIKE '%SEMESTRAL%' AND 
             COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 180 + p_dias_anticipacion) OR
            -- Mantenimiento anual
            (pm.frecuencia LIKE '%ANUAL%' AND 
             COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 365 + p_dias_anticipacion)
        );

BEGIN
    -- Validar que el museo existe si se especifica
    IF p_id_museo IS NOT NULL THEN
        BEGIN
            SELECT 1 INTO v_contador FROM MUSEOS WHERE id_museo = p_id_museo;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20062, 
                    'Error: No existe un museo con ID ' || p_id_museo);
        END;
    END IF;

    v_contador := 0;

    -- Procesar cada obra que requiere mantenimiento
    FOR rec IN c_obras_mantenimiento LOOP
        BEGIN
            -- Buscar un empleado responsable disponible
            SELECT id_empleado
            INTO v_empleado_responsable
            FROM HIST_EMPLEADOS he
            JOIN EMPLEADOS_PROFESIONALES ep ON he.id_empleado_prof = ep.id_empleado
            WHERE he.id_museo = rec.id_museo
              AND he.fecha_fin IS NULL
              AND he.cargo = rec.tipo_responsable
              AND ROWNUM = 1;

            -- Programar el mantenimiento
            INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
                id_mant,
                id_catalogo,
                id_obra,
                id_empleado,
                fecha_inicio,
                observaciones
            ) VALUES (
                rec.id_mant,
                rec.id_catalogo,
                rec.id_obra,
                v_empleado_responsable,
                SYSDATE,
                'Mantenimiento programado automáticamente. Actividad: ' || rec.actividad ||
                '. Frecuencia: ' || rec.frecuencia ||
                '. Último mantenimiento: ' || TO_CHAR(rec.ultima_fecha_mant, 'DD-MON-YYYY')
            );

            v_contador := v_contador + 1;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- No hay empleado disponible del tipo requerido
                CONTINUE;
            WHEN OTHERS THEN
                -- Log el error pero continuar con el siguiente
                CONTINUE;
        END;
    END LOOP;

    p_registros_procesados := v_contador;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20063, 
            'Error inesperado en programación automática de mantenimientos: ' || SQLERRM);
END SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO;
/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_INSERTAR_COLECCION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 13-JUN-2025
-- Descripción:
--Automatiza la insercion de colecciones para que se actualice el orden 
--de recorrido del resto de las colecciones.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_INSERTAR_COLECCION(
    n_nombre_museo IN VARCHAR2, 
    n_nombre_depto IN VARCHAR2,
    n_nombre_coleccion IN VARCHAR2, 
    n_caracteristicas IN VARCHAR2, 
    n_palabra_clave IN VARCHAR2,    
    n_orden_recorrido IN NUMBER) IS v_id_museo NUMBER; v_id_depto NUMBER;
BEGIN
    IF n_orden_recorrido IS NOT NULL AND n_orden_recorrido>0 THEN
        UPDATE COLECCIONES_PERMANENTES SET orden_recorrido = orden_recorrido+1
        WHERE orden_recorrido >= n_orden_recorrido;
    END IF;
    
    SELECT id_museo INTO v_id_museo
    FROM MUSEOS
    WHERE nombre = n_nombre_museo;
    
    SELECT eo.id_est_org INTO v_id_depto
    FROM EST_ORGANIZACIONAL eo
    WHERE eo.id_museo = v_id_museo AND eo.nombre = n_nombre_depto;
    
    INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas,
        palabra_clave, orden_recorrido) VALUES (v_id_depto, v_id_museo, n_nombre_coleccion,
        n_caracteristicas, n_palabra_clave, n_orden_recorrido);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20064, 'Error: Museo "' || n_nombre_museo || '" o Departamento "' || n_nombre_depto || '" no encontrado.');
        WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20065, 'Error: Se encontraron múltiples registros para el Museo "' || n_nombre_museo || '" o el Departamento "' || n_nombre_depto || '".');
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20066, 'Error inesperado al insertar coleccion "' || n_nombre_coleccion || '": ' || SQLERRM);
END SP_INSERTAR_COLECCION;
/    

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: INSERTAR COLECCION
-- -----------------------------------------------------------------------------
/*
EXEC SP_INSERTAR_COLECCION('Musée du Petit Palais', 'Servicio de Exposiciones y Gestión de Colecciones', 'Coleccion Post-Moderna', 'Arte de la era digital y de la información', 'Digital', 3);
*/


-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_MODIFICAR_ORDEN_COLECCION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 13-JUN-2025
-- Descripción:
--Automatiza la modificacion de colecciones para que se actualice el orden 
--de recorrido del resto de las colecciones.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_MODIFICAR_ORDEN_COLECCION
    (n_id_coleccion IN VARCHAR2,
    n_orden_recorrido IN NUMBER) 
    IS
    v_orden_viejo NUMBER;
BEGIN
    
    SELECT orden_recorrido INTO v_orden_viejo
    FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = n_id_coleccion;
    
    IF n_orden_recorrido IS NOT NULL AND n_orden_recorrido > 0 AND n_orden_recorrido != v_orden_viejo THEN
        IF n_orden_recorrido > v_orden_viejo THEN 
            UPDATE COLECCIONES_PERMANENTES
            SET orden_recorrido = orden_recorrido -1
            WHERE orden_recorrido > v_orden_viejo AND
            orden_recorrido <= n_orden_recorrido;
        ELSIF n_orden_recorrido < v_orden_viejo THEN
            UPDATE COLECCIONES_PERMANENTES
            SET orden_recorrido = orden_recorrido +1
            WHERE orden_recorrido < v_orden_viejo AND
            orden_recorrido >= n_orden_recorrido;
        END IF;
        UPDATE COLECCIONES_PERMANENTES
        SET orden_recorrido = n_orden_recorrido
        WHERE id_coleccion = n_id_coleccion;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20064, 'Error: Coleccion "' || n_id_coleccion || 'no encontrado.');
     WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20065, 'Error: Se encontraron múltiples registros la Coleccion "' || n_id_coleccion ||'".');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20066, 'Error inesperado al modificar orden de coleccion "' || n_id_coleccion || '": ' || SQLERRM);
END SP_MODIFICAR_ORDEN_COLECCION;
/


-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: MODIFICAR ORDEN DE RECORRIDO DE UNA COLECCION
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_id_museo NUMBER;
    v_id_coleccion NUMBER;
    v_id_org NUMBER;
BEGIN
    SELECT id_museo INTO v_id_museo
    FROM MUSEOS
    WHERE nombre='Musée du Petit Palais';
    
    SELECT id_est_org INTO v_id_org
    FROM EST_ORGANIZACIONAL
    WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
    id_museo = v_id_museo;
    
    SELECT id_coleccion INTO v_id_coleccion
    FROM COLECCIONES_PERMANENTES
    WHERE
    id_museo = v_id_museo AND
    id_est_org = v_id_org AND
    nombre = 'Coleccion Post-Moderna';
    
    SP_MODIFICAR_ORDEN_COLECCION(v_id_coleccion, 3);
    
END;
/
*/



-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_ELIMINAR_COLECCION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 13-JUN-2025
-- Descripción:
--Automatiza la eliminacion de colecciones para que se actualice el orden 
--de recorrido del resto de las colecciones.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_ELIMINAR_COLECCION (
    p_id_coleccion IN NUMBER 
)
IS
    v_orden_eliminado NUMBER;
BEGIN
    
    SELECT orden_recorrido
    INTO v_orden_eliminado
    FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = p_id_coleccion;

    DELETE FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = p_id_coleccion;

    IF v_orden_eliminado IS NOT NULL THEN
        UPDATE COLECCIONES_PERMANENTES
        SET orden_recorrido = orden_recorrido - 1
        WHERE orden_recorrido > v_orden_eliminado;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20068, 'Error: Colección con ID ' || p_id_coleccion || ' no encontrada para eliminar.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20069, 'Error inesperado al eliminar coleccion con ID ' || p_id_coleccion || ': ' || SQLERRM);
END SP_ELIMINAR_COLECCION;
/

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: ELIMINAR COLECCION
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_id_museo NUMBER;
    v_id_coleccion NUMBER;
    v_id_org NUMBER;
BEGIN
    SELECT id_museo INTO v_id_museo
    FROM MUSEOS
    WHERE nombre='Musée du Petit Palais';
    
    SELECT id_est_org INTO v_id_org
    FROM EST_ORGANIZACIONAL
    WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
    id_museo = v_id_museo;
    
    SELECT id_coleccion INTO v_id_coleccion
    FROM COLECCIONES_PERMANENTES
    WHERE
    id_museo = v_id_museo AND
    id_est_org = v_id_org AND
    nombre = 'Coleccion Post-Moderna';
    
    SP_ELIMINAR_COLECCION(v_id_coleccion);
    
END;
/
*/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_REGISTRAR_OBRA
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 14-JUN-2025
-- Descripción:
-- Automatiza el registro de las obras en un museo
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_REGISTRAR_OBRA_NUEVA
(
    -- DATOS DE LA OBRA
    n_nombre IN OBRAS.nombre%TYPE,
    n_fecha_periodo IN OBRAS.fecha_periodo%TYPE,
    n_tipo_obra IN OBRAS.tipo_obra%TYPE,
    n_dimensiones IN OBRAS.dimensiones%TYPE,
    n_desc_mat_tec IN OBRAS.desc_materiales_tecnicas%TYPE,
    n_desc_estilos IN OBRAS.desc_estilos_generos%TYPE,
    -- DATOS DEL HIST DE LA OBRA
    n_id_museo IN MUSEOS.id_museo%TYPE,
    n_id_coleccion IN COLECCIONES_PERMANENTES.id_coleccion%TYPE,
    n_id_sala IN SALAS_EXP.id_sala%TYPE,
    n_id_empleado IN EMPLEADOS_PROFESIONALES.id_empleado%TYPE,
    n_tipo_adq IN HIST_OBRAS_MOV.tipo_adquisicion%TYPE,
    n_destacada IN HIST_OBRAS_MOV.destacada%TYPE,
    n_orden_recorrido IN HIST_OBRAS_MOV.orden_recorrido%TYPE DEFAULT NULL,
    n_valor_monetario IN HIST_OBRAS_MOV.valor_monetario%TYPE DEFAULT NULL
)
IS
    v_orden_ultima_destacada NUMBER;
    v_orden_primera_nodestacada NUMBER;
    v_id_obra NUMBER;
    v_id_est_org NUMBER;
    v_id_est_fis NUMBER;
    v_orden_ultima_nodestacada NUMBER;
    v_orden_recorrido_final NUMBER; -- Variable local para manejar el orden
BEGIN
    -- INSERTAR LA OBRA EN TABLA OBRAS
    INSERT INTO OBRAS(nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
        VALUES(n_nombre, n_fecha_periodo, n_tipo_obra, n_dimensiones, n_desc_mat_tec, n_desc_estilos)
        RETURNING id_obra INTO v_id_obra;
    
    IF n_destacada = 'SI' THEN
        IF n_orden_recorrido IS NOT NULL AND n_orden_recorrido > 0 THEN
            v_orden_recorrido_final := n_orden_recorrido;
            UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido+1
            WHERE id_museo = n_id_museo AND
            orden_recorrido >= v_orden_recorrido_final AND
            fecha_salida IS NULL;
        ELSIF n_orden_recorrido IS NULL THEN
            -- SELECCIONA EL ORDEN DE RECORRIDO DE LA ULTIMA OBRA DESTACADA
            SELECT NVL(MAX(orden_recorrido), 0) INTO v_orden_ultima_destacada
            FROM HIST_OBRAS_MOV
            WHERE id_museo = n_id_museo AND
            destacada = 'SI' AND
            orden_recorrido IS NOT NULL;
            
            v_orden_recorrido_final := v_orden_ultima_destacada+1;
            
            UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido+1
            WHERE id_museo = n_id_museo AND
            destacada = 'NO' AND
            fecha_salida IS NULL;
        END IF;
    ELSIF n_destacada = 'NO'THEN
        SELECT NVL(MAX(orden_recorrido), 0) + 1 INTO v_orden_primera_nodestacada
            FROM HIST_OBRAS_MOV
            WHERE id_museo = n_id_museo AND
            destacada = 'SI' AND
            orden_recorrido IS NOT NULL AND
            fecha_salida IS NULL;
        IF n_orden_recorrido IS NOT NULL AND n_orden_recorrido > 0 THEN
            IF n_orden_recorrido < v_orden_primera_nodestacada THEN
                RAISE_APPLICATION_ERROR(-20200, 'La obra no destacada no puede 
                    tener un orden de recorrido mayor o igual a una destacada');
            ELSE
                v_orden_recorrido_final := n_orden_recorrido;
                UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido+1
                WHERE id_museo = n_id_museo AND
                orden_recorrido >= v_orden_recorrido_final AND
                fecha_salida IS NULL;
            END IF;
        ELSIF n_orden_recorrido IS NULL THEN
            SELECT NVL(MAX(orden_recorrido), 0) INTO v_orden_ultima_nodestacada
            FROM HIST_OBRAS_MOV
            WHERE id_museo = n_id_museo AND
            destacada = 'NO' AND
            orden_recorrido IS NOT NULL AND
            fecha_salida IS NULL;
            v_orden_recorrido_final := v_orden_ultima_nodestacada+1;
        END IF;
    END IF;
    
    -- CONSULTA PARA ENCONTRAR A LA EST_ORG
    SELECT id_est_org INTO v_id_est_org
    FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = n_id_coleccion;
    
    --CONSULTA PARA ENCONTRAR A LA EST_FIS
    SELECT id_est INTO v_id_est_fis
    FROM SALAS_EXP  
    WHERE id_sala = n_id_sala;
    
    
    INSERT INTO HIST_OBRAS_MOV(id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, 
        id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
        VALUES(v_id_obra, n_id_coleccion, n_id_sala, n_id_empleado, v_id_est_org, n_id_museo, 
        v_id_est_fis, SYSDATE,n_tipo_adq, n_destacada, NULL, v_orden_recorrido_final, n_valor_monetario);
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20100, 'Error inesperado en SP_REGISTRAR_OBRA_NUEVA: ' || SQLERRM);
END SP_REGISTRAR_OBRA_NUEVA;
/






-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_MOVER_OBRA
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 14-JUN-2025
-- Descripción:
-- Automatiza el movimiento de una obra en un museo, o hacia otro museo
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_MOVER_OBRA
(
    n_id_obra IN OBRAS.id_obra%TYPE,
    p_id_museo_destino IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_id_coleccion_destino IN COLECCIONES_PERMANENTES.id_coleccion%TYPE DEFAULT NULL,
    p_id_sala_destino IN SALAS_EXP.id_sala%TYPE DEFAULT NULL,
    p_id_empleado_destino IN EMPLEADOS_PROFESIONALES.id_empleado%TYPE DEFAULT NULL, -- Empleado encargado de la obra en el destino (opcional)
    p_tipo_adq_destino IN HIST_OBRAS_MOV.tipo_adquisicion%TYPE DEFAULT NULL,
    p_destacada_destino IN HIST_OBRAS_MOV.destacada%TYPE DEFAULT NULL,
    p_orden_recorrido_destino IN HIST_OBRAS_MOV.orden_recorrido%TYPE DEFAULT NULL,
    p_valor_monetario_destino IN HIST_OBRAS_MOV.valor_monetario%TYPE DEFAULT NULL
)
IS
    
    v_current_id_hist          HIST_OBRAS_MOV.id_catalogo_museo%TYPE;
    v_current_museo_id         MUSEOS.id_museo%TYPE;
    v_current_coleccion_id     COLECCIONES_PERMANENTES.id_coleccion%TYPE;
    v_current_sala_id          SALAS_EXP.id_sala%TYPE;
    v_current_tipo_adq         HIST_OBRAS_MOV.tipo_adquisicion%TYPE;
    v_current_destacada        HIST_OBRAS_MOV.destacada%TYPE;
    v_current_valor_monetario  HIST_OBRAS_MOV.valor_monetario%TYPE;
    v_current_id_empleado      EMPLEADOS_PROFESIONALES.id_empleado%TYPE;
    v_current_orden_recorrido  HIST_OBRAS_MOV.orden_recorrido%TYPE;

    
    v_id_museo_destino_final         MUSEOS.id_museo%TYPE;
    v_id_coleccion_destino_final     COLECCIONES_PERMANENTES.id_coleccion%TYPE;
    v_id_sala_destino_final          SALAS_EXP.id_sala%TYPE;
    v_id_empleado_destino_final      EMPLEADOS_PROFESIONALES.id_empleado%TYPE; 
    v_tipo_adq_destino_final         HIST_OBRAS_MOV.tipo_adquisicion%TYPE;
    v_destacada_destino_final        HIST_OBRAS_MOV.destacada%TYPE;
    v_orden_recorrido_destino_final  HIST_OBRAS_MOV.orden_recorrido%TYPE;
    v_valor_monetario_destino_final  HIST_OBRAS_MOV.valor_monetario%TYPE;


    v_orden_ultima_destacada NUMBER;
    v_orden_primera_nodestacada NUMBER;
    v_orden_ultima_nodestacada NUMBER;


    v_id_est_org_destino NUMBER;
    v_id_est_fis_destino NUMBER;

BEGIN
    -- ENCONTRAR LOS VALORES ACTUALES DEL REGISTRO HISTORICO DE LA OBRA
    BEGIN
        SELECT id_catalogo_museo, id_museo, id_coleccion, id_sala,
               tipo_adquisicion, destacada, valor_monetario, id_empleado, orden_recorrido
        INTO v_current_id_hist, v_current_museo_id, v_current_coleccion_id, v_current_sala_id,
             v_current_tipo_adq, v_current_destacada, v_current_valor_monetario, v_current_id_empleado, v_current_orden_recorrido
        FROM HIST_OBRAS_MOV
        WHERE id_obra = n_id_obra
        AND fecha_salida IS NULL; 
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se encontró un registro activo para la obra con ID ' || n_id_obra || '. La obra no está en un lugar registrado o ya tiene fecha de salida.');
    END;

    -- SE ASIGNA LOS VALORES A DONDE SE QUIERE MOVER LA OBRA
    v_id_museo_destino_final        := NVL(p_id_museo_destino, v_current_museo_id);
    v_id_coleccion_destino_final    := NVL(p_id_coleccion_destino, v_current_coleccion_id);
    v_id_sala_destino_final         := NVL(p_id_sala_destino, v_current_sala_id);
    v_id_empleado_destino_final     := NVL(p_id_empleado_destino, v_current_id_empleado);
    v_tipo_adq_destino_final        := NVL(p_tipo_adq_destino, v_current_tipo_adq);
    v_destacada_destino_final       := NVL(p_destacada_destino, v_current_destacada);
    v_valor_monetario_destino_final := NVL(p_valor_monetario_destino, v_current_valor_monetario);


    -- VALIDAR SI LA OBRA YA SE ENCUENTRA DONDE SE QUIERE MOVER
    IF v_id_museo_destino_final = v_current_museo_id AND
       v_id_coleccion_destino_final = v_current_coleccion_id AND
       v_id_sala_destino_final = v_current_sala_id AND
       v_id_empleado_destino_final = v_current_id_empleado AND 
       v_tipo_adq_destino_final = v_current_tipo_adq AND
       v_destacada_destino_final = v_current_destacada AND
       v_valor_monetario_destino_final = v_current_valor_monetario
       THEN
        RAISE_APPLICATION_ERROR(-20002, 'La obra ya se encuentra en la ubicación de destino especificada sin cambios relevantes.');
    END IF;

    -- SE CIERRA EL ANTERIOR REGISTRO HISTORICO ACTIVO DE ESTA OBRA
    UPDATE HIST_OBRAS_MOV
    SET fecha_salida = SYSDATE
    WHERE id_catalogo_museo = v_current_id_hist;

   
    -- SE AJUSTA EL ORDEN DE RECORRIDO DEPENDIENDO DE LO QUE SE COLOQUE


    IF p_orden_recorrido_destino IS NULL AND v_current_orden_recorrido IS NOT NULL AND v_destacada_destino_final = v_current_destacada THEN
        v_orden_recorrido_destino_final := v_current_orden_recorrido;
    ELSE
        IF v_destacada_destino_final = 'SI' THEN
            IF p_orden_recorrido_destino IS NOT NULL AND p_orden_recorrido_destino > 0 THEN
                v_orden_recorrido_destino_final := p_orden_recorrido_destino;
                UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido + 1
                WHERE id_museo = v_id_museo_destino_final AND
                orden_recorrido >= v_orden_recorrido_destino_final
                AND fecha_salida IS NULL;
            ELSIF p_orden_recorrido_destino IS NULL THEN
                -- SE COLOCA AL FINAL DE LAS OBRAS DESTACADAS
                SELECT NVL(MAX(orden_recorrido), 0) INTO v_orden_ultima_destacada
                FROM HIST_OBRAS_MOV
                WHERE id_museo = v_id_museo_destino_final AND
                destacada = 'SI' AND
                orden_recorrido IS NOT NULL
                AND fecha_salida IS NULL;
    
                v_orden_recorrido_destino_final := v_orden_ultima_destacada + 1;
    
                -- DESPLAZAR LAS OBRAS NO DESTACADAS DE SER NECESARIO
                UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido + 1
                WHERE id_museo = v_id_museo_destino_final AND
                destacada = 'NO'
                AND fecha_salida IS NULL;
            END IF;
        ELSIF v_destacada_destino_final = 'NO' THEN
            -- CONSULTA PARA OBTENER LA PRIMERA OBRA NO DESTACADA
            SELECT NVL(MAX(orden_recorrido), 0) + 1 INTO v_orden_primera_nodestacada
            FROM HIST_OBRAS_MOV
            WHERE id_museo = v_id_museo_destino_final AND
            destacada = 'SI' AND
            orden_recorrido IS NOT NULL
            AND fecha_salida IS NULL;
    
            IF p_orden_recorrido_destino IS NOT NULL AND p_orden_recorrido_destino > 0 THEN
                IF p_orden_recorrido_destino < v_orden_primera_nodestacada THEN
                    RAISE_APPLICATION_ERROR(-20204, 'La obra no destacada no puede tener un orden de recorrido menor al siguiente disponible después de las destacadas en el museo destino.');
                ELSE
                    v_orden_recorrido_destino_final := p_orden_recorrido_destino;
                    UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido + 1
                    WHERE id_museo = v_id_museo_destino_final AND
                    orden_recorrido >= v_orden_recorrido_destino_final
                    AND fecha_salida IS NULL; 
                END IF;
            ELSIF p_orden_recorrido_destino IS NULL THEN
                -- SE COLOCAL AL FINAL DE LAS OBRAS NO DESTACADAS
                SELECT NVL(MAX(orden_recorrido), 0) INTO v_orden_ultima_nodestacada
                FROM HIST_OBRAS_MOV
                WHERE id_museo = v_id_museo_destino_final AND
                destacada = 'NO' AND
                orden_recorrido IS NOT NULL
                AND fecha_salida IS NULL; 
    
                v_orden_recorrido_destino_final := v_orden_ultima_nodestacada + 1;
            END IF;
        END IF;
    END IF;
    
    -- ENCONTRAR LA EST ORG DE LA COLECCION Y LE EST FIS DE LA SALA
    
    SELECT id_est_org INTO v_id_est_org_destino
    FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = v_id_coleccion_destino_final;

    SELECT id_est INTO v_id_est_fis_destino
    FROM SALAS_EXP
    WHERE id_sala = v_id_sala_destino_final;

    
    -- INSERTAR LOS NUEVOS REGISTROS DE LAS OBRAS
    
    INSERT INTO HIST_OBRAS_MOV
    (
        id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo,
        id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida,
        orden_recorrido, valor_monetario
    )
    VALUES
    (
        n_id_obra, v_id_coleccion_destino_final, v_id_sala_destino_final, v_id_empleado_destino_final,
        v_id_est_org_destino, v_id_museo_destino_final, v_id_est_fis_destino,
        SYSDATE, v_tipo_adq_destino_final, v_destacada_destino_final, NULL,
        v_orden_recorrido_destino_final, v_valor_monetario_destino_final
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error: Datos no encontrados durante el movimiento de la obra. ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20005, 'Error inesperado en SP_MOVER_OBRA: ' || SQLERRM);
END SP_MOVER_OBRA;
/

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: MOVER OBRA
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_id_museo NUMBER;
    v_id_obra NUMBER;
    v_id_sala NUMBER;
BEGIN
    
    SELECT id_museo INTO v_id_museo
    FROM MUSEOS
    WHERE nombre= 'Musée du Petit Palais';
    
    
    SELECT id_obra INTO v_id_obra
    FROM OBRAS
    WHERE nombre = 'Ugolino' AND
    tipo_obra = 'ESCULTURA';
    
    SELECT id_sala INTO v_id_sala
    FROM SALAS_EXP
    WHERE id_museo = v_id_museo AND
    nombre = 'GALERIE TUCK';
    
    
    

    SP_MOVER_OBRA(
        n_id_obra               => v_id_obra,           -- Reemplaza con el ID de tu obra
        p_id_sala_destino       => v_id_sala,     -- ID de la nueva sala
        p_id_empleado_destino   => NULL,                 -- Usará el empleado actual
        p_tipo_adq_destino      => NULL,                 -- Usará el tipo de adquisición actual
        p_destacada_destino     => NULL,                 -- Usará el estado destacada actual (SI o NO)
        p_orden_recorrido_destino => NULL,               -- Se calculará automáticamente si es necesario
        p_valor_monetario_destino => NULL                -- Usará el valor monetario actual
    );

    COMMIT;
END;
/
*/


-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_MOVER_EMPLEADO_ACTVO
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 14-JUN-2025
-- Descripción:
-- Automatiza el movimiento de un empleado activo
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_MOVER_EMPLEADO_ACTIVO
(
    n_id_empleado IN EMPLEADOS_PROFESIONALES.id_empleado%TYPE,
    n_id_museo IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    n_id_est_org IN EST_ORGANIZACIONAL.id_est_org%TYPE DEFAULT NULL,
    n_cargo IN HIST_EMPLEADOS.cargo%TYPE DEFAULT NULL
)
IS
    v_current_museo HIST_EMPLEADOS.id_museo%TYPE;
    v_current_org HIST_EMPLEADOS.id_est_org%TYPE;
    v_current_cargo HIST_EMPLEADOS.cargo%TYPE;
    v_current_fecha_inicio HIST_EMPLEADOS.fecha_inicio%TYPE;
    v_destino_museo HIST_EMPLEADOS.id_museo%TYPE;
    v_destino_org HIST_EMPLEADOS.id_est_org%TYPE;
    v_destino_cargo HIST_EMPLEADOS.cargo%TYPE;
BEGIN

    BEGIN
        SELECT fecha_inicio, id_museo, id_est_org, cargo
        INTO v_current_fecha_inicio, v_current_museo, v_current_org, v_current_cargo
        FROM HIST_EMPLEADOS
        WHERE id_empleado_prof = n_id_empleado AND
        fecha_fin IS NULL;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20401, 'Error: No se encontró un registro histórico ACTIVO para el empleado con ID ' || n_id_empleado || '. Este procedimiento es solo para empleados activos.');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20402, 'Error de consistencia de datos: El empleado con ID ' || n_id_empleado || ' tiene múltiples registros históricos activos (fecha_fin IS NULL).');
    END;

    v_destino_museo := NVL(n_id_museo, v_current_museo);
    v_destino_org := NVL(n_id_est_org, v_current_org);
    v_destino_cargo := NVL(n_cargo, v_current_cargo);
    
    IF v_destino_museo = v_current_museo AND
       v_destino_org = v_current_org AND
       v_destino_cargo = v_current_cargo THEN
        RAISE_APPLICATION_ERROR(-20403, 'No hay cambios en la ubicación o cargo del empleado. Operación no realizada.');
    END IF;
    
    
    UPDATE HIST_EMPLEADOS SET fecha_fin = SYSDATE
    WHERE id_empleado_prof = n_id_empleado AND
    id_museo = v_current_museo AND
    id_est_org = v_current_org AND
    fecha_inicio = v_current_fecha_inicio;
    
    INSERT INTO HIST_EMPLEADOS(fecha_inicio, id_est_org, id_museo, id_empleado_prof,
        cargo, fecha_fin) VALUES (SYSDATE, v_destino_org, v_destino_museo, n_id_empleado,
        v_destino_cargo, NULL);

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20405, 'Error inesperado en SP_MOVER_EMPLEADO_ACTIVO: ' || SQLERRM);
END SP_MOVER_EMPLEADO_ACTIVO;
/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_MOVER_EMPLEADO_INACTIVO
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 14-JUN-2025
-- Descripción:
-- Automatiza el movimiento de un empleado inactivo, con historico cerrado en ese
-- museo o un nuevo empleado en general
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_MOVER_EMPLEADO_INACTIVO
(
    n_id_empleado IN HIST_EMPLEADOS.id_empleado_prof%TYPE,
    n_id_museo IN HIST_EMPLEADOS.id_museo%TYPE,
    n_id_est_org IN HIST_EMPLEADOS.id_est_org%TYPE,
    n_cargo IN HIST_EMPLEADOS.cargo%TYPE
)
IS
BEGIN
    
    INSERT INTO HIST_EMPLEADOS(fecha_inicio, id_est_org, id_museo, id_empleado_prof,
        cargo, fecha_fin) VALUES (SYSDATE, n_id_est_org, n_id_museo, n_id_empleado,
        n_cargo, NULL);

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20406, 'Error inesperado en SP_MOVER_EMPLEADO_INACTIVO: ' || SQLERRM);
END SP_MOVER_EMPLEADO_INACTIVO;
/

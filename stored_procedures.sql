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
    SELECT id_museo INTO v_museo_id FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle';

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
    SELECT id_museo INTO v_museo_id FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig';

    -- Llamar al procedimiento para registrar un nuevo Restaurador
    SP_REGISTRAR_NUEVO_EMPLEADO(
        p_doc_identidad      => 30000001,
        p_primer_nombre      => 'Clara',
        p_primer_apellido    => 'Schulz',
        p_fecha_nacimiento   => TO_DATE('1990-08-15', 'YYYY-MM-DD'),
        p_contacto           => 491798765432,
        p_id_museo           => v_museo_id,
        p_nombre_unidad_org  => 'Departamento de Curaduría y Colecciones MdbK',
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
    SELECT id_expo, id_museo 
    INTO v_id_exposicion, v_id_museo_expo
    FROM EXPOSICIONES_EVENTOS
    WHERE nombre LIKE 'Impresionismo en Transición%' AND ROWNUM = 1;

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
END;
/
*/



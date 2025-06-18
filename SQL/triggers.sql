-- -----------------------------------------------------------------------------
-- NOTA: TRIGGER TRG_TICKETS_BEFORE_INSERT REMOVIDO
-- -----------------------------------------------------------------------------
-- Fecha de Eliminación: [FECHA ACTUAL]
-- Razón: Por indicación de la tutora, este trigger es innecesario ya que:
-- - No existe concurrencia real en el sistema
-- - La lógica puede manejarse desde el backend de manera más sencilla
-- 
-- Funcionalidades que deben implementarse en el backend:
-- - Generación secuencial de id_num_ticket por museo
-- - Consulta y asignación de precios desde TIPO_TICKETS
-- - Validaciones de integridad de datos
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- PAQUETE DE ESTADO PARA TRIGGERS
-- -----------------------------------------------------------------------------
-- Descripción: Este paquete previene errores de tabla mutante en triggers
-- al mantener un estado global que puede ser consultado para evitar
-- ejecuciones recursivas no deseadas.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE trigger_state_pkg AS
  g_is_updating BOOLEAN := FALSE;
END trigger_state_pkg;
/

-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_MANEJAR_HIST_EMPLEADOS (Versión Final con Compound Trigger y Paquete de Estado)
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 09-JUN-2025 (Refactorización Final)
-- Descripción:
-- Reemplaza la versión anterior con un Compound Trigger que utiliza un paquete
-- de estado (trigger_state_pkg) para solucionar el error de tabla mutante (ORA-04091)
-- que ocurría por llamadas recursivas.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_MANEJAR_HIST_EMPLEADOS
FOR INSERT OR UPDATE ON HIST_EMPLEADOS
COMPOUND TRIGGER
    -- 1. Declaración de una colección para almacenar los datos de las filas insertadas
    TYPE t_empleado_hist_rec IS RECORD (
        id_empleado_prof HIST_EMPLEADOS.id_empleado_prof%TYPE,
        fecha_inicio     HIST_EMPLEADOS.fecha_inicio%TYPE
    );
    TYPE t_empleado_hist_table IS TABLE OF t_empleado_hist_rec INDEX BY PLS_INTEGER;
    g_new_empleados t_empleado_hist_table;

    -- 2. BEFORE EACH ROW: Se ejecuta antes de cada operación de fila.
    BEFORE EACH ROW IS
        v_overlap_count NUMBER;
    BEGIN
        -- Solo ejecutar la validación si NO estamos en medio del UPDATE del propio trigger.
        IF UPDATING AND NOT trigger_state_pkg.g_is_updating THEN
            -- Prevenir solapamiento de fechas al actualizar
            SELECT COUNT(*)
            INTO v_overlap_count
            FROM HIST_EMPLEADOS
            WHERE id_empleado_prof = :NEW.id_empleado_prof
              AND ROWID != :OLD.ROWID -- Excluir la fila que se está actualizando
              AND fecha_inicio <= NVL(:NEW.fecha_fin, TO_DATE('9999-12-31', 'YYYY-MM-DD'))
              AND NVL(fecha_fin, TO_DATE('9999-12-31', 'YYYY-MM-DD')) >= :NEW.fecha_inicio;

            IF v_overlap_count > 0 THEN
                RAISE_APPLICATION_ERROR(-20003, 'Error: La actualización crearía un solapamiento de fechas para el empleado ID ' || :NEW.id_empleado_prof || '.');
            END IF;
        END IF;
    END BEFORE EACH ROW;

    -- 3. AFTER EACH ROW: Recopila la información de las filas insertadas.
    AFTER EACH ROW IS
    BEGIN
        IF INSERTING THEN
            g_new_empleados(g_new_empleados.COUNT + 1).id_empleado_prof := :NEW.id_empleado_prof;
            g_new_empleados(g_new_empleados.COUNT).fecha_inicio     := :NEW.fecha_inicio;
        END IF;
    END AFTER EACH ROW;

    -- 4. AFTER STATEMENT: Se ejecuta una sola vez al final de la sentencia.
    AFTER STATEMENT IS
    BEGIN
        IF INSERTING AND g_new_empleados.COUNT > 0 THEN
            -- Establecer el flag para indicar que el trigger está actualizando la tabla
            trigger_state_pkg.g_is_updating := TRUE;

            FOR i IN 1..g_new_empleados.COUNT LOOP
                -- Cerrar el registro de historial anterior para cada empleado insertado.
                UPDATE HIST_EMPLEADOS
                SET fecha_fin = g_new_empleados(i).fecha_inicio
                WHERE id_empleado_prof = g_new_empleados(i).id_empleado_prof
                  AND fecha_fin IS NULL
                  AND fecha_inicio < g_new_empleados(i).fecha_inicio;
            END LOOP;
            
            -- Restablecer el flag
            trigger_state_pkg.g_is_updating := FALSE;
        END IF;

        g_new_empleados.DELETE;
    EXCEPTION
        WHEN OTHERS THEN
            -- Asegurarse de restablecer el flag y limpiar la colección en caso de error
            trigger_state_pkg.g_is_updating := FALSE;
            g_new_empleados.DELETE;
            RAISE; -- Relanzar la excepción
    END AFTER STATEMENT;

END TRG_MANEJAR_HIST_EMPLEADOS;
/


-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_HIST_OBRAS_MOV_FECHAS (Versión Refactorizada con Compound Trigger)
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 09-JUN-2025 (Refactorización)
-- Descripción:
-- Este trigger gestiona la cadena de custodia de las obras en HIST_OBRAS_MOV.
-- Utiliza un Compound Trigger para evitar el error de tabla mutante (ORA-04091)
-- que ocurría al intentar leer y escribir en la misma tabla durante una inserción.
-- 1. Recopila las filas insertadas en una colección en memoria.
-- 2. Al final de la sentencia, actualiza el registro de movimiento anterior para
--    cada obra, estableciendo su `fecha_salida` y asegurando la consistencia.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_HIST_OBRAS_MOV_FECHAS
FOR INSERT ON HIST_OBRAS_MOV
COMPOUND TRIGGER
    -- Colección para almacenar temporalmente los datos de las filas recién insertadas
    TYPE t_obra_hist_rec IS RECORD (
        id_obra       HIST_OBRAS_MOV.id_obra%TYPE,
        fecha_entrada HIST_OBRAS_MOV.fecha_entrada%TYPE,
        row_id        UROWID -- Guardamos el ROWID para excluir el registro actual de las validaciones
    );
    TYPE t_obra_hist_table IS TABLE OF t_obra_hist_rec INDEX BY PLS_INTEGER;
    g_new_obras t_obra_hist_table;

    -- Se ejecuta después de cada operación de inserción de fila
    AFTER EACH ROW IS
    BEGIN
        -- Almacenar los datos clave de la nueva fila en la colección para su posterior procesamiento
        g_new_obras(g_new_obras.COUNT + 1).id_obra := :NEW.id_obra;
        g_new_obras(g_new_obras.COUNT).fecha_entrada := :NEW.fecha_entrada;
        g_new_obras(g_new_obras.COUNT).row_id := :NEW.ROWID;
    END AFTER EACH ROW;

    -- Se ejecuta una sola vez, después de que se complete toda la sentencia INSERT
    AFTER STATEMENT IS
    BEGIN
        -- Solo proceder si se insertaron filas en esta transacción
        IF g_new_obras.COUNT > 0 THEN
        
            FOR i IN 1..g_new_obras.COUNT LOOP
                
                -- Se valida la consistencia de los datos antes de actualizar.
                -- Contamos cuántos registros de historial "abiertos" (sin fecha de salida)
                -- existen para la obra, excluyendo el que acabamos de insertar.
                DECLARE
                    v_open_records_count NUMBER;
                BEGIN
                    SELECT COUNT(*)
                    INTO v_open_records_count
                    FROM HIST_OBRAS_MOV
                    WHERE id_obra = g_new_obras(i).id_obra
                      AND fecha_salida IS NULL
                      -- Excluimos la fila recién insertada del conteo para no interferir
                      AND ROWID != g_new_obras(i).row_id;

                    -- Si hay más de un registro abierto, es un estado de datos inconsistente.
                    -- Una obra no puede estar en dos lugares activos al mismo tiempo.
                    IF v_open_records_count > 1 THEN
                        RAISE_APPLICATION_ERROR(-20004, 
                            'Error de consistencia de datos: La obra con ID ' || g_new_obras(i).id_obra || 
                            ' tiene múltiples registros de historial abiertos. No se puede determinar la ubicación anterior.');
                    
                    -- Si hay exactamente un registro abierto, se procede a actualizarlo para "cerrarlo".
                    ELSIF v_open_records_count = 1 THEN
                        UPDATE HIST_OBRAS_MOV
                        SET fecha_salida = g_new_obras(i).fecha_entrada
                        WHERE id_obra = g_new_obras(i).id_obra
                          AND fecha_salida IS NULL
                          AND ROWID != g_new_obras(i).row_id;
                    END IF;
                    -- Si v_open_records_count = 0, es el primer movimiento histórico y no se hace nada.
                END;
            END LOOP;
            
        END IF;

        -- Limpiar la colección para la siguiente ejecución del trigger
        g_new_obras.DELETE;
    EXCEPTION
        WHEN OTHERS THEN
            -- En caso de un error inesperado, limpiar la colección y relanzar la excepción
            g_new_obras.DELETE;
            RAISE_APPLICATION_ERROR(-20005, 'Error inesperado en el trigger TRG_HIST_OBRAS_MOV_FECHAS (Post-Statement): ' || SQLERRM);
    END AFTER STATEMENT;

END TRG_HIST_OBRAS_MOV_FECHAS;
/

-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_EVITAR_CIERRE_CON_EXPOSICION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Este trigger se dispara antes de insertar un nuevo registro en CIERRES_TEMPORALES.
-- Previene que se agende un cierre para una sala si existe una exposición o evento
-- programado que se solape con las fechas del cierre. Esto garantiza la
-- integridad de la planificación de eventos del museo.
-- -----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRG_EVITAR_CIERRE_CON_EXPOSICION
BEFORE INSERT ON CIERRES_TEMPORALES
FOR EACH ROW
DECLARE
    -- Variable para contar las exposiciones que se solapan.
    v_expo_count NUMBER;
BEGIN
    -- Contamos cuántas exposiciones o eventos existentes en la misma sala
    -- tienen un rango de fechas que se solapa con el nuevo rango de cierre.
    -- La condición de solapamiento es: (Inicio1 <= Fin2) y (Inicio2 <= Fin1).
    -- NVL se usa para manejar cierres con fecha de fin abierta (indefinida).
    SELECT COUNT(*)
    INTO v_expo_count
    FROM EXPOSICIONES_EVENTOS
    WHERE id_sala = :NEW.id_sala
      AND id_est = :NEW.id_est
      AND id_museo = :NEW.id_museo
      -- Condición de solapamiento de fechas
      AND fecha_inicio <= NVL(:NEW.fecha_fin, TO_DATE('9999-12-31', 'YYYY-MM-DD'))
      AND fecha_fin >= :NEW.fecha_inicio;

    -- Si se encuentra al menos una exposición que se solapa, se lanza un error.
    IF v_expo_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 
            'Error: No se puede programar el cierre. Existe una exposición programada en la sala ' || 
            :NEW.id_sala || ' (Museo ID: ' || :NEW.id_museo || ') que se solapa con las fechas ' ||
            TO_CHAR(:NEW.fecha_inicio, 'YYYY-MM-DD') || ' a ' || 
            TO_CHAR(NVL(:NEW.fecha_fin, SYSDATE), 'YYYY-MM-DD') || '.');
    END IF;

EXCEPTION
    -- Captura de cualquier otro error inesperado durante la operación.
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20007, 'Error inesperado en el trigger TRG_EVITAR_CIERRE_CON_EXPOSICION: ' || SQLERRM);

END TRG_EVITAR_CIERRE_CON_EXPOSICION;
/

-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_MANEJAR_MANTENIMIENTOS_OBRAS (Versión Refactorizada con Compound Trigger)
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 09-JUN-2025 (Refactorización)
-- Descripción:
-- Automatiza la gestión de mantenimientos de obras utilizando un Compound Trigger
-- para evitar el error de tabla mutante (ORA-04091):
-- - Cierra automáticamente mantenimientos anteriores cuando se inicia uno nuevo
-- - Registra observaciones de traspaso entre mantenimientos
-- - Implementa mejores prácticas de manejo de errores
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_MANEJAR_MANTENIMIENTOS_OBRAS
FOR INSERT ON MANTENIMIENTOS_OBRAS_REALIZADOS
COMPOUND TRIGGER
    -- Colección para almacenar temporalmente los datos de las filas recién insertadas
    TYPE t_mant_rec IS RECORD (
        id_catalogo   MANTENIMIENTOS_OBRAS_REALIZADOS.id_catalogo%TYPE,
        id_obra       MANTENIMIENTOS_OBRAS_REALIZADOS.id_obra%TYPE,
        id_empleado   MANTENIMIENTOS_OBRAS_REALIZADOS.id_empleado%TYPE,
        fecha_inicio  MANTENIMIENTOS_OBRAS_REALIZADOS.fecha_inicio%TYPE,
        row_id        UROWID
    );
    TYPE t_mant_table IS TABLE OF t_mant_rec INDEX BY PLS_INTEGER;
    g_new_mantenimientos t_mant_table;

    -- Se ejecuta después de cada operación de inserción de fila
    AFTER EACH ROW IS
    BEGIN
        -- Almacenar los datos clave de la nueva fila en la colección
        g_new_mantenimientos(g_new_mantenimientos.COUNT + 1).id_catalogo := :NEW.id_catalogo;
        g_new_mantenimientos(g_new_mantenimientos.COUNT).id_obra := :NEW.id_obra;
        g_new_mantenimientos(g_new_mantenimientos.COUNT).id_empleado := :NEW.id_empleado;
        g_new_mantenimientos(g_new_mantenimientos.COUNT).fecha_inicio := :NEW.fecha_inicio;
        g_new_mantenimientos(g_new_mantenimientos.COUNT).row_id := :NEW.ROWID;
    END AFTER EACH ROW;

    -- Se ejecuta una sola vez, después de que se complete toda la sentencia INSERT
    AFTER STATEMENT IS
    BEGIN
        -- Solo proceder si se insertaron filas en esta transacción
        IF g_new_mantenimientos.COUNT > 0 THEN
        
            FOR i IN 1..g_new_mantenimientos.COUNT LOOP
                DECLARE
                    v_mant_abiertos NUMBER := 0;
                    v_empleado_anterior NUMBER;
                    v_fecha_anterior DATE;
                BEGIN
                    -- Verificar si hay mantenimientos abiertos para la misma obra (excluyendo el recién insertado)
                    SELECT COUNT(*), MAX(id_empleado), MAX(fecha_inicio)
                    INTO v_mant_abiertos, v_empleado_anterior, v_fecha_anterior
                    FROM MANTENIMIENTOS_OBRAS_REALIZADOS
                    WHERE id_catalogo = g_new_mantenimientos(i).id_catalogo
                      AND id_obra = g_new_mantenimientos(i).id_obra
                      AND fecha_fin IS NULL
                      AND ROWID != g_new_mantenimientos(i).row_id;

                    -- Si hay mantenimientos abiertos, cerrarlos automáticamente
                    IF v_mant_abiertos > 0 THEN
                        UPDATE MANTENIMIENTOS_OBRAS_REALIZADOS
                        SET fecha_fin = g_new_mantenimientos(i).fecha_inicio,
                            observaciones = COALESCE(observaciones || '; ', '') || 
                                          'Cerrado automáticamente por nuevo mantenimiento iniciado el ' ||
                                          TO_CHAR(g_new_mantenimientos(i).fecha_inicio, 'DD-MON-YYYY') ||
                                          ' por empleado ID ' || g_new_mantenimientos(i).id_empleado
                        WHERE id_catalogo = g_new_mantenimientos(i).id_catalogo
                          AND id_obra = g_new_mantenimientos(i).id_obra
                          AND fecha_fin IS NULL
                          AND ROWID != g_new_mantenimientos(i).row_id;

                        -- Agregar observación al nuevo mantenimiento sobre el anterior
                        UPDATE MANTENIMIENTOS_OBRAS_REALIZADOS
                        SET observaciones = COALESCE(observaciones || '; ', '') ||
                                           'Continúa mantenimiento anterior del empleado ID ' || v_empleado_anterior ||
                                           ' iniciado el ' || TO_CHAR(v_fecha_anterior, 'DD-MON-YYYY')
                        WHERE ROWID = g_new_mantenimientos(i).row_id;
                    END IF;
                END;
            END LOOP;
            
        END IF;

        -- Limpiar la colección para la siguiente ejecución del trigger
        g_new_mantenimientos.DELETE;
    EXCEPTION
        WHEN OTHERS THEN
            -- En caso de un error inesperado, limpiar la colección y relanzar la excepción
            g_new_mantenimientos.DELETE;
            RAISE_APPLICATION_ERROR(-20060, 
                'Error en automatización de mantenimientos (Post-Statement): ' || SQLERRM);
    END AFTER STATEMENT;

END TRG_MANEJAR_MANTENIMIENTOS_OBRAS;
/

-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_AUTOMATIZAR_CIERRES_TEMPORALES
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Automatiza la gestión de cierres temporales de salas:
-- - Cierra automáticamente cierres anteriores cuando se programa uno nuevo
-- - Valida que no haya conflictos con exposiciones activas
-- - Registra el motivo del cierre del período anterior
-- -----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRG_AUTOMATIZAR_CIERRES_TEMPORALES
BEFORE INSERT ON CIERRES_TEMPORALES
FOR EACH ROW
DECLARE
    v_cierres_abiertos NUMBER := 0;
    v_fecha_anterior DATE;
BEGIN
    -- Verificar si hay cierres abiertos para la misma sala
    SELECT COUNT(*), MAX(fecha_inicio)
    INTO v_cierres_abiertos, v_fecha_anterior
    FROM CIERRES_TEMPORALES
    WHERE id_sala = :NEW.id_sala
      AND id_est = :NEW.id_est
      AND id_museo = :NEW.id_museo
      AND fecha_fin IS NULL;

    -- Si hay cierres abiertos, cerrarlos automáticamente
    IF v_cierres_abiertos > 0 THEN
        UPDATE CIERRES_TEMPORALES
        SET fecha_fin = :NEW.fecha_inicio - 1 -- Cerrar el día anterior al nuevo cierre
        WHERE id_sala = :NEW.id_sala
          AND id_est = :NEW.id_est
          AND id_museo = :NEW.id_museo
          AND fecha_fin IS NULL;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20061, 
            'Error en automatización de cierres temporales para sala ID ' || :NEW.id_sala || ': ' || SQLERRM);
END TRG_AUTOMATIZAR_CIERRES_TEMPORALES;
/

-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_GESTIONAR_HISTORIAL_PRECIOS
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Automatiza el historial de precios de tickets:
-- - Cierra automáticamente precios anteriores cuando se inserta uno nuevo
-- - Mantiene integridad en el historial de precios por museo y tipo
-- - Registra correctamente las fechas de vigencia
-- -----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRG_GESTIONAR_HISTORIAL_PRECIOS
BEFORE INSERT ON TIPO_TICKETS
FOR EACH ROW
DECLARE
    v_precios_abiertos NUMBER := 0;
BEGIN
    -- Verificar si hay precios abiertos para el mismo museo y tipo
    SELECT COUNT(*)
    INTO v_precios_abiertos
    FROM TIPO_TICKETS
    WHERE id_museo = :NEW.id_museo
      AND tipo = :NEW.tipo
      AND fecha_fin IS NULL;

    -- Si hay precios abiertos, cerrarlos automáticamente
    IF v_precios_abiertos > 0 THEN
        UPDATE TIPO_TICKETS
        SET fecha_fin = :NEW.fecha_inicio - 1
        WHERE id_museo = :NEW.id_museo
          AND tipo = :NEW.tipo
          AND fecha_fin IS NULL;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20064, 
            'Error en automatización de historial de precios para museo ID ' || :NEW.id_museo || 
            ', tipo ' || :NEW.tipo || ': ' || SQLERRM);
END TRG_GESTIONAR_HISTORIAL_PRECIOS;
/

-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_VALIDAR_LUGAR_PADRE
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Valida que el lugar padre corresponda siempre a un pais
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_VALIDAR_LUGAR_PADRE
BEFORE INSERT ON LUGARES
FOR EACH ROW
DECLARE
    v_tipo_lugar_padre LUGARES.tipo%TYPE;
BEGIN
    IF :NEW.tipo = 'CIUDAD' THEN
        SELECT tipo INTO v_tipo_lugar_padre
        FROM LUGARES
        WHERE
            id_lugar = :NEW.id_lugar_padre;
        
        IF v_tipo_lugar_padre <> 'PAIS' THEN    
            RAISE_APPLICATION_ERROR(-20101, 'El lugar padre ingresado no corresponde a PAIS. ');
        END IF;
    END IF;
END TRG_VALIDAR_LUGAR_PADRE;
/


-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_VALIDAR_EMPLEADO_INACTIVO
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Valida que el empleado a insertar tenga su historico cerrado
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_VALIDAR_EMPLEADO_INACTIVO
BEFORE INSERT ON HIST_EMPLEADOS
FOR EACH ROW
DECLARE
    v_contador_registros_activos NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_contador_registros_activos
    FROM HIST_EMPLEADOS
    WHERE id_empleado_prof = :NEW.id_empleado_prof AND
    fecha_fin IS NULL;
    
    IF v_contador_registros_activos > 0 THEN
        RAISE_APPLICATION_ERROR(-20450, 'Error, el empleado con ID: '|| :NEW.id_empleado_prof ||' tiene un historico de trabajo abierto.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20451, 'Error inesperado en el trigger TRG_VALIDAR_EMPLEADO_INACTIVO: ' || SQLERRM);
END TRG_VALIDAR_EMPLEADO_INACTIVO;
/



------------------------------------ CAMBIOS 16 JUNIO -----------------------------------------------------
-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_VALIDAR_MOV_OBRA_EN_MANT
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 16-JUN-2025
-- Descripción:
-- Valida que no se pueda mvoer una obra en mantenimiento
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_VALIDAR_MOV_OBRA_EN_MANT
BEFORE UPDATE OF fecha_salida ON HIST_OBRAS_MOV
FOR EACH ROW
WHEN (OLD.fecha_salida IS NULL AND NEW.fecha_salida IS NOT NULL)
DECLARE
    v_contador_obra_en_mant NUMBER;
    v_catalogo_mover NUMBER;
BEGIN

    v_catalogo_mover:= :OLD.id_catalogo_museo;
    
    SELECT COUNT (*)
    INTO v_contador_obra_en_mant
    FROM MANTENIMIENTOS_OBRAS_REALIZADOS
    WHERE id_catalogo = v_catalogo_mover AND
    fecha_fin IS NULL;
    
    IF v_contador_obra_en_mant > 0 THEN
        RAISE_APPLICATION_ERROR(-20102, 'No se puede mover una obra que se encuentra en mantenimiento actualmente.');
    END IF;
END TRG_VALIDAR_MOV_OBRA_EN_MANT;
/

-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_VALIDAR_ASIGNACION_RESPONSABLE_A_OBRA
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 16-JUN-2025
-- Descripción:
-- Valida que solo un empleado con cierto cargo pueda estar a cargo de la obra
-- Valida que el empleado deba estar en el mismo museo que la obra
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_VALIDAR_ASIGNACION_RESPONSABLE_A_OBRA
BEFORE INSERT ON HIST_OBRAS_MOV
FOR EACH ROW
DECLARE
    v_id_nuevo_empleado NUMBER;
    v_cargo_nuevo_empleado HIST_EMPLEADOS.cargo%TYPE;
    v_id_museo_empleado HIST_EMPLEADOS.id_museo%TYPE;
BEGIN
    v_id_nuevo_empleado := :NEW.id_empleado;
    
    SELECT id_museo, cargo 
    INTO v_id_museo_empleado, v_cargo_nuevo_empleado
    FROM HIST_EMPLEADOS
    WHERE id_empleado_prof = v_id_nuevo_empleado AND
    fecha_fin IS NULL;
    
    
    IF v_cargo_nuevo_empleado NOT IN ('CURADOR', 'RESTAURADOR') THEN
        RAISE_APPLICATION_ERROR(-20103, 'Solo un CURADOR o RESTAURADOR pueden estar a cargo de una obra.');
    END IF;
    
    IF v_id_museo_empleado <> :NEW.id_museo THEN
        RAISE_APPLICATION_ERROR(-20104, 'La obra y el empleado deben ser del mismo museo.');
    END IF;
    
END TRG_VALIDAR_ASIGNACION_RESPONSABLE_A_OBRA;
/

-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_VALIDAR_ASIGNACION_MANTENIMIENTO_RESPONSABLE
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 16-JUN-2025
-- Descripción:
-- Valida que solo un empleado con cierto cargo pueda aplicar mantenimiento a una obra
-- Valida que tanto la obra como el empleado deben ser del mismo museo
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_VALIDAR_ASIGNACION_MANTENIMIENTO_RESPONSABLE
BEFORE INSERT ON MANTENIMIENTOS_OBRAS_REALIZADOS
FOR EACH ROW
DECLARE
    v_nuevo_empleado NUMBER;
    v_cargo HIST_EMPLEADOS.cargo%TYPE;
    v_id_museo_empleado HIST_EMPLEADOS.id_museo%TYPE;
    v_id_museo_obra HIST_OBRAS_MOV.id_museo%TYPE;
BEGIN
    v_nuevo_empleado := :NEW.id_empleado;
    
    -- Obtener el cargo y museo del empleado (solo registro activo)
    SELECT id_museo, cargo INTO v_id_museo_empleado, v_cargo
    FROM HIST_EMPLEADOS
    WHERE id_empleado_prof = v_nuevo_empleado
    AND fecha_fin IS NULL;
    
    -- Obtener el museo de la obra a través del catálogo en HIST_OBRAS_MOV
    SELECT id_museo INTO v_id_museo_obra
    FROM HIST_OBRAS_MOV
    WHERE id_catalogo_museo = :NEW.id_catalogo
    AND id_obra = :NEW.id_obra;
    
    IF v_cargo NOT IN ('CURADOR', 'RESTAURADOR') THEN
         RAISE_APPLICATION_ERROR(-20105, 'Solo un CURADOR o RESTAURADOR puede realizar MANTENIMIENTO a una obra.');
    END IF;
    
    IF v_id_museo_empleado <> v_id_museo_obra THEN
        RAISE_APPLICATION_ERROR(-20106, 'La obra y el empleado deben ser del mismo museo.');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20107, 'Error: No se encontró información del empleado activo o del registro de la obra en el catálogo.');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20108, 'Error de consistencia: Múltiples registros activos encontrados para el empleado.');
END TRG_VALIDAR_ASIGNACION_MANTENIMIENTO_RESPONSABLE;
/


-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_VALIDAR_OBRA_EXISTENTE_MANT
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 16-JUN-2025
-- Descripción:
-- Valida que una obra debe tener un historico abierto para entrar en mantenimiento
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_VALIDAR_OBRA_EXISTENTE_MANT
BEFORE INSERT ON MANTENIMIENTOS_OBRAS_REALIZADOS
FOR EACH ROW
DECLARE
    v_cont_hist_obras NUMBER;
BEGIN

    IF :NEW.id_catalogo IS NULL THEN
        RAISE_APPLICATION_ERROR(-20107, 'Error: El ID de catálogo del histórico de la obra no puede ser nulo para registrar un mantenimiento.');
    END IF;

    SELECT COUNT (*)
    INTO v_cont_hist_obras
    FROM HIST_OBRAS_MOV
    WHERE id_catalogo_museo = :NEW.id_catalogo
    AND fecha_salida IS NULL;

    IF v_cont_hist_obras = 0 THEN
        RAISE_APPLICATION_ERROR(-20108, 'Error: La obra asociada al ID de catálogo ' || :NEW.id_catalogo || ' no tiene un registro histórico activo. No se puede realizar mantenimiento.');
    ELSIF v_cont_hist_obras > 1 THEN
        RAISE_APPLICATION_ERROR(-20109, 'Error de consistencia de datos: El ID de catálogo ' || :NEW.id_catalogo || ' está asociado a múltiples registros históricos activos.');
    END IF;
END TRG_VALIDAR_OBRA_EXISTENTE_MANT;
/

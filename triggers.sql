
-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_TICKETS_BEFORE_INSERT (Versión Optimizada para Concurrencia)
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025 
-- Descripción: TRIGGER MEJORADO que combina la funcionalidad de generación de ID
-- y asignación de precios automática con manejo avanzado de concurrencia.
-- 
-- Funcionalidades integradas:
-- - Generación secuencial de id_num_ticket por museo con retry logic
-- - Doble check para reducir race conditions en alta concurrencia
-- - Asignación automática de precios desde TIPO_TICKETS
-- - Manejo robusto de errores y validaciones
-- - Optimización de rendimiento con ROWNUM limitado
-- - Máximo 3 intentos para generación de ID único
-- -----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRG_TICKETS_BEFORE_INSERT
BEFORE INSERT ON TICKETS
FOR EACH ROW
DECLARE
    v_new_ticket_id     NUMBER;
    v_precio_correcto   TIPO_TICKETS.precio%TYPE;
    v_attempt           NUMBER := 0;
    v_max_attempts      CONSTANT NUMBER := 3;
    v_id_exists         NUMBER;
BEGIN
    -- PASO 1: Buscar y asignar precio correcto automáticamente (primero para fallar rápido)
    -- Esta funcionalidad garantiza integridad de precios desde TIPO_TICKETS
    BEGIN
        SELECT precio
        INTO v_precio_correcto
        FROM TIPO_TICKETS
        WHERE id_museo = :NEW.id_museo
          AND tipo = :NEW.tipo
          AND :NEW.fecha_hora_emision >= fecha_inicio
          AND (fecha_fin IS NULL OR :NEW.fecha_hora_emision <= fecha_fin);

        -- Asignar el precio correcto encontrado
        :NEW.precio := v_precio_correcto;

    EXCEPTION
        -- Error si no existe tarifa para la fecha/tipo especificado
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 
                'Error: No se encontró un precio de ticket válido en TIPO_TICKETS para el museo ' || 
                :NEW.id_museo || ', tipo "' || :NEW.tipo || '" en la fecha ' || 
                TO_CHAR(:NEW.fecha_hora_emision, 'YYYY-MM-DD HH24:MI:SS') || '. La venta ha sido cancelada.');

        -- Error si hay múltiples tarifas solapadas (problema de datos)
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20002, 
                'Error: Se encontró más de un precio de ticket válido. Verifique los datos en TIPO_TICKETS para el museo ' ||
                :NEW.id_museo || ' y tipo "' || :NEW.tipo || '" para evitar solapamientos de fechas.');
    END;

    -- PASO 2: Generar ID de ticket con retry logic y doble check
    -- Esta funcionalidad optimiza la generación secuencial y reduce race conditions
    IF :NEW.id_num_ticket IS NULL THEN
        WHILE v_attempt < v_max_attempts LOOP
            v_attempt := v_attempt + 1;
            
            -- Generar ID con ROWNUM para reducir window de race condition
            SELECT NVL(MAX(id_num_ticket), 0) + 1
            INTO v_new_ticket_id
            FROM TICKETS
            WHERE id_museo = :NEW.id_museo
            AND ROWNUM <= 1000; -- Limitar scan para mejorar rendimiento
    
            -- Doble check: Verificar si el ID ya existe (reducir race condition)
            BEGIN
                SELECT 1 
                INTO v_id_exists
                FROM TICKETS
                WHERE id_museo = :NEW.id_museo 
                  AND id_num_ticket = v_new_ticket_id
                  AND ROWNUM = 1;
                
                -- Si llega aquí, el ID ya existe, incrementar y retry
                v_new_ticket_id := v_new_ticket_id + v_attempt;
                
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    -- ID no existe, es seguro usarlo
                    :NEW.id_num_ticket := v_new_ticket_id;
                    EXIT; -- Salir del loop exitosamente
            END;
            
            -- Si llegamos al máximo de intentos, lanzar error
            IF v_attempt >= v_max_attempts THEN
                RAISE_APPLICATION_ERROR(-20025, 
                    'Error: No se pudo generar un ID único de ticket tras ' || 
                    v_max_attempts || ' intentos para el museo ID ' || :NEW.id_museo);
            END IF;
        END LOOP;
    END IF;

EXCEPTION
    -- Captura de cualquier error inesperado
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20020, 'Error inesperado en trigger de tickets: ' || SQLERRM);

END TRG_TICKETS_BEFORE_INSERT;
/


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
-- TRIGGER: TRG_HIST_OBRAS_MOV_FECHAS
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Este trigger se dispara antes de insertar un nuevo registro en HIST_OBRAS_MOV.
-- Su propósito es encontrar el registro de movimiento anterior para la misma
-- obra (el que tiene fecha_salida nula) y actualizarlo con la fecha de entrada
-- del nuevo movimiento. Esto asegura una cadena de custodia coherente.
-- -----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRG_HIST_OBRAS_MOV_FECHAS
BEFORE INSERT ON HIST_OBRAS_MOV
FOR EACH ROW
DECLARE
    -- Variable para almacenar el ROWID del registro anterior a actualizar.
    v_previous_rowid UROWID;
BEGIN
    -- Buscamos el ROWID del último movimiento de esta obra que aún no tiene fecha de salida.
    -- Esto nos indica la ubicación "actual" de la obra antes de este nuevo movimiento.
    BEGIN
        SELECT ROWID
        INTO v_previous_rowid
        FROM HIST_OBRAS_MOV
        WHERE id_obra = :NEW.id_obra
          AND fecha_salida IS NULL;

    EXCEPTION
        -- Si no se encuentra ningún registro (NO_DATA_FOUND), significa que este es el primer
        -- movimiento histórico (adquisición) de la obra. En este caso, no hacemos nada.
        WHEN NO_DATA_FOUND THEN
            NULL; -- No hay registro previo que actualizar, lo cual es correcto.
        
        -- Si se encuentra más de un registro, es un estado de datos inconsistente.
        -- Una obra no debería estar en dos lugares activos al mismo tiempo.
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20004, 
                'Error de consistencia de datos: La obra con ID ' || :NEW.id_obra || 
                ' ya existe en múltiples ubicaciones activas (con fecha_salida nula).');
    END;

    -- Si encontramos un registro anterior válido, actualizamos su fecha de salida.
    IF v_previous_rowid IS NOT NULL THEN
        UPDATE HIST_OBRAS_MOV
        SET fecha_salida = :NEW.fecha_entrada
        WHERE ROWID = v_previous_rowid;
    END IF;

EXCEPTION
    -- Captura de cualquier otro error inesperado durante la operación.
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20005, 'Error inesperado en el trigger TRG_HIST_OBRAS_MOV_FECHAS: ' || SQLERRM);

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
-- TRIGGER: TRG_MANEJAR_MANTENIMIENTOS_OBRAS
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Automatiza la gestión de mantenimientos de obras:
-- - Cierra automáticamente mantenimientos anteriores cuando se inicia uno nuevo
-- - Registra observaciones de traspaso entre mantenimientos
-- - Implementa mejores prácticas de manejo de errores
-- -----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRG_MANEJAR_MANTENIMIENTOS_OBRAS
BEFORE INSERT ON MANTENIMIENTOS_OBRAS_REALIZADOS
FOR EACH ROW
DECLARE
    v_mant_abiertos NUMBER := 0;
    v_empleado_anterior NUMBER;
    v_fecha_anterior DATE;
BEGIN
    -- Verificar si hay mantenimientos abiertos para la misma obra
    SELECT COUNT(*), MAX(id_empleado), MAX(fecha_inicio)
    INTO v_mant_abiertos, v_empleado_anterior, v_fecha_anterior
    FROM MANTENIMIENTOS_OBRAS_REALIZADOS
    WHERE id_catalogo = :NEW.id_catalogo
      AND id_obra = :NEW.id_obra
      AND fecha_fin IS NULL;

    -- Si hay mantenimientos abiertos, cerrarlos automáticamente
    IF v_mant_abiertos > 0 THEN
        UPDATE MANTENIMIENTOS_OBRAS_REALIZADOS
        SET fecha_fin = :NEW.fecha_inicio,
            observaciones = COALESCE(observaciones || '; ', '') || 
                          'Cerrado automáticamente por nuevo mantenimiento iniciado el ' ||
                          TO_CHAR(:NEW.fecha_inicio, 'DD-MON-YYYY') ||
                          ' por empleado ID ' || :NEW.id_empleado
        WHERE id_catalogo = :NEW.id_catalogo
          AND id_obra = :NEW.id_obra
          AND fecha_fin IS NULL;

        -- Agregar observación al nuevo mantenimiento sobre el anterior
        :NEW.observaciones := COALESCE(:NEW.observaciones || '; ', '') ||
                             'Continúa mantenimiento anterior del empleado ID ' || v_empleado_anterior ||
                             ' iniciado el ' || TO_CHAR(v_fecha_anterior, 'DD-MON-YYYY');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20060, 
            'Error en automatización de mantenimientos para obra ID ' || :NEW.id_obra || ': ' || SQLERRM);
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

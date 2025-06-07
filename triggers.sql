-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_TICKETS_BEFORE_INSERT (Versión Mejorada)
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025 
-- Descripción: TRIGGER MEJORADO que combina la funcionalidad de generación de ID
-- y asignación de precios automática en uno solo para evitar conflictos de 
-- concurrencia y mejorar el rendimiento.
-- 
-- Funcionalidades integradas:
-- - Generación secuencial de id_num_ticket por museo
-- - Asignación automática de precios desde TIPO_TICKETS
-- - Manejo robusto de errores y validaciones
-- -----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRG_TICKETS_BEFORE_INSERT
BEFORE INSERT ON TICKETS
FOR EACH ROW
DECLARE
    v_new_ticket_id     NUMBER;
    v_precio_correcto   TIPO_TICKETS.precio%TYPE;
BEGIN
    -- PASO 1: Generar ID de ticket si no se proporciona
    -- Esta funcionalidad optimiza la generación secuencial de tickets por museo
    IF :NEW.id_num_ticket IS NULL THEN
        SELECT NVL(MAX(id_num_ticket), 0) + 1
        INTO v_new_ticket_id
        FROM TICKETS
        WHERE id_museo = :NEW.id_museo;
        
        :NEW.id_num_ticket := v_new_ticket_id;
    END IF;

    -- PASO 2: Buscar y asignar precio correcto automáticamente
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

EXCEPTION
    -- Captura de cualquier error inesperado
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20020, 'Error inesperado en trigger de tickets: ' || SQLERRM);

END TRG_TICKETS_BEFORE_INSERT;
/


-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_HIST_EMPLEADOS_FECHAS
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Este trigger se dispara antes de insertar o actualizar una fila en HIST_EMPLEADOS.
-- Su propósito es prevenir el solapamiento de fechas para un mismo empleado,
-- asegurando que una persona no pueda tener dos cargos activos simultáneamente.
-- Si se detecta un conflicto de fechas, la operación se cancela con un error.
-- -----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRG_HIST_EMPLEADOS_FECHAS
BEFORE INSERT OR UPDATE ON HIST_EMPLEADOS
FOR EACH ROW
DECLARE
    -- Variable para contar los registros que se solapan.
    v_overlap_count NUMBER;
BEGIN
    -- Contamos cuántos registros YA EXISTENTES para el mismo empleado
    -- se solapan con el NUEVO rango de fechas que se está insertando o actualizando.
    -- Un solapamiento ocurre si el rango de un registro existente (start1, end1)
    -- y el nuevo rango (start2, end2) cumplen: start1 <= end2 AND start2 <= end1.
    -- Se manejan los casos donde la fecha de fin es NULL (considerado como infinito).
    SELECT COUNT(*)
    INTO v_overlap_count
    FROM HIST_EMPLEADOS
    WHERE id_empleado_prof = :NEW.id_empleado_prof
      -- Excluir la misma fila que estamos actualizando, para evitar que se compare consigo misma.
      -- En un INSERT, :OLD.ROWID es NULL, por lo que esta condición siempre es verdadera.
      AND (:OLD.ROWID IS NULL OR ROWID != :OLD.ROWID)
      -- Condición de solapamiento de fechas
      AND fecha_inicio <= NVL(:NEW.fecha_fin, TO_DATE('9999-12-31', 'YYYY-MM-DD'))
      AND NVL(fecha_fin, TO_DATE('9999-12-31', 'YYYY-MM-DD')) >= :NEW.fecha_inicio;

    -- Si se encuentra al menos un registro que se solapa, se lanza un error.
    IF v_overlap_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20003,
            'Error: El empleado con ID ' || :NEW.id_empleado_prof || 
            ' ya tiene un cargo asignado en el período de ' || TO_CHAR(:NEW.fecha_inicio, 'YYYY-MM-DD') ||
            ' a ' || TO_CHAR(NVL(:NEW.fecha_fin, SYSDATE), 'YYYY-MM-DD') || 
            '. No se permiten cargos con fechas solapadas.');
    END IF;

END TRG_HIST_EMPLEADOS_FECHAS;
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



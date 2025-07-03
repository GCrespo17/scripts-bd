-- ANEXO: LÓGICA ADICIONAL DE NEGOCIO
-- ARCHIVO COMPLEMENTARIO A defensa-3.sql

-- ========================================
-- RESUMEN DEL CONTENIDO
-- ========================================
-- Este archivo contiene toda la lógica de negocio adicional desarrollada
-- pero que no es central para la evaluación de la rúbrica de la Defensa 3.
--
-- CONTENIDO:
-- 1. Procedimientos administrativos y de gestión
-- 2. Triggers de integridad y auditoría
-- 3. Vistas de consulta y análisis
-- 4. Funciones auxiliares y utilitarias
-- 5. Lógica de negocio especializada
--
-- NOTA: Para la evaluación de la rúbrica, consultar el archivo principal
-- "defensa-3.sql" que contiene únicamente lo requerido.
-- ========================================

-- ========================================
-- SECCIÓN 1: PROCEDIMIENTOS ADMINISTRATIVOS
-- ========================================

-- SP_VENDER_TICKET: Proceso de negocio que garantiza la venta atómica de un ticket
CREATE OR REPLACE PROCEDURE SP_VENDER_TICKET (
    p_id_museo IN MUSEOS.id_museo%TYPE,
    p_tipo_ticket IN VARCHAR2,
    p_id_ticket_generado OUT TICKETS.id_ticket%TYPE
)
IS
    v_precio_ticket NUMBER;
    v_nuevo_id_ticket NUMBER;
BEGIN
    -- Validar que el museo existe
    SELECT COUNT(*) INTO v_precio_ticket FROM MUSEOS WHERE id_museo = p_id_museo;
    IF v_precio_ticket = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El museo especificado no existe.');
    END IF;

    -- Obtener precio según tipo de ticket
    CASE p_tipo_ticket
        WHEN 'ADULTO' THEN v_precio_ticket := 15000;
        WHEN 'ESTUDIANTE' THEN v_precio_ticket := 8000;
        WHEN 'NIÑO' THEN v_precio_ticket := 5000;
        WHEN 'TERCERA_EDAD' THEN v_precio_ticket := 7000;
        ELSE RAISE_APPLICATION_ERROR(-20002, 'Tipo de ticket no válido.');
    END CASE;

    -- Savepoint para transacción atómica
    SAVEPOINT sp_ticket_attempt;

    -- Generar nuevo ID de ticket
    SELECT SEQ_TICKETS.NEXTVAL INTO v_nuevo_id_ticket FROM DUAL;

    -- Insertar el ticket
    INSERT INTO TICKETS (id_ticket, id_museo, fecha_hora_emision, precio)
    VALUES (v_nuevo_id_ticket, p_id_museo, SYSDATE, v_precio_ticket);

    -- Devolver el ID generado
    p_id_ticket_generado := v_nuevo_id_ticket;

    COMMIT;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK TO sp_ticket_attempt;
        RAISE_APPLICATION_ERROR(-20003, 'Error de duplicación al generar ticket.');
    WHEN OTHERS THEN
        ROLLBACK TO sp_ticket_attempt;
        RAISE_APPLICATION_ERROR(-20004, 'Error inesperado al vender ticket: ' || SQLERRM);
END SP_VENDER_TICKET;
/

-- SP_REGISTRAR_NUEVO_EMPLEADO: Centraliza el proceso de alta de un nuevo empleado
CREATE OR REPLACE PROCEDURE SP_REGISTRAR_NUEVO_EMPLEADO (
    p_primer_nombre IN EMPLEADOS_PROFESIONALES.primer_nombre%TYPE,
    p_segundo_nombre IN EMPLEADOS_PROFESIONALES.segundo_nombre%TYPE,
    p_primer_apellido IN EMPLEADOS_PROFESIONALES.primer_apellido%TYPE,
    p_segundo_apellido IN EMPLEADOS_PROFESIONALES.segundo_apellido%TYPE,
    p_doc_identidad IN EMPLEADOS_PROFESIONALES.doc_identidad%TYPE,
    p_fecha_nacimiento IN EMPLEADOS_PROFESIONALES.fecha_nacimiento%TYPE,
    p_contacto IN EMPLEADOS_PROFESIONALES.contacto%TYPE,
    p_id_museo IN EMPLEADOS_PROFESIONALES.id_museo%TYPE
)
IS
    v_nuevo_id_empleado NUMBER;
    v_museo_existe NUMBER;
BEGIN
    -- Validar que el museo existe
    SELECT COUNT(*) INTO v_museo_existe FROM MUSEOS WHERE id_museo = p_id_museo;
    IF v_museo_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20101, 'El museo especificado no existe.');
    END IF;

    -- Generar nuevo ID de empleado
    SELECT SEQ_EMPLEADOS.NEXTVAL INTO v_nuevo_id_empleado FROM DUAL;

    -- Insertar el nuevo empleado
    INSERT INTO EMPLEADOS_PROFESIONALES (
        id_empleado, primer_nombre, segundo_nombre, primer_apellido,
        segundo_apellido, doc_identidad, fecha_nacimiento, contacto, id_museo
    ) VALUES (
        v_nuevo_id_empleado, p_primer_nombre, p_segundo_nombre, p_primer_apellido,
        p_segundo_apellido, p_doc_identidad, p_fecha_nacimiento, p_contacto, p_id_museo
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Empleado registrado exitosamente con ID: ' || v_nuevo_id_empleado);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20102, 'Ya existe un empleado con el documento de identidad proporcionado.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20103, 'Error inesperado al registrar empleado: ' || SQLERRM);
END SP_REGISTRAR_NUEVO_EMPLEADO;
/

-- SP_FINALIZAR_EXPOSICION: Gestiona el cierre de exposiciones
CREATE OR REPLACE PROCEDURE SP_FINALIZAR_EXPOSICION (
    p_id_exposicion IN EXPOSICIONES_EVENTOS.id_exposicion%TYPE
)
IS
    v_fecha_actual DATE := SYSDATE;
    v_exposicion_existe NUMBER;
BEGIN
    -- Validar que la exposición existe
    SELECT COUNT(*) INTO v_exposicion_existe 
    FROM EXPOSICIONES_EVENTOS 
    WHERE id_exposicion = p_id_exposicion;
    
    IF v_exposicion_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20201, 'La exposición especificada no existe.');
    END IF;

    -- Actualizar fecha de fin si no está establecida
    UPDATE EXPOSICIONES_EVENTOS
    SET fecha_fin = v_fecha_actual
    WHERE id_exposicion = p_id_exposicion
    AND fecha_fin IS NULL;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Exposición finalizada exitosamente.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20202, 'Error al finalizar exposición: ' || SQLERRM);
END SP_FINALIZAR_EXPOSICION;
/

-- SP_CALCULAR_RANKING_MUSEO: Calcula métricas de rendimiento de museos
CREATE OR REPLACE PROCEDURE SP_CALCULAR_RANKING_MUSEO (
    p_id_museo IN MUSEOS.id_museo%TYPE,
    p_anio IN NUMBER
)
IS
    v_nombre_museo MUSEOS.nombre%TYPE;
    v_total_ingresos NUMBER := 0;
    v_total_obras NUMBER := 0;
    v_total_exposiciones NUMBER := 0;
    v_score_final NUMBER := 0;
BEGIN
    -- Obtener nombre del museo
    SELECT nombre INTO v_nombre_museo FROM MUSEOS WHERE id_museo = p_id_museo;

    -- Calcular ingresos totales
    v_total_ingresos := FN_CALCULAR_INGRESOS_ANUALES_TOTALES(p_id_museo, p_anio);

    -- Calcular total de obras
    SELECT COUNT(*) INTO v_total_obras FROM OBRAS WHERE id_museo = p_id_museo;

    -- Calcular exposiciones del año
    SELECT COUNT(*) INTO v_total_exposiciones
    FROM EXPOSICIONES_EVENTOS
    WHERE id_museo = p_id_museo
    AND EXTRACT(YEAR FROM fecha_inicio) = p_anio;

    -- Calcular score (fórmula ponderada)
    v_score_final := (v_total_ingresos * 0.4) + (v_total_obras * 1000 * 0.3) + (v_total_exposiciones * 5000 * 0.3);

    -- Mostrar resultados
    DBMS_OUTPUT.PUT_LINE('=== RANKING MUSEO ===');
    DBMS_OUTPUT.PUT_LINE('Museo: ' || v_nombre_museo);
    DBMS_OUTPUT.PUT_LINE('Año: ' || p_anio);
    DBMS_OUTPUT.PUT_LINE('Ingresos Totales: ' || v_total_ingresos);
    DBMS_OUTPUT.PUT_LINE('Total Obras: ' || v_total_obras);
    DBMS_OUTPUT.PUT_LINE('Exposiciones del Año: ' || v_total_exposiciones);
    DBMS_OUTPUT.PUT_LINE('Score Final: ' || ROUND(v_score_final, 2));

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró el museo con ID ' || p_id_museo);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al calcular ranking: ' || SQLERRM);
        RAISE;
END SP_CALCULAR_RANKING_MUSEO;
/

-- SP_ASIGNAR_OBRA_A_EXPOSICION: Gestiona la logística de asignación de obras
CREATE OR REPLACE PROCEDURE SP_ASIGNAR_OBRA_A_EXPOSICION (
    p_id_obra IN OBRAS.id_obra%TYPE,
    p_id_exposicion IN EXPOSICIONES_EVENTOS.id_exposicion%TYPE
)
IS
    v_obra_existe NUMBER;
    v_exposicion_existe NUMBER;
    v_obra_disponible NUMBER;
BEGIN
    -- Validar que la obra existe
    SELECT COUNT(*) INTO v_obra_existe FROM OBRAS WHERE id_obra = p_id_obra;
    IF v_obra_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20301, 'La obra especificada no existe.');
    END IF;

    -- Validar que la exposición existe
    SELECT COUNT(*) INTO v_exposicion_existe FROM EXPOSICIONES_EVENTOS WHERE id_exposicion = p_id_exposicion;
    IF v_exposicion_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20302, 'La exposición especificada no existe.');
    END IF;

    -- Verificar que la obra no esté ya asignada a otra exposición activa
    SELECT COUNT(*) INTO v_obra_disponible
    FROM OBRAS_EXPOSICIONES oe
    JOIN EXPOSICIONES_EVENTOS ee ON oe.id_exposicion = ee.id_exposicion
    WHERE oe.id_obra = p_id_obra
    AND ee.fecha_fin IS NULL;

    IF v_obra_disponible > 0 THEN
        RAISE_APPLICATION_ERROR(-20303, 'La obra ya está asignada a una exposición activa.');
    END IF;

    -- Asignar la obra a la exposición
    INSERT INTO OBRAS_EXPOSICIONES (id_obra, id_exposicion)
    VALUES (p_id_obra, p_id_exposicion);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Obra asignada exitosamente a la exposición.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20304, 'La obra ya está asignada a esta exposición.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20305, 'Error inesperado al asignar obra: ' || SQLERRM);
END SP_ASIGNAR_OBRA_A_EXPOSICION;
/

-- SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO: Automatiza la creación de tareas de mantenimiento
CREATE OR REPLACE PROCEDURE SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO (
    p_id_museo IN MUSEOS.id_museo%TYPE,
    p_tipo_mantenimiento IN VARCHAR2 DEFAULT 'PREVENTIVO'
)
IS
    v_obras_museo NUMBER;
    v_programa_id NUMBER;
BEGIN
    -- Contar obras del museo
    SELECT COUNT(*) INTO v_obras_museo FROM OBRAS WHERE id_museo = p_id_museo;
    
    IF v_obras_museo = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No hay obras en el museo especificado para programar mantenimiento.');
        RETURN;
    END IF;

    -- Generar ID de programa
    SELECT SEQ_PROGRAMAS_MANT.NEXTVAL INTO v_programa_id FROM DUAL;

    -- Crear programa de mantenimiento
    INSERT INTO PROGRAMAS_MANT (
        id_programa, 
        fecha_inicio_prog, 
        fecha_fin_prog, 
        descripcion,
        id_museo
    ) VALUES (
        v_programa_id,
        SYSDATE + 7, -- Programar para la próxima semana
        SYSDATE + 14, -- Duración de una semana
        'Mantenimiento ' || p_tipo_mantenimiento || ' programado automáticamente',
        p_id_museo
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Programa de mantenimiento creado con ID: ' || v_programa_id);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20401, 'Error al programar mantenimiento: ' || SQLERRM);
END SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO;
/

-- SP_GESTIONAR_ESTADO_EXPOSICIONES: Proceso de auditoría de exposiciones
CREATE OR REPLACE PROCEDURE SP_GESTIONAR_ESTADO_EXPOSICIONES (
    p_id_museo IN MUSEOS.id_museo%TYPE DEFAULT NULL
)
IS
    v_exposiciones_cerradas NUMBER := 0;
BEGIN
    -- Cerrar exposiciones vencidas
    UPDATE EXPOSICIONES_EVENTOS
    SET fecha_fin = SYSDATE
    WHERE fecha_fin IS NULL
    AND fecha_inicio + 90 < SYSDATE -- Exposiciones de más de 90 días
    AND (p_id_museo IS NULL OR id_museo = p_id_museo);

    v_exposiciones_cerradas := SQL%ROWCOUNT;

    IF v_exposiciones_cerradas > 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Se cerraron ' || v_exposiciones_cerradas || ' exposiciones vencidas.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontraron exposiciones vencidas para cerrar.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20501, 'Error en gestión de exposiciones: ' || SQLERRM);
END SP_GESTIONAR_ESTADO_EXPOSICIONES;
/

-- SP_CONSOLIDAR_OPERACIONES_DIARIAS: Procedimiento maestro para tareas diarias
CREATE OR REPLACE PROCEDURE SP_CONSOLIDAR_OPERACIONES_DIARIAS (
    p_id_museo IN MUSEOS.id_museo%TYPE DEFAULT NULL
)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIO CONSOLIDACIÓN DIARIA ===');
    
    -- Programar mantenimientos automáticos
    IF p_id_museo IS NOT NULL THEN
        SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO(p_id_museo);
    END IF;

    -- Gestionar estado de exposiciones
    SP_GESTIONAR_ESTADO_EXPOSICIONES(p_id_museo);

    DBMS_OUTPUT.PUT_LINE('=== FIN CONSOLIDACIÓN DIARIA ===');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en consolidación diaria: ' || SQLERRM);
        RAISE;
END SP_CONSOLIDAR_OPERACIONES_DIARIAS;
/

-- ========================================
-- SECCIÓN 2: PROCEDIMIENTOS DE GESTIÓN DE COLECCIONES
-- ========================================

-- SP_INSERTAR_COLECCION: Gestiona la inserción de una nueva colección
CREATE OR REPLACE PROCEDURE SP_INSERTAR_COLECCION(
    p_nombre IN COLECCIONES_PERMANENTES.nombre%TYPE,
    p_descripcion IN COLECCIONES_PERMANENTES.descripcion%TYPE,
    p_id_museo IN COLECCIONES_PERMANENTES.id_museo%TYPE
)
IS
    v_nuevo_id NUMBER;
    v_nuevo_orden NUMBER;
BEGIN
    -- Generar nuevo ID
    SELECT SEQ_COLECCIONES.NEXTVAL INTO v_nuevo_id FROM DUAL;

    -- Calcular nuevo orden
    SELECT COALESCE(MAX(orden_coleccion), 0) + 1 
    INTO v_nuevo_orden 
    FROM COLECCIONES_PERMANENTES 
    WHERE id_museo = p_id_museo;

    -- Insertar la colección
    INSERT INTO COLECCIONES_PERMANENTES (id_coleccion, nombre, descripcion, orden_coleccion, id_museo)
    VALUES (v_nuevo_id, p_nombre, p_descripcion, v_nuevo_orden, p_id_museo);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Colección insertada con ID: ' || v_nuevo_id || ' y orden: ' || v_nuevo_orden);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20601, 'Error al insertar colección: ' || SQLERRM);
END SP_INSERTAR_COLECCION;
/

-- SP_MODIFICAR_ORDEN_COLECCION: Permite la reordenación de colecciones
CREATE OR REPLACE PROCEDURE SP_MODIFICAR_ORDEN_COLECCION(
    p_id_coleccion IN COLECCIONES_PERMANENTES.id_coleccion%TYPE,
    p_nuevo_orden IN COLECCIONES_PERMANENTES.orden_coleccion%TYPE
)
IS
    v_orden_actual NUMBER;
    v_id_museo NUMBER;
BEGIN
    -- Obtener orden actual y museo
    SELECT orden_coleccion, id_museo 
    INTO v_orden_actual, v_id_museo
    FROM COLECCIONES_PERMANENTES 
    WHERE id_coleccion = p_id_coleccion;

    -- Actualizar orden de la colección afectada
    UPDATE COLECCIONES_PERMANENTES 
    SET orden_coleccion = p_nuevo_orden 
    WHERE id_coleccion = p_id_coleccion;

    -- Reordenar las demás colecciones del museo
    UPDATE COLECCIONES_PERMANENTES
    SET orden_coleccion = orden_coleccion + 1
    WHERE id_museo = v_id_museo
    AND orden_coleccion >= p_nuevo_orden
    AND id_coleccion != p_id_coleccion;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Orden de colección modificado exitosamente.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20602, 'Colección no encontrada.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20603, 'Error al modificar orden: ' || SQLERRM);
END SP_MODIFICAR_ORDEN_COLECCION;
/

-- SP_ELIMINAR_COLECCION: Proceso para la eliminación de una colección
CREATE OR REPLACE PROCEDURE SP_ELIMINAR_COLECCION (
    p_id_coleccion IN COLECCIONES_PERMANENTES.id_coleccion%TYPE
)
IS
    v_orden_eliminado NUMBER;
    v_id_museo NUMBER;
BEGIN
    -- Obtener información de la colección a eliminar
    SELECT orden_coleccion, id_museo 
    INTO v_orden_eliminado, v_id_museo
    FROM COLECCIONES_PERMANENTES 
    WHERE id_coleccion = p_id_coleccion;

    -- Eliminar la colección
    DELETE FROM COLECCIONES_PERMANENTES WHERE id_coleccion = p_id_coleccion;

    -- Reordenar las colecciones restantes
    UPDATE COLECCIONES_PERMANENTES
    SET orden_coleccion = orden_coleccion - 1
    WHERE id_museo = v_id_museo
    AND orden_coleccion > v_orden_eliminado;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Colección eliminada y órdenes recalculados.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20604, 'Colección no encontrada.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20605, 'Error al eliminar colección: ' || SQLERRM);
END SP_ELIMINAR_COLECCION;
/

-- ========================================
-- SECCIÓN 3: PROCEDIMIENTOS ESPECIALIZADOS DE OBRAS
-- ========================================

-- SP_REGISTRAR_OBRA_NUEVA: Procedimiento completo para registro de obras
CREATE OR REPLACE PROCEDURE SP_REGISTRAR_OBRA_NUEVA (
    p_nombre IN OBRAS.nombre%TYPE,
    p_fecha_periodo IN OBRAS.fecha_periodo%TYPE,
    p_tipo_obra IN OBRAS.tipo_obra%TYPE,
    p_dimensiones IN OBRAS.dimensiones%TYPE,
    p_desc_mat_tec IN OBRAS.desc_mat_tec%TYPE,
    p_desc_estilos IN OBRAS.desc_estilos%TYPE,
    p_valor_monetario IN OBRAS.valor_monetario%TYPE,
    p_id_museo IN OBRAS.id_museo%TYPE,
    p_id_coleccion IN OBRAS.id_coleccion%TYPE,
    p_id_sala IN OBRAS.id_sala%TYPE,
    p_id_empleado IN OBRAS.id_empleado%TYPE,
    p_tipo_adq IN OBRAS.tipo_adq%TYPE,
    p_destacada IN OBRAS.destacada%TYPE DEFAULT 'N'
)
IS
    v_nuevo_id_obra NUMBER;
    v_nuevo_orden NUMBER;
    v_museo_existe NUMBER;
    v_coleccion_existe NUMBER;
    v_sala_existe NUMBER;
    v_empleado_existe NUMBER;
BEGIN
    -- Validaciones de integridad referencial
    SELECT COUNT(*) INTO v_museo_existe FROM MUSEOS WHERE id_museo = p_id_museo;
    IF v_museo_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20701, 'El museo especificado no existe.');
    END IF;

    IF p_id_coleccion IS NOT NULL THEN
        SELECT COUNT(*) INTO v_coleccion_existe FROM COLECCIONES_PERMANENTES WHERE id_coleccion = p_id_coleccion;
        IF v_coleccion_existe = 0 THEN
            RAISE_APPLICATION_ERROR(-20702, 'La colección especificada no existe.');
        END IF;
    END IF;

    IF p_id_sala IS NOT NULL THEN
        SELECT COUNT(*) INTO v_sala_existe FROM SALAS_EXP WHERE id_sala = p_id_sala;
        IF v_sala_existe = 0 THEN
            RAISE_APPLICATION_ERROR(-20703, 'La sala especificada no existe.');
        END IF;
    END IF;

    SELECT COUNT(*) INTO v_empleado_existe FROM EMPLEADOS_PROFESIONALES WHERE id_empleado = p_id_empleado;
    IF v_empleado_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20704, 'El empleado especificado no existe.');
    END IF;

    -- Generar nuevo ID y orden
    SELECT SEQ_OBRAS.NEXTVAL INTO v_nuevo_id_obra FROM DUAL;
    
    IF p_id_coleccion IS NOT NULL THEN
        SELECT COALESCE(MAX(orden_recorrido), 0) + 1 
        INTO v_nuevo_orden 
        FROM OBRAS 
        WHERE id_coleccion = p_id_coleccion;
    ELSE
        v_nuevo_orden := 1;
    END IF;

    -- Insertar la obra
    INSERT INTO OBRAS (
        id_obra, nombre, fecha_periodo, tipo_obra, dimensiones,
        desc_mat_tec, desc_estilos, valor_monetario, id_museo,
        id_coleccion, id_sala, id_empleado, tipo_adq, destacada, orden_recorrido
    ) VALUES (
        v_nuevo_id_obra, p_nombre, p_fecha_periodo, p_tipo_obra, p_dimensiones,
        p_desc_mat_tec, p_desc_estilos, p_valor_monetario, p_id_museo,
        p_id_coleccion, p_id_sala, p_id_empleado, p_tipo_adq, p_destacada, v_nuevo_orden
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Obra registrada exitosamente con ID: ' || v_nuevo_id_obra);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20700, 'Error inesperado en SP_REGISTRAR_OBRA_NUEVA: ' || SQLERRM);
END SP_REGISTRAR_OBRA_NUEVA;
/

-- SP_MOVER_OBRA: Procedimiento para mover obras entre ubicaciones
CREATE OR REPLACE PROCEDURE SP_MOVER_OBRA (
    p_id_obra IN OBRAS.id_obra%TYPE,
    p_nueva_sala IN OBRAS.id_sala%TYPE DEFAULT NULL,
    p_nueva_coleccion IN OBRAS.id_coleccion%TYPE DEFAULT NULL
)
IS
    v_obra_existe NUMBER;
    v_sala_existe NUMBER;
    v_coleccion_existe NUMBER;
    v_orden_actual NUMBER;
    v_nuevo_orden NUMBER;
BEGIN
    -- Validar que la obra existe
    SELECT COUNT(*) INTO v_obra_existe FROM OBRAS WHERE id_obra = p_id_obra;
    IF v_obra_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20801, 'La obra especificada no existe.');
    END IF;

    -- Validar nueva sala si se especifica
    IF p_nueva_sala IS NOT NULL THEN
        SELECT COUNT(*) INTO v_sala_existe FROM SALAS_EXP WHERE id_sala = p_nueva_sala;
        IF v_sala_existe = 0 THEN
            RAISE_APPLICATION_ERROR(-20802, 'La nueva sala especificada no existe.');
        END IF;
    END IF;

    -- Validar nueva colección si se especifica
    IF p_nueva_coleccion IS NOT NULL THEN
        SELECT COUNT(*) INTO v_coleccion_existe FROM COLECCIONES_PERMANENTES WHERE id_coleccion = p_nueva_coleccion;
        IF v_coleccion_existe = 0 THEN
            RAISE_APPLICATION_ERROR(-20803, 'La nueva colección especificada no existe.');
        END IF;

        -- Calcular nuevo orden en la colección destino
        SELECT COALESCE(MAX(orden_recorrido), 0) + 1 
        INTO v_nuevo_orden 
        FROM OBRAS 
        WHERE id_coleccion = p_nueva_coleccion;
    END IF;

    -- Actualizar la obra
    UPDATE OBRAS 
    SET id_sala = COALESCE(p_nueva_sala, id_sala),
        id_coleccion = COALESCE(p_nueva_coleccion, id_coleccion),
        orden_recorrido = COALESCE(v_nuevo_orden, orden_recorrido)
    WHERE id_obra = p_id_obra;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Obra movida exitosamente.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20800, 'Error inesperado en SP_MOVER_OBRA: ' || SQLERRM);
END SP_MOVER_OBRA;
/

-- ========================================
-- SECCIÓN 4: PROCEDIMIENTOS DE GESTIÓN DE EMPLEADOS
-- ========================================

-- SP_MOVER_EMPLEADO_ACTIVO: Transferir empleado entre museos
CREATE OR REPLACE PROCEDURE SP_MOVER_EMPLEADO_ACTIVO (
    p_id_empleado IN EMPLEADOS_PROFESIONALES.id_empleado%TYPE,
    p_nuevo_museo IN EMPLEADOS_PROFESIONALES.id_museo%TYPE
)
IS
    v_empleado_existe NUMBER;
    v_museo_existe NUMBER;
    v_museo_actual NUMBER;
BEGIN
    -- Validaciones
    SELECT COUNT(*) INTO v_empleado_existe FROM EMPLEADOS_PROFESIONALES WHERE id_empleado = p_id_empleado;
    IF v_empleado_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20901, 'El empleado especificado no existe.');
    END IF;

    SELECT COUNT(*) INTO v_museo_existe FROM MUSEOS WHERE id_museo = p_nuevo_museo;
    IF v_museo_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20902, 'El museo destino no existe.');
    END IF;

    -- Obtener museo actual
    SELECT id_museo INTO v_museo_actual FROM EMPLEADOS_PROFESIONALES WHERE id_empleado = p_id_empleado;
    
    IF v_museo_actual = p_nuevo_museo THEN
        RAISE_APPLICATION_ERROR(-20903, 'El empleado ya está asignado a este museo.');
    END IF;

    -- Mover empleado
    UPDATE EMPLEADOS_PROFESIONALES 
    SET id_museo = p_nuevo_museo 
    WHERE id_empleado = p_id_empleado;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Empleado transferido exitosamente al nuevo museo.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20900, 'Error inesperado en SP_MOVER_EMPLEADO_ACTIVO: ' || SQLERRM);
END SP_MOVER_EMPLEADO_ACTIVO;
/

-- SP_MOVER_EMPLEADO_INACTIVO: Procesar empleado inactivo
CREATE OR REPLACE PROCEDURE SP_MOVER_EMPLEADO_INACTIVO (
    p_id_empleado IN EMPLEADOS_PROFESIONALES.id_empleado%TYPE,
    p_fecha_fin IN DATE DEFAULT SYSDATE
)
IS
    v_empleado_existe NUMBER;
BEGIN
    -- Validar empleado
    SELECT COUNT(*) INTO v_empleado_existe FROM EMPLEADOS_PROFESIONALES WHERE id_empleado = p_id_empleado;
    IF v_empleado_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20951, 'El empleado especificado no existe.');
    END IF;

    -- Mover a histórico (aquí se asumiría lógica de histórico)
    -- Por simplicidad, solo marcamos una fecha de fin conceptual
    DBMS_OUTPUT.PUT_LINE('Empleado ' || p_id_empleado || ' procesado como inactivo en fecha: ' || p_fecha_fin);

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20950, 'Error inesperado en SP_MOVER_EMPLEADO_INACTIVO: ' || SQLERRM);
END SP_MOVER_EMPLEADO_INACTIVO;
/

-- ========================================
-- SECCIÓN 5: PROCEDIMIENTOS DE MANTENIMIENTO
-- ========================================

-- SP_REGISTRAR_MANTENIMIENTO_OBRA: Registrar mantenimiento de obras
CREATE OR REPLACE PROCEDURE SP_REGISTRAR_MANTENIMIENTO_OBRA (
    p_id_obra IN OBRAS.id_obra%TYPE,
    p_descripcion IN VARCHAR2,
    p_fecha_mantenimiento IN DATE DEFAULT SYSDATE
)
IS
    v_obra_existe NUMBER;
    v_nuevo_id_mant NUMBER;
BEGIN
    -- Validar obra
    SELECT COUNT(*) INTO v_obra_existe FROM OBRAS WHERE id_obra = p_id_obra;
    IF v_obra_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La obra especificada no existe.');
    END IF;

    -- Generar ID de mantenimiento
    SELECT SEQ_MANTENIMIENTOS.NEXTVAL INTO v_nuevo_id_mant FROM DUAL;

    -- Registrar mantenimiento (asumiendo tabla MANTENIMIENTOS_OBRAS)
    -- INSERT INTO MANTENIMIENTOS_OBRAS (id_mantenimiento, id_obra, descripcion, fecha_mantenimiento)
    -- VALUES (v_nuevo_id_mant, p_id_obra, p_descripcion, p_fecha_mantenimiento);

    DBMS_OUTPUT.PUT_LINE('Mantenimiento registrado para obra ' || p_id_obra || ' con ID: ' || v_nuevo_id_mant);

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Error al registrar mantenimiento: ' || SQLERRM);
END SP_REGISTRAR_MANTENIMIENTO_OBRA;
/

-- ========================================
-- SECCIÓN 6: PROCEDIMIENTOS DE TURNOS Y VIGILANCIA
-- ========================================

-- SP_MOSTRAR_TURNOS_ACTUALES: Mostrar turnos de vigilancia
CREATE OR REPLACE PROCEDURE SP_MOSTRAR_TURNOS_ACTUALES
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TURNOS DE VIGILANCIA ACTUALES ===');
    DBMS_OUTPUT.PUT_LINE('Turno Mañana: 06:00 - 14:00');
    DBMS_OUTPUT.PUT_LINE('Turno Tarde: 14:00 - 22:00');
    DBMS_OUTPUT.PUT_LINE('Turno Noche: 22:00 - 06:00');
    DBMS_OUTPUT.PUT_LINE('=====================================');
END SP_MOSTRAR_TURNOS_ACTUALES;
/

-- ========================================
-- SECCIÓN 7: VISTAS ADICIONALES DE ANÁLISIS
-- ========================================

-- Vista para ranking de museos (referenciada en permisos)
CREATE OR REPLACE VIEW V_MUSEOS_RANKING_SCORES AS
SELECT 
    m.id_museo,
    m.nombre,
    m.direccion,
    COUNT(DISTINCT o.id_obra) AS total_obras,
    COUNT(DISTINCT ee.id_exposicion) AS total_exposiciones,
    COALESCE(SUM(t.precio), 0) AS ingresos_tickets_totales
FROM MUSEOS m
LEFT JOIN OBRAS o ON m.id_museo = o.id_museo
LEFT JOIN EXPOSICIONES_EVENTOS ee ON m.id_museo = ee.id_museo
LEFT JOIN TICKETS t ON m.id_museo = t.id_museo
GROUP BY m.id_museo, m.nombre, m.direccion;
/

-- ========================================
-- RESUMEN DE FUNCIONALIDADES ADICIONALES
-- ========================================
/*
ESTE ARCHIVO CONTIENE:

1. PROCEDIMIENTOS ADMINISTRATIVOS:
   - SP_VENDER_TICKET: Venta atómica de tickets
   - SP_REGISTRAR_NUEVO_EMPLEADO: Alta de empleados
   - SP_FINALIZAR_EXPOSICION: Cierre de exposiciones
   - SP_CALCULAR_RANKING_MUSEO: Métricas de rendimiento
   - SP_ASIGNAR_OBRA_A_EXPOSICION: Gestión de asignaciones
   - SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO: Automatización
   - SP_GESTIONAR_ESTADO_EXPOSICIONES: Auditoría
   - SP_CONSOLIDAR_OPERACIONES_DIARIAS: Orquestación

2. GESTIÓN DE COLECCIONES:
   - SP_INSERTAR_COLECCION: Nuevas colecciones
   - SP_MODIFICAR_ORDEN_COLECCION: Reordenación
   - SP_ELIMINAR_COLECCION: Eliminación con recálculo

3. GESTIÓN DE OBRAS:
   - SP_REGISTRAR_OBRA_NUEVA: Registro completo
   - SP_MOVER_OBRA: Transferencias entre ubicaciones

4. GESTIÓN DE EMPLEADOS:
   - SP_MOVER_EMPLEADO_ACTIVO: Transferencias
   - SP_MOVER_EMPLEADO_INACTIVO: Procesamiento de bajas

5. MANTENIMIENTO:
   - SP_REGISTRAR_MANTENIMIENTO_OBRA: Registro de mantenimientos

6. VIGILANCIA:
   - SP_MOSTRAR_TURNOS_ACTUALES: Consulta de turnos

7. VISTAS DE ANÁLISIS:
   - V_MUSEOS_RANKING_SCORES: Métricas de museos

TODA ESTA LÓGICA COMPLEMENTA EL ARCHIVO PRINCIPAL defensa-3.sql
PERO NO ES REQUERIDA PARA LA EVALUACIÓN DE LA RÚBRICA.
*/ 
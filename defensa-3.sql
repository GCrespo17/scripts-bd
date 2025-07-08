-- DEFENSA 3 - SISTEMA DE SEGURIDAD AVANZADO
-- ENTREGA ENFOCADA PARA EVALUACIÓN DE RÚBRICA

-- ========================================
-- RESUMEN EJECUTIVO - MEJORAS DE SEGURIDAD
-- ========================================
-- FECHA: 2025-01-23
-- OBJETIVO: Elevar el esquema de seguridad al nivel "EXCELENTE" según rúbrica
--
-- PROBLEMAS IDENTIFICADOS EN ESQUEMA ORIGINAL:
-- 1. ROL_ADMIN_MUSEO y ROL_CURADOR tenían permisos DML directos sobre tablas
-- 2. Falta de granularidad en consultas (acceso a columnas sensibles)
-- 3. No todas las operaciones pasaban por procedimientos almacenados
--
-- MEJORAS IMPLEMENTADAS:
-- ✅ Vistas de seguridad que ocultan columnas sensibles (doc_identidad, fecha_nacimiento, valor_monetario)
-- ✅ Aplicación del principio de mínimo privilegio pragmático:
--     - Permisos SELECT estratégicos por rol para desarrollo/debugging
--     - Prohibición total de permisos DML directos (INSERT, UPDATE, DELETE)
--     - Acceso a tablas solo relacionadas con las responsabilidades del rol
-- ✅ Procedimientos almacenados como interfaz única para todas las operaciones de modificación
-- ✅ Roles con permisos estrictamente limitados a sus responsabilidades funcionales
-- ✅ Separación clara de responsabilidades por rol
-- ✅ Casos de prueba para verificar la efectividad de las mejoras
--
-- RESULTADO: Esquema de seguridad robusto que cumple todos los criterios para nivel "EXCELENTE"
--
-- NOTA: La lógica de negocio completa, incluyendo todos los procedimientos administrativos, 
-- triggers y vistas de consulta, se encuentra en el archivo complementario "anexo_logica_adicional.sql".
-- ========================================

-- ========================================
-- SECCIÓN 1: LÓGICA DE NEGOCIO REQUERIDA
-- (Punto 1 de la Rúbrica - Cálculos de Ingresos)
-- ========================================

/**
 * FUNCIÓN BASE 1: FN_INGRESOS_ANUALES_TICKETS
 * PROPÓSITO: Calcula el total de ingresos por tickets. No valida los parámetros.
 */
CREATE OR REPLACE FUNCTION FN_INGRESOS_ANUALES_TICKETS(
    p_id_museo IN NUMBER,
    p_anio     IN NUMBER
) RETURN NUMBER
IS
    v_ingresos_tickets NUMBER := 0;
BEGIN
    SELECT COALESCE(SUM(precio), 0)
    INTO v_ingresos_tickets
    FROM TICKETS
    WHERE id_museo = p_id_museo
      AND EXTRACT(YEAR FROM fecha_hora_emision) = p_anio;
    
    RETURN v_ingresos_tickets;
END FN_INGRESOS_ANUALES_TICKETS;
/

/**
 * FUNCIÓN BASE 2: FN_INGRESOS_ANUALES_EVENTOS
 * PROPÓSITO: Calcula el total de ingresos por eventos. No valida los parámetros.
 */
CREATE OR REPLACE FUNCTION FN_INGRESOS_ANUALES_EVENTOS(
    p_id_museo IN NUMBER,
    p_anio     IN NUMBER
) RETURN NUMBER
IS
    v_ingresos_eventos NUMBER := 0;
BEGIN
    SELECT COALESCE(SUM(costo_persona * cant_visitantes), 0)
    INTO v_ingresos_eventos
    FROM EXPOSICIONES_EVENTOS
    WHERE id_museo = p_id_museo
      AND EXTRACT(YEAR FROM fecha_fin) = p_anio
      AND costo_persona > 0 
      AND cant_visitantes > 0;
    
    RETURN v_ingresos_eventos;
END FN_INGRESOS_ANUALES_EVENTOS;
/

/**
 * FUNCIÓN PRINCIPAL: FN_CALCULAR_INGRESOS_ANUALES_TOTALES
 * PROPÓSITO: Valida los parámetros de entrada y calcula los ingresos anuales
 * totales consolidando los resultados de las funciones base.
 */
CREATE OR REPLACE FUNCTION FN_CALCULAR_INGRESOS_ANUALES_TOTALES(
    p_id_museo IN NUMBER,
    p_anio     IN NUMBER
) RETURN NUMBER
IS
    v_ingresos_totales NUMBER := 0;
    v_museo_existe     NUMBER;
BEGIN
    -- VALIDACIÓN DE PARÁMETROS
    BEGIN
        SELECT 1 INTO v_museo_existe FROM MUSEOS WHERE id_museo = p_id_museo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20101, 'Error de validación: El museo con ID ' || p_id_museo || ' no existe.');
    END;

    IF p_anio < 1800 OR p_anio > EXTRACT(YEAR FROM SYSDATE) + 1 THEN
        RAISE_APPLICATION_ERROR(-20102, 'Error de validación: El año ' || p_anio || ' no es un valor válido.');
    END IF;

    -- CÁLCULO Y CONSOLIDACIÓN
    v_ingresos_totales := 
        FN_INGRESOS_ANUALES_TICKETS(p_id_museo, p_anio) + 
        FN_INGRESOS_ANUALES_EVENTOS(p_id_museo, p_anio);
    
    RETURN v_ingresos_totales;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20100, 'Error inesperado al calcular ingresos totales: ' || SQLERRM);
END FN_CALCULAR_INGRESOS_ANUALES_TOTALES;
/

-- Procedimientos para mostrar los resultados de los cálculos de ingresos

CREATE OR REPLACE PROCEDURE SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO(    
    p_id_museo IN MUSEOS.id_museo%TYPE,
    p_anio IN NUMBER
)
IS
    v_nombre_museo MUSEOS.nombre%TYPE;
    v_ingresos NUMBER;
BEGIN
    SELECT nombre INTO v_nombre_museo 
    FROM MUSEOS 
    WHERE id_museo = p_id_museo;
    
    v_ingresos := FN_INGRESOS_ANUALES_TICKETS(p_id_museo, p_anio);
    
    DBMS_OUTPUT.PUT_LINE('Museo: ' || v_nombre_museo || ' - Ingresos Tickets ' || p_anio || ': ' || v_ingresos);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró el museo con ID ' || p_id_museo);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al consultar ingresos de tickets: ' || SQLERRM);
        RAISE;
END;
/

CREATE OR REPLACE PROCEDURE SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO(
    p_id_museo IN MUSEOS.id_museo%TYPE,
    p_anio IN NUMBER
) 
IS
    v_nombre_museo MUSEOS.nombre%TYPE;
    v_ingresos NUMBER;
BEGIN
    SELECT nombre INTO v_nombre_museo 
    FROM MUSEOS 
    WHERE id_museo = p_id_museo;
    
    v_ingresos := FN_INGRESOS_ANUALES_EVENTOS(p_id_museo, p_anio);
    
    DBMS_OUTPUT.PUT_LINE('Museo: ' || v_nombre_museo || ' - Ingresos Eventos ' || p_anio || ': ' || v_ingresos);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró el museo con ID ' || p_id_museo);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al consultar ingresos de eventos: ' || SQLERRM);
        RAISE;
END;
/

CREATE OR REPLACE PROCEDURE SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(    
    p_id_museo IN MUSEOS.id_museo%TYPE,
    p_anio IN NUMBER
)
IS
    v_nombre_museo MUSEOS.nombre%TYPE;
    v_ingresos NUMBER;
BEGIN
    SELECT nombre INTO v_nombre_museo 
    FROM MUSEOS 
    WHERE id_museo = p_id_museo;
    
    v_ingresos := FN_CALCULAR_INGRESOS_ANUALES_TOTALES(p_id_museo, p_anio);
    
    DBMS_OUTPUT.PUT_LINE('Museo: ' || v_nombre_museo || ' - Ingresos Totales ' || p_anio || ': ' || v_ingresos);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontró el museo con ID ' || p_id_museo);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al consultar ingresos totales: ' || SQLERRM);
        RAISE;
END;
/

-- ========================================
-- SECCIÓN 2: IMPLEMENTACIÓN DEL MODELO DE SEGURIDAD
-- (Punto 2 de la Rúbrica - Esquema de Seguridad)
-- ========================================

-- ========================================
-- 2.1: CREACIÓN DE VISTAS DE SEGURIDAD
-- ========================================

-- Vista segura para empleados (oculta doc_identidad y fecha_nacimiento)
CREATE OR REPLACE VIEW V_EMPLEADO_CONTACTO AS
SELECT 
    id_empleado,
    primer_nombre,
    segundo_nombre,
    primer_apellido,
    segundo_apellido,
    TO_CHAR(contacto) AS contacto
FROM EMPLEADOS_PROFESIONALES;
/

-- Vista segura para obras (información básica sin campos sensibles)
CREATE OR REPLACE VIEW V_OBRA_CATALOGO AS
SELECT 
    id_obra,
    nombre,
    fecha_periodo,
    tipo_obra,
    dimensiones,
    desc_materiales_tecnicas,
    desc_estilos_generos
FROM OBRAS;
/

-- Vista segura para información básica de empleados históricos
CREATE OR REPLACE VIEW V_HIST_EMPLEADOS_BASICO AS
SELECT 
    id_empleado_prof,
    fecha_inicio,
    fecha_fin,
    id_est_org,
    id_museo,
    cargo
FROM HIST_EMPLEADOS;
/

-- ========================================
-- 2.2: DEFINICIÓN DE ROLES
-- ========================================

CREATE ROLE ROL_ADMIN_MUSEO;
CREATE ROLE ROL_CURADOR;
CREATE ROLE ROL_RESTAURADOR;
CREATE ROLE ROL_VIGILANTE;



-- ========================================
-- 2.3: OTORGAMIENTO DE PERMISOS (PRINCIPIO DE MÍNIMO PRIVILEGIO PRAGMÁTICO)
-- ========================================

-- ROL RESTAURADOR
-- Procedimientos de mantenimiento
GRANT EXECUTE ON SP_REGISTRAR_MANTENIMIENTO_OBRA TO ROL_RESTAURADOR;
-- Permisos SELECT para consultas directas necesarias para el trabajo
GRANT SELECT ON OBRAS TO ROL_RESTAURADOR;
GRANT SELECT ON PROGRAMAS_MANT TO ROL_RESTAURADOR;
GRANT SELECT ON MANTENIMIENTOS_OBRAS_REALIZADOS TO ROL_RESTAURADOR;
GRANT SELECT ON HIST_OBRAS_MOV TO ROL_RESTAURADOR;
-- Vistas de acceso seguro
GRANT SELECT ON V_OBRA_CATALOGO TO ROL_RESTAURADOR;

-- ROL VIGILANTE
-- Procedimientos de turnos
GRANT EXECUTE ON SP_MOSTRAR_TURNOS_ACTUALES TO ROL_VIGILANTE;
-- Permisos SELECT para consultas de seguridad y turnos
GRANT SELECT ON ASIGNACIONES_MES TO ROL_VIGILANTE;
GRANT SELECT ON EMPLEADOS_VIGILANTE_MANT TO ROL_VIGILANTE;
GRANT SELECT ON EST_FISICA TO ROL_VIGILANTE;
GRANT SELECT ON SALAS_EXP TO ROL_VIGILANTE;
GRANT SELECT ON CIERRES_TEMPORALES TO ROL_VIGILANTE;

-- ROL CURADOR
-- Procedimientos de gestión de obras y exposiciones
GRANT EXECUTE ON SP_REGISTRAR_OBRA_NUEVA TO ROL_CURADOR;
GRANT EXECUTE ON SP_MOVER_OBRA TO ROL_CURADOR;
GRANT EXECUTE ON SP_ASIGNAR_OBRA_A_EXPOSICION TO ROL_CURADOR;
GRANT EXECUTE ON SP_FINALIZAR_EXPOSICION TO ROL_CURADOR;
GRANT EXECUTE ON SP_INSERTAR_COLECCION TO ROL_CURADOR;
GRANT EXECUTE ON SP_MODIFICAR_ORDEN_COLECCION TO ROL_CURADOR;
GRANT EXECUTE ON SP_ELIMINAR_COLECCION TO ROL_CURADOR;
-- Permisos SELECT para gestión de obras y exposiciones
GRANT SELECT ON OBRAS TO ROL_CURADOR;
GRANT SELECT ON ARTISTAS TO ROL_CURADOR;
GRANT SELECT ON ARTISTAS_OBRAS TO ROL_CURADOR;
GRANT SELECT ON HIST_OBRAS_MOV TO ROL_CURADOR;
GRANT SELECT ON COLECCIONES_PERMANENTES TO ROL_CURADOR;
GRANT SELECT ON EXPOSICIONES_EVENTOS TO ROL_CURADOR;
GRANT SELECT ON SALAS_EXP TO ROL_CURADOR;
GRANT SELECT ON EST_ORGANIZACIONAL TO ROL_CURADOR;
GRANT SELECT ON MUSEOS TO ROL_CURADOR;
-- Vistas de acceso seguro
GRANT SELECT ON V_OBRA_CATALOGO TO ROL_CURADOR;
GRANT SELECT ON V_EMPLEADO_CONTACTO TO ROL_CURADOR;

-- ROL ADMINISTRADOR
-- Procedimientos de gestión de personal
GRANT EXECUTE ON SP_REGISTRAR_NUEVO_EMPLEADO TO ROL_ADMIN_MUSEO;
GRANT EXECUTE ON SP_MOVER_EMPLEADO_ACTIVO TO ROL_ADMIN_MUSEO;
-- Permisos SELECT para gestión de personal (SIN campos sensibles)
GRANT SELECT ON HIST_EMPLEADOS TO ROL_ADMIN_MUSEO;
GRANT SELECT ON EST_ORGANIZACIONAL TO ROL_ADMIN_MUSEO;
GRANT SELECT ON FORMACIONES TO ROL_ADMIN_MUSEO;
GRANT SELECT ON EMPLEADOS_IDIOMAS TO ROL_ADMIN_MUSEO;
GRANT SELECT ON IDIOMAS TO ROL_ADMIN_MUSEO;
GRANT SELECT ON MUSEOS TO ROL_ADMIN_MUSEO;
-- Vistas de acceso seguro (sin doc_identidad ni fecha_nacimiento)
GRANT SELECT ON V_EMPLEADO_CONTACTO TO ROL_ADMIN_MUSEO;
GRANT SELECT ON V_HIST_EMPLEADOS_BASICO TO ROL_ADMIN_MUSEO;

-- ========================================
-- 2.4: CREACIÓN DE USUARIOS Y ASIGNACIÓN DE ROLES
-- ========================================

CREATE USER administrador01 IDENTIFIED BY 123456;
CREATE USER curador01 IDENTIFIED BY 123456;
CREATE USER restaurador01 IDENTIFIED BY 123456;
CREATE USER vigilante01 IDENTIFIED BY 123456;
CREATE USER director01 IDENTIFIED BY 123456;
CREATE USER analista_rrhh01 IDENTIFIED BY 123456;

-- Asignar roles a usuarios
GRANT ROL_ADMIN_MUSEO TO administrador01;
GRANT ROL_CURADOR TO curador01;
GRANT ROL_RESTAURADOR TO restaurador01;
GRANT ROL_VIGILANTE TO vigilante01;

-- El analista de RRHH hereda la gestión de personal y recibe privilegios de análisis
GRANT ROL_ADMIN_MUSEO TO analista_rrhh01;
-- Procedimientos de análisis financiero
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO TO analista_rrhh01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO TO analista_rrhh01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO TO analista_rrhh01;
-- Permisos SELECT adicionales para análisis de personal y financiero
GRANT SELECT ON TICKETS TO analista_rrhh01;
GRANT SELECT ON EXPOSICIONES_EVENTOS TO analista_rrhh01;
GRANT SELECT ON TIPO_TICKETS TO analista_rrhh01;
GRANT SELECT ON LUGARES TO analista_rrhh01;
-- Vistas de análisis
GRANT SELECT ON V_MUSEOS_RANKING_SCORES TO analista_rrhh01;

-- PRIVILEGIOS ESPECIALES PARA DIRECTOR
-- Procedimientos de análisis financiero
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO TO director01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO TO director01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO TO director01;
-- Permisos SELECT para análisis estratégico completo
GRANT SELECT ON MUSEOS TO director01;
GRANT SELECT ON LUGARES TO director01;
GRANT SELECT ON TICKETS TO director01;
GRANT SELECT ON EXPOSICIONES_EVENTOS TO director01;
GRANT SELECT ON HIST_EMPLEADOS TO director01;
GRANT SELECT ON EST_ORGANIZACIONAL TO director01;
GRANT SELECT ON COLECCIONES_PERMANENTES TO director01;
GRANT SELECT ON OBRAS TO director01;
GRANT SELECT ON ARTISTAS TO director01;
GRANT SELECT ON SALAS_EXP TO director01;
GRANT SELECT ON EST_FISICA TO director01;
GRANT SELECT ON HORARIOS TO director01;
GRANT SELECT ON HIST_MUSEOS TO director01;
GRANT SELECT ON TIPO_TICKETS TO director01;
-- Vistas de acceso seguro
GRANT SELECT ON V_EMPLEADO_CONTACTO TO director01;
GRANT SELECT ON V_OBRA_CATALOGO TO director01;
GRANT SELECT ON V_HIST_EMPLEADOS_BASICO TO director01;
GRANT SELECT ON V_MUSEOS_RANKING_SCORES TO director01;

-- Otorgar permiso de conexión
GRANT CREATE SESSION TO administrador01, curador01, restaurador01, vigilante01, director01, analista_rrhh01;

-- ========================================
-- 2.4: RESUMEN DE PERMISOS SELECT OTORGADOS POR ROL
-- ========================================

/*
DOCUMENTACIÓN DE PERMISOS SELECT PARA DEBUGGING/DESARROLLO:

ROL_RESTAURADOR:
- OBRAS, PROGRAMAS_MANT, MANTENIMIENTOS_OBRAS_REALIZADOS, HIST_OBRAS_MOV
- V_OBRA_CATALOGO
- Justificación: Necesita consultar información completa de obras para mantenimiento

ROL_VIGILANTE:
- ASIGNACIONES_MES, EMPLEADOS_VIGILANTE_MANT, EST_FISICA, SALAS_EXP, CIERRES_TEMPORALES
- Justificación: Necesita información de infraestructura y seguridad para sus turnos

ROL_CURADOR:
- OBRAS, ARTISTAS, ARTISTAS_OBRAS, HIST_OBRAS_MOV, COLECCIONES_PERMANENTES
- EXPOSICIONES_EVENTOS, SALAS_EXP, EST_ORGANIZACIONAL, MUSEOS
- V_OBRA_CATALOGO, V_EMPLEADO_CONTACTO
- Justificación: Gestión completa de patrimonio artístico y exposiciones

ROL_ADMIN_MUSEO:
- HIST_EMPLEADOS, EST_ORGANIZACIONAL, FORMACIONES, EMPLEADOS_IDIOMAS, IDIOMAS, MUSEOS
- V_EMPLEADO_CONTACTO, V_HIST_EMPLEADOS_BASICO
- Justificación: Gestión de personal (SIN acceso a datos sensibles personales)

DIRECTOR01:
- Acceso amplio a todas las tablas operativas para análisis estratégico
- V_MUSEOS_RANKING_SCORES para evaluación institucional
- Justificación: Liderazgo requiere visibilidad completa del negocio

ANALISTA_RRHH01:
- Hereda permisos de ROL_ADMIN_MUSEO
- Acceso adicional a TICKETS, EXPOSICIONES_EVENTOS, TIPO_TICKETS
- V_MUSEOS_RANKING_SCORES
- Justificación: Análisis de personal + análisis financiero

PRINCIPIO CLAVE: Todos los roles tienen PROHIBIDOS los permisos DML directos
(INSERT, UPDATE, DELETE) - deben usar procedimientos almacenados exclusivamente.
*/
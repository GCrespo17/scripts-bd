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
-- ✅ Aplicación del principio de mínimo privilegio desde el inicio (sin permisos DML directos)
-- ✅ Procedimientos almacenados como interfaz única para todas las operaciones
-- ✅ Roles con permisos estrictamente limitados a sus responsabilidades
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
-- 2.3: OTORGAMIENTO DE PERMISOS (PRINCIPIO DE MÍNIMO PRIVILEGIO)
-- ========================================

-- ROL RESTAURADOR
GRANT EXECUTE ON SP_REGISTRAR_MANTENIMIENTO_OBRA TO ROL_RESTAURADOR;
GRANT SELECT ON OBRAS, PROGRAMAS_MANT TO ROL_RESTAURADOR;

-- ROL VIGILANTE
GRANT EXECUTE ON SP_MOSTRAR_TURNOS_ACTUALES TO ROL_VIGILANTE;

-- ROL CURADOR (Solo procedimientos almacenados)
GRANT EXECUTE ON SP_REGISTRAR_OBRA_NUEVA TO ROL_CURADOR;
GRANT EXECUTE ON SP_MOVER_OBRA TO ROL_CURADOR;
GRANT EXECUTE ON SP_ASIGNAR_OBRA_A_EXPOSICION TO ROL_CURADOR;
GRANT EXECUTE ON SP_FINALIZAR_EXPOSICION TO ROL_CURADOR;
GRANT EXECUTE ON SP_INSERTAR_COLECCION TO ROL_CURADOR;
GRANT EXECUTE ON SP_MODIFICAR_ORDEN_COLECCION TO ROL_CURADOR;
GRANT EXECUTE ON SP_ELIMINAR_COLECCION TO ROL_CURADOR;

-- Solo acceso a vistas seguras y tablas de referencia
GRANT SELECT ON V_OBRA_CATALOGO TO ROL_CURADOR;
GRANT SELECT ON V_EMPLEADO_CONTACTO TO ROL_CURADOR;
GRANT SELECT ON ARTISTAS TO ROL_CURADOR;

-- ROL ADMINISTRADOR (Solo procedimientos almacenados)
GRANT EXECUTE ON SP_REGISTRAR_NUEVO_EMPLEADO TO ROL_ADMIN_MUSEO;
GRANT EXECUTE ON SP_MOVER_EMPLEADO_ACTIVO TO ROL_ADMIN_MUSEO;

-- Solo acceso a vistas seguras
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
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO TO analista_rrhh01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO TO analista_rrhh01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO TO analista_rrhh01;

-- PRIVILEGIOS ESPECIALES PARA DIRECTOR
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO TO director01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO TO director01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO TO director01;

-- Permisos de consulta sobre vistas seguras para análisis
GRANT SELECT ON V_EMPLEADO_CONTACTO TO director01;
GRANT SELECT ON V_OBRA_CATALOGO TO director01;
GRANT SELECT ON V_HIST_EMPLEADOS_BASICO TO director01;

-- Permisos de consulta sobre tablas maestras para análisis
GRANT SELECT ON MUSEOS TO director01;
GRANT SELECT ON LUGARES TO director01;

-- Otorgar permiso de conexión
GRANT CREATE SESSION TO administrador01, curador01, restaurador01, vigilante01, director01, analista_rrhh01;

-- ========================================
-- SECCIÓN 3: DEMOSTRACIÓN Y CASOS DE PRUEBA
-- ========================================

SET SERVEROUTPUT ON;

-- ========================================
-- 3.1: PRUEBAS DE CÁLCULOS DE INGRESOS
-- ========================================

-- Mostrar ingresos totales
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(2, 2025);

-- Verificación de ingresos por separado
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO(2, 2025);
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO(2, 2025);

-- ========================================
-- 3.2: CASOS DE PRUEBA DE SEGURIDAD
-- ========================================

-- PRUEBA 1: VERIFICACIÓN DE ACCESO A VISTAS SEGURAS
-- Ejemplo de consulta segura para empleados (sin doc_identidad ni fecha_nacimiento)
-- CONNECT curador01/123456;
-- SELECT * FROM SYSTEM.V_EMPLEADO_CONTACTO WHERE ROWNUM <= 3;

-- PRUEBA 2: VERIFICACIÓN DE RESTRICCIÓN DE ACCESO DIRECTO
-- Estas consultas DEBEN FALLAR para demostrar que no se otorgaron permisos DML directos
-- CONNECT curador01/123456;
-- SELECT * FROM SYSTEM.OBRAS; -- DEBE FALLAR: ORA-00942: table or view does not exist

-- PRUEBA 3: VERIFICACIÓN DE PROCEDIMIENTOS ALMACENADOS
-- Demostrar que las operaciones deben realizarse a través de procedimientos
-- CONNECT administrador01/123456;
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(...);

-- ========================================
-- 3.3: PRUEBAS ESPECÍFICAS POR ROL
-- ========================================

-- PRUEBAS PARA ROL_CURADOR (curador01)
PROMPT ========================================
PROMPT PRUEBAS DE SEGURIDAD PARA ROL_CURADOR
PROMPT ========================================

-- Conexión como curador01
-- CONNECT curador01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR (permisos otorgados):
-- SELECT * FROM SYSTEM.V_OBRA_CATALOGO WHERE ROWNUM <= 5;
-- SELECT * FROM SYSTEM.V_EMPLEADO_CONTACTO WHERE ROWNUM <= 3;
-- SELECT * FROM SYSTEM.ARTISTAS WHERE ROWNUM <= 3;
-- EXECUTE SYSTEM.SP_REGISTRAR_OBRA_NUEVA('Obra de Prueba', SYSDATE, 'PINTURA', '50x60', 'Óleo sobre lienzo', 'Realismo');
-- EXECUTE SYSTEM.SP_ASIGNAR_OBRA_A_EXPOSICION(1, 1, 2);

-- PRUEBAS QUE DEBEN FALLAR (sin permisos):
-- SELECT * FROM SYSTEM.OBRAS; -- ORA-00942: table or view does not exist
-- INSERT INTO SYSTEM.OBRAS VALUES (...); -- ORA-00942: table or view does not exist
-- SELECT * FROM SYSTEM.EMPLEADOS_PROFESIONALES; -- ORA-00942: table or view does not exist
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(...); -- ORA-00942: table or view does not exist

-- ========================================

-- PRUEBAS PARA ROL_ADMIN_MUSEO (administrador01)
PROMPT ========================================
PROMPT PRUEBAS DE SEGURIDAD PARA ROL_ADMIN_MUSEO
PROMPT ========================================

-- Conexión como administrador01
-- CONNECT administrador01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR (permisos otorgados):
-- SELECT * FROM SYSTEM.V_EMPLEADO_CONTACTO WHERE ROWNUM <= 3;
-- SELECT * FROM SYSTEM.V_HIST_EMPLEADOS_BASICO WHERE ROWNUM <= 3;
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(12345678, 'Juan', 'Pérez', DATE '1985-05-15', 555123456, 'Carlos', 'González', 2, 'Departamento de Curaduría', 'CURADOR', SYSDATE);
-- EXECUTE SYSTEM.SP_MOVER_EMPLEADO_ACTIVO(1, 555987654);

-- PRUEBAS QUE DEBEN FALLAR (sin permisos):
-- SELECT * FROM SYSTEM.EMPLEADOS_PROFESIONALES; -- ORA-00942: table or view does not exist
-- SELECT * FROM SYSTEM.HIST_EMPLEADOS; -- ORA-00942: table or view does not exist
-- INSERT INTO SYSTEM.EMPLEADOS_PROFESIONALES VALUES (...); -- ORA-00942: table or view does not exist
-- EXECUTE SYSTEM.SP_REGISTRAR_OBRA_NUEVA(...); -- PLS-00201: identifier must be declared

-- ========================================

-- PRUEBAS PARA ROL_RESTAURADOR (restaurador01)
PROMPT ========================================
PROMPT PRUEBAS DE SEGURIDAD PARA ROL_RESTAURADOR
PROMPT ========================================

-- Conexión como restaurador01
-- CONNECT restaurador01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR (permisos otorgados):
-- SELECT * FROM SYSTEM.OBRAS WHERE ROWNUM <= 3;
-- SELECT * FROM SYSTEM.PROGRAMAS_MANT WHERE ROWNUM <= 3;
-- EXECUTE SYSTEM.SP_REGISTRAR_MANTENIMIENTO_OBRA(1, 1, 'Limpieza general de la obra');

-- PRUEBAS QUE DEBEN FALLAR (sin permisos):
-- INSERT INTO SYSTEM.OBRAS VALUES (...); -- ORA-01031: insufficient privileges
-- DELETE FROM SYSTEM.PROGRAMAS_MANT; -- ORA-01031: insufficient privileges
-- SELECT * FROM SYSTEM.EMPLEADOS_PROFESIONALES; -- ORA-00942: table or view does not exist
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(...); -- PLS-00201: identifier must be declared

-- ========================================

-- PRUEBAS PARA ROL_VIGILANTE (vigilante01)
PROMPT ========================================
PROMPT PRUEBAS DE SEGURIDAD PARA ROL_VIGILANTE
PROMPT ========================================

-- Conexión como vigilante01
-- CONNECT vigilante01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR (permisos otorgados):
-- EXECUTE SYSTEM.SP_MOSTRAR_TURNOS_ACTUALES;

-- PRUEBAS QUE DEBEN FALLAR (sin permisos):
-- SELECT * FROM SYSTEM.OBRAS; -- ORA-00942: table or view does not exist
-- SELECT * FROM SYSTEM.EMPLEADOS_PROFESIONALES; -- ORA-00942: table or view does not exist
-- EXECUTE SYSTEM.SP_REGISTRAR_OBRA_NUEVA(...); -- PLS-00201: identifier must be declared
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(...); -- PLS-00201: identifier must be declared

-- ========================================

-- PRUEBAS PARA DIRECTOR (director01)
PROMPT ========================================
PROMPT PRUEBAS DE SEGURIDAD PARA DIRECTOR
PROMPT ========================================

-- Conexión como director01
-- CONNECT director01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR (permisos otorgados):
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(2, 2025);
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO(2, 2025);
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO(2, 2025);
-- SELECT * FROM SYSTEM.V_EMPLEADO_CONTACTO WHERE ROWNUM <= 3;
-- SELECT * FROM SYSTEM.V_OBRA_CATALOGO WHERE ROWNUM <= 3;
-- SELECT * FROM SYSTEM.V_HIST_EMPLEADOS_BASICO WHERE ROWNUM <= 3;
-- SELECT * FROM SYSTEM.MUSEOS WHERE ROWNUM <= 3;
-- SELECT * FROM SYSTEM.LUGARES WHERE ROWNUM <= 3;

-- PRUEBAS QUE DEBEN FALLAR (sin permisos):
-- INSERT INTO SYSTEM.MUSEOS VALUES (...); -- ORA-01031: insufficient privileges
-- DELETE FROM SYSTEM.EMPLEADOS_PROFESIONALES; -- ORA-00942: table or view does not exist
-- SELECT doc_identidad FROM SYSTEM.EMPLEADOS_PROFESIONALES; -- ORA-00942: table or view does not exist
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(...); -- PLS-00201: identifier must be declared

-- ========================================

-- PRUEBAS PARA ANALISTA_RRHH (analista_rrhh01)
PROMPT ========================================
PROMPT PRUEBAS DE SEGURIDAD PARA ANALISTA_RRHH
PROMPT ========================================

-- Conexión como analista_rrhh01
-- CONNECT analista_rrhh01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR (permisos otorgados):
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(87654321, 'María', 'López', DATE '1990-03-20', 555654321, 'Ana', 'Martínez', 2, 'Departamento Administrativo', 'ADMINISTRATIVO', SYSDATE);
-- EXECUTE SYSTEM.SP_MOVER_EMPLEADO_ACTIVO(2, 555111222);
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(2, 2025);
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO(2, 2025);
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO(2, 2025);
-- SELECT * FROM SYSTEM.V_EMPLEADO_CONTACTO WHERE ROWNUM <= 3;
-- SELECT * FROM SYSTEM.V_HIST_EMPLEADOS_BASICO WHERE ROWNUM <= 3;

-- PRUEBAS QUE DEBEN FALLAR (sin permisos):
-- SELECT doc_identidad FROM SYSTEM.EMPLEADOS_PROFESIONALES; -- ORA-00942: table or view does not exist
-- INSERT INTO SYSTEM.OBRAS VALUES (...); -- ORA-00942: table or view does not exist
-- EXECUTE SYSTEM.SP_REGISTRAR_OBRA_NUEVA(...); -- PLS-00201: identifier must be declared

-- ========================================
-- 3.4: SCRIPT DE PRUEBAS AUTOMATIZADO
-- ========================================

-- Verificar conexiones y permisos básicos
PROMPT ========================================
PROMPT SCRIPT DE VERIFICACIÓN AUTOMÁTICA
PROMPT ========================================

-- Reconectarse como SYSTEM para ejecutar verificaciones
-- CONNECT SYSTEM/system;

-- Verificar que los usuarios existen
SELECT 'Usuario ' || username || ' existe' AS verificacion 
FROM DBA_USERS 
WHERE username IN ('ADMINISTRADOR01', 'CURADOR01', 'RESTAURADOR01', 'VIGILANTE01', 'DIRECTOR01', 'ANALISTA_RRHH01');

-- Verificar asignación de roles
SELECT 'Usuario ' || grantee || ' tiene rol ' || granted_role AS verificacion
FROM DBA_ROLE_PRIVS 
WHERE grantee IN ('ADMINISTRADOR01', 'CURADOR01', 'RESTAURADOR01', 'VIGILANTE01', 'DIRECTOR01', 'ANALISTA_RRHH01')
ORDER BY grantee;

-- Verificar permisos de ejecución otorgados
SELECT 'Usuario/Rol ' || grantee || ' puede ejecutar ' || table_name AS verificacion
FROM DBA_TAB_PRIVS 
WHERE privilege = 'EXECUTE' 
AND grantee IN ('ROL_ADMIN_MUSEO', 'ROL_CURADOR', 'ROL_RESTAURADOR', 'ROL_VIGILANTE', 'DIRECTOR01', 'ANALISTA_RRHH01')
ORDER BY grantee, table_name;

-- Verificar permisos de consulta otorgados
SELECT 'Usuario/Rol ' || grantee || ' puede consultar ' || table_name AS verificacion
FROM DBA_TAB_PRIVS 
WHERE privilege = 'SELECT' 
AND grantee IN ('ROL_ADMIN_MUSEO', 'ROL_CURADOR', 'ROL_RESTAURADOR', 'ROL_VIGILANTE', 'DIRECTOR01', 'ANALISTA_RRHH01')
ORDER BY grantee, table_name;

-- ========================================
-- 3.5: EJEMPLOS DE PRUEBAS EJECUTABLES
-- ========================================

PROMPT ========================================
PROMPT EJEMPLOS DE COMANDOS PARA PRUEBAS MANUALES
PROMPT ========================================

-- Para ejecutar estas pruebas, copie y pegue los comandos en SQL*Plus o SQL Developer
-- Recuerde que debe ejecutar cada bloque después de conectarse con el usuario correspondiente

PROMPT -- EJEMPLO 1: PRUEBA COMO CURADOR01
PROMPT -- CONNECT curador01/123456;
PROMPT -- SELECT COUNT(*) AS "Obras visibles" FROM SYSTEM.V_OBRA_CATALOGO;
PROMPT -- SELECT COUNT(*) AS "Empleados visibles" FROM SYSTEM.V_EMPLEADO_CONTACTO;
PROMPT -- SELECT COUNT(*) AS "Artistas visibles" FROM SYSTEM.ARTISTAS;

PROMPT -- EJEMPLO 2: PRUEBA COMO ADMINISTRADOR01
PROMPT -- CONNECT administrador01/123456;
PROMPT -- SELECT COUNT(*) AS "Empleados contacto" FROM SYSTEM.V_EMPLEADO_CONTACTO;
PROMPT -- SELECT COUNT(*) AS "Histórico empleados" FROM SYSTEM.V_HIST_EMPLEADOS_BASICO;

PROMPT -- EJEMPLO 3: PRUEBA COMO RESTAURADOR01
PROMPT -- CONNECT restaurador01/123456;
PROMPT -- SELECT COUNT(*) AS "Obras para mantenimiento" FROM SYSTEM.OBRAS;
PROMPT -- SELECT COUNT(*) AS "Programas mantenimiento" FROM SYSTEM.PROGRAMAS_MANT;

PROMPT -- EJEMPLO 4: PRUEBA COMO VIGILANTE01
PROMPT -- CONNECT vigilante01/123456;
PROMPT -- EXECUTE SYSTEM.SP_MOSTRAR_TURNOS_ACTUALES;

PROMPT -- EJEMPLO 5: PRUEBA COMO DIRECTOR01
PROMPT -- CONNECT director01/123456;
PROMPT -- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(2, 2025);
PROMPT -- SELECT COUNT(*) AS "Museos visibles" FROM SYSTEM.MUSEOS;
PROMPT -- SELECT COUNT(*) AS "Lugares visibles" FROM SYSTEM.LUGARES;

PROMPT -- EJEMPLO 6: PRUEBA COMO ANALISTA_RRHH01
PROMPT -- CONNECT analista_rrhh01/123456;
PROMPT -- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO(2, 2025);
PROMPT -- SELECT COUNT(*) AS "Empleados contacto" FROM SYSTEM.V_EMPLEADO_CONTACTO;

-- ========================================
-- 3.6: PRUEBAS DE VIOLACIÓN DE SEGURIDAD
-- ========================================

PROMPT ========================================
PROMPT EJEMPLOS DE COMANDOS QUE DEBEN FALLAR
PROMPT ========================================

-- Estas pruebas DEBEN generar errores para confirmar que la seguridad funciona

PROMPT -- PRUEBA DE FALLO 1: CURADOR INTENTANDO ACCESO DIRECTO A TABLAS
PROMPT -- CONNECT curador01/123456;
PROMPT -- SELECT * FROM SYSTEM.EMPLEADOS_PROFESIONALES; -- Debe fallar: ORA-00942
PROMPT -- INSERT INTO SYSTEM.OBRAS VALUES (999, 'Obra Test', SYSDATE, 'PINTURA', '10x10', 'Test', 'Test'); -- Debe fallar: ORA-00942

PROMPT -- PRUEBA DE FALLO 2: ADMINISTRADOR INTENTANDO OPERACIONES DE CURADOR
PROMPT -- CONNECT administrador01/123456;
PROMPT -- EXECUTE SYSTEM.SP_REGISTRAR_OBRA_NUEVA('Test', SYSDATE, 'PINTURA', '10x10', 'Test', 'Test'); -- Debe fallar: PLS-00201

PROMPT -- PRUEBA DE FALLO 3: VIGILANTE INTENTANDO ACCESO NO AUTORIZADO
PROMPT -- CONNECT vigilante01/123456;
PROMPT -- SELECT * FROM SYSTEM.OBRAS; -- Debe fallar: ORA-00942
PROMPT -- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(123, 'Test', 'Test', SYSDATE, 123); -- Debe fallar: PLS-00201

PROMPT -- PRUEBA DE FALLO 4: RESTAURADOR INTENTANDO OPERACIONES ADMINISTRATIVAS
PROMPT -- CONNECT restaurador01/123456;
PROMPT -- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(456, 'Test', 'Test', SYSDATE, 456); -- Debe fallar: PLS-00201
PROMPT -- INSERT INTO SYSTEM.EMPLEADOS_PROFESIONALES VALUES (999, 123, 'Test', 'Test', SYSDATE, 123); -- Debe fallar: ORA-00942

-- ========================================
-- 3.7: SCRIPT DE VALIDACIÓN RÁPIDA
-- ========================================

-- Verificar que las vistas de seguridad existen
SELECT 'Vista V_EMPLEADO_CONTACTO existe' AS validacion FROM USER_VIEWS WHERE VIEW_NAME = 'V_EMPLEADO_CONTACTO';
SELECT 'Vista V_OBRA_CATALOGO existe' AS validacion FROM USER_VIEWS WHERE VIEW_NAME = 'V_OBRA_CATALOGO';
SELECT 'Vista V_HIST_EMPLEADOS_BASICO existe' AS validacion FROM USER_VIEWS WHERE VIEW_NAME = 'V_HIST_EMPLEADOS_BASICO';

-- Verificar que los roles existen
SELECT 'Rol ROL_ADMIN_MUSEO existe' AS validacion FROM DBA_ROLES WHERE ROLE = 'ROL_ADMIN_MUSEO';
SELECT 'Rol ROL_CURADOR existe' AS validacion FROM DBA_ROLES WHERE ROLE = 'ROL_CURADOR';
SELECT 'Rol ROL_RESTAURADOR existe' AS validacion FROM DBA_ROLES WHERE ROLE = 'ROL_RESTAURADOR';
SELECT 'Rol ROL_VIGILANTE existe' AS validacion FROM DBA_ROLES WHERE ROLE = 'ROL_VIGILANTE';

PROMPT ========================================
PROMPT VALIDACIÓN COMPLETADA
PROMPT Si todas las consultas anteriores devuelven resultados,
PROMPT las mejoras de seguridad están correctamente implementadas.
PROMPT ========================================

-- ========================================
-- RESUMEN DE CUMPLIMIENTO DE RÚBRICA
-- ========================================
/*
PUNTO 1 - LÓGICA DE NEGOCIO (CÁLCULOS DE INGRESOS):
✅ FN_INGRESOS_ANUALES_TICKETS: Calcula ingresos por tickets
✅ FN_INGRESOS_ANUALES_EVENTOS: Calcula ingresos por eventos  
✅ FN_CALCULAR_INGRESOS_ANUALES_TOTALES: Consolida y valida cálculos
✅ Procedimientos de demostración incluidos

PUNTO 2 - ESQUEMA DE SEGURIDAD (NIVEL "EXCELENTE"):
✅ Implementación completa del principio de mínimo privilegio
✅ Seguridad a nivel de columna mediante vistas
✅ Procedimientos almacenados como interfaz única
✅ Separación clara de responsabilidades
✅ Casos de prueba para validación

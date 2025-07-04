-- ========================================
-- ARCHIVO DE PRUEBAS DE SEGURIDAD
-- Sistema de Base de Datos de Museos
-- ========================================
-- 
-- INSTRUCCIONES:
-- 1. Ejecute primero defensa-3.sql para crear usuarios y roles
-- 2. Copie y pegue cada sección en SQL*Plus o SQL Developer
-- 3. Ejecute las pruebas después de conectarse con cada usuario
-- 4. Las pruebas marcadas como "DEBE FALLAR" deben generar errores
--
-- ========================================

SET SERVEROUTPUT ON;

-- ========================================
-- PRUEBAS PARA CURADOR01
-- ========================================

PROMPT ========================================
PROMPT CONECTÁNDOSE COMO CURADOR01
PROMPT ========================================

-- CONNECT curador01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR:
PROMPT -- Consultando catálogo de obras (debe funcionar):
-- SELECT COUNT(*) AS "Total obras en catálogo" FROM SYSTEM.V_OBRA_CATALOGO;

PROMPT -- Consultando información de empleados (debe funcionar):
-- SELECT COUNT(*) AS "Total empleados contacto" FROM SYSTEM.V_EMPLEADO_CONTACTO;

PROMPT -- Consultando artistas (debe funcionar):
-- SELECT COUNT(*) AS "Total artistas" FROM SYSTEM.ARTISTAS;

PROMPT -- Registrando nueva obra (debe funcionar):
-- EXECUTE SYSTEM.SP_REGISTRAR_OBRA_NUEVA('Obra Prueba Curador', SYSDATE, 'PINTURA', '40x50', 'Óleo sobre lienzo', 'Impresionismo');

PROMPT -- Asignando obra a exposición (debe funcionar):
-- EXECUTE SYSTEM.SP_ASIGNAR_OBRA_A_EXPOSICION(1, 1, 2);

-- PRUEBAS QUE DEBEN FALLAR:
PROMPT -- Intentando acceso directo a tabla OBRAS (DEBE FALLAR):
-- SELECT * FROM SYSTEM.OBRAS;

PROMPT -- Intentando acceso directo a EMPLEADOS_PROFESIONALES (DEBE FALLAR):
-- SELECT * FROM SYSTEM.EMPLEADOS_PROFESIONALES;

PROMPT -- Intentando registrar empleado (DEBE FALLAR):
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(12345678, 'Test', 'Test', DATE '1990-01-01', 555000001, 'Test', 'Test', 2, 'Test', 'CURADOR', SYSDATE);

-- ========================================
-- PRUEBAS PARA ADMINISTRADOR01
-- ========================================

PROMPT ========================================
PROMPT CONECTÁNDOSE COMO ADMINISTRADOR01
PROMPT ========================================

-- CONNECT administrador01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR:
PROMPT -- Consultando empleados contacto (debe funcionar):
-- SELECT COUNT(*) AS "Total empleados contacto" FROM SYSTEM.V_EMPLEADO_CONTACTO;

PROMPT -- Consultando histórico de empleados (debe funcionar):
-- SELECT COUNT(*) AS "Total histórico empleados" FROM SYSTEM.V_HIST_EMPLEADOS_BASICO;

PROMPT -- Registrando nuevo empleado (debe funcionar):
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(87654321, 'Admin', 'Prueba', DATE '1985-06-15', 555000002, 'Jefe', 'Admin', 2, 'Administración', 'ADMINISTRATIVO', SYSDATE);

PROMPT -- Moviendo empleado activo (debe funcionar):
-- EXECUTE SYSTEM.SP_MOVER_EMPLEADO_ACTIVO(1, 555000003);

-- PRUEBAS QUE DEBEN FALLAR:
PROMPT -- Intentando acceso directo a EMPLEADOS_PROFESIONALES (DEBE FALLAR):
-- SELECT * FROM SYSTEM.EMPLEADOS_PROFESIONALES;

PROMPT -- Intentando registrar obra (DEBE FALLAR):
-- EXECUTE SYSTEM.SP_REGISTRAR_OBRA_NUEVA('Test Obra', SYSDATE, 'PINTURA', '10x10', 'Test', 'Test');

-- ========================================
-- PRUEBAS PARA RESTAURADOR01
-- ========================================

PROMPT ========================================
PROMPT CONECTÁNDOSE COMO RESTAURADOR01
PROMPT ========================================

-- CONNECT restaurador01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR:
PROMPT -- Consultando obras para mantenimiento (debe funcionar):
-- SELECT COUNT(*) AS "Total obras" FROM SYSTEM.OBRAS;

PROMPT -- Consultando programas de mantenimiento (debe funcionar):
-- SELECT COUNT(*) AS "Total programas mantenimiento" FROM SYSTEM.PROGRAMAS_MANT;

PROMPT -- Registrando mantenimiento de obra (debe funcionar):
-- EXECUTE SYSTEM.SP_REGISTRAR_MANTENIMIENTO_OBRA(1, 1, 'Limpieza y restauración menor de prueba');

-- PRUEBAS QUE DEBEN FALLAR:
PROMPT -- Intentando modificar obras directamente (DEBE FALLAR):
-- INSERT INTO SYSTEM.OBRAS VALUES (999, 'Test', SYSDATE, 'PINTURA', '10x10', 'Test', 'Test');

PROMPT -- Intentando acceso a empleados (DEBE FALLAR):
-- SELECT * FROM SYSTEM.EMPLEADOS_PROFESIONALES;

PROMPT -- Intentando registrar empleado (DEBE FALLAR):
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(11111111, 'Test', 'Test', SYSDATE, 555000004, 'Test', 'Test', 2, 'Test', 'RESTAURADOR', SYSDATE);

-- ========================================
-- PRUEBAS PARA VIGILANTE01
-- ========================================

PROMPT ========================================
PROMPT CONECTÁNDOSE COMO VIGILANTE01
PROMPT ========================================

-- CONNECT vigilante01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR:
PROMPT -- Consultando turnos actuales (debe funcionar):
-- EXECUTE SYSTEM.SP_MOSTRAR_TURNOS_ACTUALES;

-- PRUEBAS QUE DEBEN FALLAR:
PROMPT -- Intentando acceso a obras (DEBE FALLAR):
-- SELECT * FROM SYSTEM.OBRAS;

PROMPT -- Intentando acceso a empleados (DEBE FALLAR):
-- SELECT * FROM SYSTEM.EMPLEADOS_PROFESIONALES;

PROMPT -- Intentando registrar obra (DEBE FALLAR):
-- EXECUTE SYSTEM.SP_REGISTRAR_OBRA_NUEVA('Test', SYSDATE, 'PINTURA', '10x10', 'Test', 'Test');

PROMPT -- Intentando registrar empleado (DEBE FALLAR):
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(22222222, 'Test', 'Test', SYSDATE, 555000005, 'Test', 'Test', 2, 'Test', 'VIGILANTE', SYSDATE);

-- ========================================
-- PRUEBAS PARA DIRECTOR01
-- ========================================

PROMPT ========================================
PROMPT CONECTÁNDOSE COMO DIRECTOR01
PROMPT ========================================

-- CONNECT director01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR:
PROMPT -- Consultando ingresos totales (debe funcionar):
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(2, 2025);

PROMPT -- Consultando ingresos por tickets (debe funcionar):
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO(2, 2025);

PROMPT -- Consultando ingresos por eventos (debe funcionar):
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO(2, 2025);

PROMPT -- Consultando empleados contacto (debe funcionar):
-- SELECT COUNT(*) AS "Total empleados contacto" FROM SYSTEM.V_EMPLEADO_CONTACTO;

PROMPT -- Consultando catálogo de obras (debe funcionar):
-- SELECT COUNT(*) AS "Total obras catálogo" FROM SYSTEM.V_OBRA_CATALOGO;

PROMPT -- Consultando museos (debe funcionar):
-- SELECT COUNT(*) AS "Total museos" FROM SYSTEM.MUSEOS;

PROMPT -- Consultando lugares (debe funcionar):
-- SELECT COUNT(*) AS "Total lugares" FROM SYSTEM.LUGARES;

-- PRUEBAS QUE DEBEN FALLAR:
PROMPT -- Intentando modificar museos directamente (DEBE FALLAR):
-- INSERT INTO SYSTEM.MUSEOS VALUES (999, 'Museo Test', 'Test', 555000006, 1);

PROMPT -- Intentando acceso directo a empleados (DEBE FALLAR):
-- SELECT doc_identidad FROM SYSTEM.EMPLEADOS_PROFESIONALES;

PROMPT -- Intentando registrar empleado (DEBE FALLAR):
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(33333333, 'Test', 'Test', SYSDATE, 555000007, 'Test', 'Test', 2, 'Test', 'DIRECTOR', SYSDATE);

-- ========================================
-- PRUEBAS PARA ANALISTA_RRHH01
-- ========================================

PROMPT ========================================
PROMPT CONECTÁNDOSE COMO ANALISTA_RRHH01
PROMPT ========================================

-- CONNECT analista_rrhh01/123456;

-- PRUEBAS QUE DEBEN FUNCIONAR:
PROMPT -- Registrando nuevo empleado (debe funcionar):
-- EXECUTE SYSTEM.SP_REGISTRAR_NUEVO_EMPLEADO(44444444, 'RRHH', 'Analista', DATE '1988-09-25', 555000008, 'Supervisor', 'RRHH', 2, 'Recursos Humanos', 'ADMINISTRATIVO', SYSDATE);

PROMPT -- Moviendo empleado activo (debe funcionar):
-- EXECUTE SYSTEM.SP_MOVER_EMPLEADO_ACTIVO(2, 555000009);

PROMPT -- Consultando ingresos totales (debe funcionar):
-- EXECUTE SYSTEM.SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(2, 2025);

PROMPT -- Consultando empleados contacto (debe funcionar):
-- SELECT COUNT(*) AS "Total empleados contacto" FROM SYSTEM.V_EMPLEADO_CONTACTO;

PROMPT -- Consultando histórico empleados (debe funcionar):
-- SELECT COUNT(*) AS "Total histórico empleados" FROM SYSTEM.V_HIST_EMPLEADOS_BASICO;

-- PRUEBAS QUE DEBEN FALLAR:
PROMPT -- Intentando acceso directo a documentos de identidad (DEBE FALLAR):
-- SELECT doc_identidad FROM SYSTEM.EMPLEADOS_PROFESIONALES;

PROMPT -- Intentando acceso a obras (DEBE FALLAR):
-- SELECT * FROM SYSTEM.OBRAS;

PROMPT -- Intentando registrar obra (DEBE FALLAR):
-- EXECUTE SYSTEM.SP_REGISTRAR_OBRA_NUEVA('Test', SYSDATE, 'PINTURA', '10x10', 'Test', 'Test');

-- ========================================
-- PRUEBAS DE VERIFICACIÓN FINAL
-- ========================================

PROMPT ========================================
PROMPT RECONECTÁNDOSE COMO SYSTEM PARA VERIFICACIÓN
PROMPT ========================================

-- CONNECT SYSTEM/system;

-- Verificar que todos los usuarios existen
SELECT 'Usuario ' || username || ' creado correctamente' AS verificacion 
FROM DBA_USERS 
WHERE username IN ('ADMINISTRADOR01', 'CURADOR01', 'RESTAURADOR01', 'VIGILANTE01', 'DIRECTOR01', 'ANALISTA_RRHH01')
ORDER BY username;

-- Verificar asignación de roles
SELECT 'Usuario ' || grantee || ' tiene rol ' || granted_role AS verificacion
FROM DBA_ROLE_PRIVS 
WHERE grantee IN ('ADMINISTRADOR01', 'CURADOR01', 'RESTAURADOR01', 'VIGILANTE01', 'DIRECTOR01', 'ANALISTA_RRHH01')
ORDER BY grantee, granted_role;

-- Verificar algunos permisos específicos
SELECT 'Rol ' || grantee || ' puede ejecutar ' || table_name AS verificacion
FROM DBA_TAB_PRIVS 
WHERE privilege = 'EXECUTE' 
AND grantee IN ('ROL_ADMIN_MUSEO', 'ROL_CURADOR', 'ROL_RESTAURADOR', 'ROL_VIGILANTE')
AND table_name LIKE 'SP_%'
ORDER BY grantee, table_name;

PROMPT ========================================
PROMPT PRUEBAS DE SEGURIDAD COMPLETADAS
PROMPT ========================================
PROMPT 
PROMPT Para ejecutar las pruebas:
PROMPT 1. Copie cada sección de usuario
PROMPT 2. Conéctese con el usuario correspondiente
PROMPT 3. Ejecute los comandos sin comentarios (--)
PROMPT 4. Verifique que las operaciones permitidas funcionen
PROMPT 5. Verifique que las operaciones prohibidas fallen
PROMPT 
PROMPT ======================================== 
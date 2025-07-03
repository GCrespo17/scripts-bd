--ENTREGA 3

-- ========================================
-- REFACTORIZACIÓN: PROCEDIMIENTOS A VISTAS
-- ========================================
-- Razón: Los procedimientos que solo contienen SELECT no pueden devolver resultados
-- en Oracle PL/SQL. Se convierten a VIEWs para encapsular consultas reutilizables.
-- Vista para exposiciones abiertas actualmente
CREATE OR REPLACE VIEW VISTA_EXPOSICIONES_ABIERTAS AS
SELECT 
    id_expo, 
    fecha_inicio, 
    fecha_fin, 
    id_museo, 
    nombre
FROM EXPOSICIONES_EVENTOS
WHERE SYSDATE BETWEEN fecha_inicio AND fecha_fin
ORDER BY id_museo;
/

-- Vista para museos y sus tipos de ticket actuales
CREATE OR REPLACE VIEW VISTA_MUSEOS_TICKETS_ACTUALES AS
SELECT 
    m.id_museo, 
    m.nombre, 
    tt.tipo, 
    tt.precio
FROM MUSEOS m, TIPO_TICKETS tt
WHERE m.id_museo = tt.id_museo 
  AND tt.fecha_fin IS NULL;
/

-- ========================================
-- PROCEDIMIENTOS CORREGIDOS
-- ========================================

-- Procedimiento para mostrar turnos actuales (corregido con sintaxis antigua)
CREATE OR REPLACE PROCEDURE SP_MOSTRAR_TURNOS_ACTUALES (
    p_id_museo IN MUSEOS.id_museo%TYPE
)
IS
    v_contador NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Turnos de Vigilancia Activos para el Museo ID: ' || p_id_museo || ' ---');

    FOR rec IN (
        SELECT
            vm.nombre || ' ' || vm.apellido AS vigilante,
            e.nombre AS area_asignada,
            a.turno
        FROM
            ASIGNACIONES_MES a,
            EMPLEADOS_VIGILANTE_MANT vm,
            EST_FISICA e
        WHERE
            a.id_vig_mant = vm.id_vig_mant
            AND a.id_est = e.id_est 
            AND a.id_museo = e.id_museo
            AND a.id_museo = p_id_museo
            AND TRUNC(a.mes_anio, 'MM') = TRUNC(SYSDATE, 'MM')
        ORDER BY
            area_asignada, turno
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Area: ' || RPAD(rec.area_asignada, 20) || ' | Turno: ' || RPAD(rec.turno, 15) || ' | Vigilante: ' || rec.vigilante);
        v_contador := v_contador + 1;
    END LOOP;

    IF v_contador = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron asignaciones activas para este museo en el mes actual.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al consultar los turnos: ' || SQLERRM);
        RAISE;
END;
/

-- Procedimiento para mostrar ingresos anuales de tickets (corregido)
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

-- Procedimiento para mostrar ingresos anuales de eventos (corregido)
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

-- Procedimiento para mostrar ingresos anuales totales (corregido)
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

-- Procedimiento para mostrar exposiciones que se cierran en un año específico
CREATE OR REPLACE PROCEDURE SP_MOSTRAR_EXPOSICIONES_CIERRAN_UN_ANIO(
    p_anio IN NUMBER
) 
IS
    v_contador NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Exposiciones que se cierran en ' || p_anio || ' ---');
    
    FOR rec IN (
        SELECT 
            id_expo, 
            fecha_inicio, 
            fecha_fin, 
            id_museo, 
            nombre
        FROM EXPOSICIONES_EVENTOS
        WHERE EXTRACT(YEAR FROM fecha_fin) = p_anio
        ORDER BY id_museo, fecha_fin
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || rec.id_expo || 
            ' | Museo: ' || rec.id_museo || 
            ' | Nombre: ' || rec.nombre || 
            ' | Cierra: ' || TO_CHAR(rec.fecha_fin, 'DD/MM/YYYY')
        );
        v_contador := v_contador + 1;
    END LOOP;
    
    IF v_contador = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron exposiciones que se cierren en ' || p_anio);
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al consultar exposiciones: ' || SQLERRM);
        RAISE;
END;
/

-- ========================================
-- SEGURIDAD: ROLES Y PRIVILEGIOS COMPLETOS
-- ========================================

-- Crear roles (sin ROL_VENDEDOR_TICKETS, ROL_DIRECTOR, ni ROL_ANALISTA_FINANCIERO)
CREATE ROLE ROL_ADMIN_MUSEO;
CREATE ROLE ROL_CURADOR;
CREATE ROLE ROL_RESTAURADOR;
CREATE ROLE ROL_VIGILANTE;

-- ========================================
-- ROL RESTAURADOR
-- ========================================
-- Propósito: Ejecutar mantenimientos, no definirlos
GRANT EXECUTE ON SP_REGISTRAR_MANTENIMIENTO_OBRA TO ROL_RESTAURADOR;
GRANT SELECT ON OBRAS TO ROL_RESTAURADOR;
GRANT SELECT ON PROGRAMAS_MANT TO ROL_RESTAURADOR;

-- ========================================
-- ROL VIGILANTE
-- ========================================
-- Propósito: Rol de muy bajos privilegios, solo consultar turnos
GRANT EXECUTE ON SP_MOSTRAR_TURNOS_ACTUALES TO ROL_VIGILANTE;

-- ========================================
-- USUARIO DIRECTOR (Usuario único con privilegios especiales)
-- ========================================
-- Razón: El director es un usuario único dentro del museo, no un rol
-- Se creará más adelante con privilegios específicos

-- ========================================
-- ROL CURADOR (Completado)
-- ========================================
-- Propósito: Gestor de colecciones, exposiciones y la vida de las obras de arte.
GRANT EXECUTE ON SP_REGISTRAR_OBRA_NUEVA TO ROL_CURADOR;
GRANT EXECUTE ON SP_MOVER_OBRA TO ROL_CURADOR;
GRANT EXECUTE ON SP_ASIGNAR_OBRA_A_EXPOSICION TO ROL_CURADOR;
GRANT EXECUTE ON SP_FINALIZAR_EXPOSICION TO ROL_CURADOR;

-- Privilegios de gestión de colecciones, reasignados desde Administrador
GRANT EXECUTE ON SP_INSERTAR_COLECCION TO ROL_CURADOR;
GRANT EXECUTE ON SP_MODIFICAR_ORDEN_COLECCION TO ROL_CURADOR;
GRANT EXECUTE ON SP_ELIMINAR_COLECCION TO ROL_CURADOR;

GRANT SELECT, INSERT, UPDATE ON OBRAS TO ROL_CURADOR;
GRANT SELECT, INSERT ON HIST_OBRAS_MOV TO ROL_CURADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON COLECCIONES_PERMANENTES TO ROL_CURADOR;
GRANT SELECT, INSERT ON PROGRAMAS_MANT TO ROL_CURADOR;
GRANT SELECT, INSERT, UPDATE ON EXPOSICIONES_EVENTOS TO ROL_CURADOR;
GRANT SELECT ON ARTISTAS, SALAS_EXP TO ROL_CURADOR;

-- ========================================
-- ROL ADMINISTRADOR (Gestor de Capital Humano)
-- ========================================
-- Propósito: Responsable únicamente de la gestión de personal.
GRANT EXECUTE ON SP_REGISTRAR_NUEVO_EMPLEADO TO ROL_ADMIN_MUSEO;
GRANT EXECUTE ON SP_MOVER_EMPLEADO_ACTIVO TO ROL_ADMIN_MUSEO;
GRANT SELECT, INSERT, UPDATE ON EMPLEADOS_PROFESIONALES TO ROL_ADMIN_MUSEO;
GRANT SELECT, INSERT ON HIST_EMPLEADOS TO ROL_ADMIN_MUSEO;
GRANT SELECT, INSERT, UPDATE, DELETE ON EST_ORGANIZACIONAL TO ROL_ADMIN_MUSEO;
GRANT SELECT, INSERT, UPDATE, DELETE ON FORMACIONES TO ROL_ADMIN_MUSEO;
GRANT SELECT, INSERT, UPDATE, DELETE ON EMPLEADOS_IDIOMAS TO ROL_ADMIN_MUSEO;

-- ========================================
-- NOTA: ANALISTA FINANCIERO NO ES UN ROL INDEPENDIENTE
-- ========================================
-- Razón: Los privilegios del analista financiero se asignan directamente al Director.

-- ========================================
-- NOTA: VENDEDOR DE TICKETS NO EXISTE
-- ========================================
-- Razón: Según especificaciones, el rol de vendedor de tickets no debe existir

-- ========================================
-- USUARIOS DE PRUEBA
-- ========================================
CREATE USER administrador01 IDENTIFIED BY 123456;
CREATE USER curador01 IDENTIFIED BY 123456;
CREATE USER restaurador01 IDENTIFIED BY 123456;
CREATE USER vigilante01 IDENTIFIED BY 123456;

-- Usuario Director (único con privilegios especiales)
CREATE USER director01 IDENTIFIED BY 123456;

-- Usuario Especializado (con privilegios mixtos)
CREATE USER analista_rrhh01 IDENTIFIED BY 123456;

-- Asignar roles a usuarios (excepto director y analista)
GRANT ROL_ADMIN_MUSEO TO administrador01;
GRANT ROL_CURADOR TO curador01;
GRANT ROL_RESTAURADOR TO restaurador01;
GRANT ROL_VIGILANTE TO vigilante01;

-- El analista de RRHH hereda la gestión de personal y recibe privilegios de análisis
GRANT ROL_ADMIN_MUSEO TO analista_rrhh01;
GRANT SELECT ON V_MUSEOS_RANKING_SCORES TO analista_rrhh01;
GRANT SELECT ON VISTA_EXPOSICIONES_ABIERTAS TO analista_rrhh01;
GRANT SELECT ON VISTA_MUSEOS_TICKETS_ACTUALES TO analista_rrhh01;
GRANT EXECUTE ON SP_CALCULAR_RANKING_MUSEO TO analista_rrhh01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO TO analista_rrhh01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO TO analista_rrhh01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO TO analista_rrhh01;

-- ========================================
-- PRIVILEGIOS ESPECIALES PARA DIRECTOR
-- ========================================
-- El director tiene privilegios de solo lectura para la toma de decisiones.
-- No hereda roles transaccionales para prevenir modificaciones no deseadas.

-- Privilegios de consulta sobre Vistas de alto nivel
GRANT SELECT ON V_MUSEOS_RANKING_SCORES TO director01;
GRANT SELECT ON VISTA_EXPOSICIONES_ABIERTAS TO director01;
GRANT SELECT ON VISTA_MUSEOS_TICKETS_ACTUALES TO director01;

-- Privilegios de ejecución sobre procedimientos de reporte y cálculo
GRANT EXECUTE ON SP_CALCULAR_RANKING_MUSEO TO director01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO TO director01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO TO director01;
GRANT EXECUTE ON SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO TO director01;

-- Permisos de consulta sobre tablas maestras para análisis
GRANT SELECT ON MUSEOS TO director01;
GRANT SELECT ON OBRAS TO director01;
GRANT SELECT ON EMPLEADOS_PROFESIONALES TO director01;
GRANT SELECT ON HIST_EMPLEADOS TO director01;
GRANT SELECT ON COLECCIONES_PERMANENTES TO director01;

-- Otorgar permiso de conexión
GRANT CREATE SESSION TO administrador01, curador01, restaurador01, vigilante01, director01, analista_rrhh01;

-- ========================================
-- DEMOSTRACIONES Y PRUEBAS
-- ========================================

-- Mostrar ingresos totales antes de las transacciones
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(2, 2025);

-- Mostrar museos y tipos de ticket actuales usando la vista
SELECT * FROM VISTA_MUSEOS_TICKETS_ACTUALES;

-- Simulación de venta de ticket
DECLARE
    v_museo_id      NUMBER := 2;
    v_tipo_ticket   VARCHAR2(50) := 'ADULTO';
    v_ticket_id     NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== SIMULACIÓN DE VENTA DE TICKET ===');
    
    -- Llamar al procedimiento para vender un ticket de adulto
    SP_VENDER_TICKET(
        p_id_museo          => v_museo_id,
        p_tipo_ticket       => v_tipo_ticket,
        p_id_ticket_generado => v_ticket_id
    );
    
    DBMS_OUTPUT.PUT_LINE('Ticket vendido exitosamente. ID del Ticket: ' || v_ticket_id);
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al vender el ticket: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/

-- Verificar ingresos después de la venta
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO(2, 2025);

-- Mostrar exposiciones abiertas usando la vista
SELECT * FROM VISTA_EXPOSICIONES_ABIERTAS;

-- Mostrar exposiciones que se cierran en 2025
EXECUTE SP_MOSTRAR_EXPOSICIONES_CIERRAN_UN_ANIO(2025);

-- Simulación de finalización de exposición
DECLARE
    v_id_expo_a_cerrar  NUMBER := 9;
    v_id_museo_expo     NUMBER := 3;
    v_total_visitantes  NUMBER := 15000; 
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== SIMULACIÓN DE FINALIZACIÓN DE EXPOSICIÓN ===');
    
    -- Finalizar la exposición y registrar visitantes
    SP_FINALIZAR_EXPOSICION(
        p_id_expo         => v_id_expo_a_cerrar,
        p_id_museo        => v_id_museo_expo,
        p_cant_visitantes => v_total_visitantes
    );

    DBMS_OUTPUT.PUT_LINE('La exposición ha sido finalizada exitosamente.');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al finalizar la exposición: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/

-- Verificación final de ingresos
DBMS_OUTPUT.PUT_LINE('=== VERIFICACIÓN FINAL DE INGRESOS ===');
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO(2, 2025);

-- 2. Verifica el nuevo total de ingresos por eventos.
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO(2, 2025);

-- 3. Verifica el nuevo total anual.
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(2, 2025);

-- Demostración de turnos de vigilancia
EXECUTE SP_MOSTRAR_TURNOS_ACTUALES(1);

-- ========================================
-- COMENTARIOS FINALES
-- ========================================
/*
MEJORAS IMPLEMENTADAS:

1. REFACTORIZACIÓN:
   - Convertidos procedimientos de consulta simple a VIEWs
   - Corregida sintaxis JOIN a formato antiguo
   - Eliminados procedimientos problemáticos

2. SEGURIDAD COMPLETA:
   - Completados privilegios para ROL_RESTAURADOR
   - Completados privilegios para ROL_VIGILANTE  
   - DIRECTOR como usuario único (no rol) con privilegios especiales
   - VENDEDOR DE TICKETS eliminado según especificaciones
   - ANALISTA FINANCIERO como privilegios directos del Director (no rol)
   - Creados usuarios de prueba para roles existentes

3. CALIDAD DE CÓDIGO:
   - Agregado manejo de errores robusto
   - Mejorados mensajes informativos
   - Documentación clara de propósitos

4. FUNCIONALIDAD:
   - Procedimientos corregidos para mostrar resultados correctamente
   - Demostraciones funcionales de todos los casos de uso

5. AJUSTES ESPECÍFICOS:
   - Director: Usuario único con privilegios de admin + analista + extras
   - Vendedor: Rol eliminado según requerimientos del proyecto
   - Analista Financiero: Sus privilegios se otorgan directamente al Director, no es un rol separado.
*/

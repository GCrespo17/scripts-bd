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

-- ========================================
-- RESUMEN DE PERMISOS POR USUARIO
-- ========================================
/*
Aquí se detalla qué procedimientos puede ejecutar y en qué tablas puede insertar, actualizar o borrar cada usuario.

-- USUARIO: administrador01
-- ROLES ASIGNADOS: ROL_ADMIN_MUSEO
-- PROCEDIMIENTOS QUE PUEDE EJECUTAR:
--   - SP_REGISTRAR_NUEVO_EMPLEADO (para dar de alta nuevos empleados)
--   - SP_MOVER_EMPLEADO_ACTIVO (para reubicar empleados activos)
-- TABLAS DONDE PUEDE INSERTAR/ACTUALIZAR/BORRAR:
--   - EMPLEADOS_PROFESIONALES (INSERT, UPDATE) - Gestión de datos personales de empleados.
--   - HIST_EMPLEADOS (INSERT) - Registro de historial laboral de empleados (actualiza, pero vía SP).
--   - EST_ORGANIZACIONAL (INSERT, UPDATE, DELETE) - Gestión de la estructura organizacional del museo.
--   - FORMACIONES (INSERT, UPDATE, DELETE) - Gestión de la formación académica de empleados.
--   - EMPLEADOS_IDIOMAS (INSERT, UPDATE, DELETE) - Gestión de los idiomas que hablan los empleados.

-- USUARIO: curador01
-- ROLES ASIGNADOS: ROL_CURADOR
-- PROCEDIMIENTOS QUE PUEDE EJECUTAR:
--   - SP_REGISTRAR_OBRA_NUEVA (para registrar nuevas obras de arte)
--   - SP_MOVER_OBRA (para mover obras dentro o entre museos)
--   - SP_ASIGNAR_OBRA_A_EXPOSICION (para asignar obras a exposiciones)
--   - SP_FINALIZAR_EXPOSICION (para finalizar exposiciones y registrar visitantes)
--   - SP_INSERTAR_COLECCION (para añadir nuevas colecciones permanentes)
--   - SP_MODIFICAR_ORDEN_COLECCION (para reordenar colecciones)
--   - SP_ELIMINAR_COLECCION (para eliminar colecciones)
-- TABLAS DONDE PUEDE INSERTAR/ACTUALIZAR/BORRAR:
--   - OBRAS (INSERT, UPDATE) - Gestión de las obras de arte.
--   - HIST_OBRAS_MOV (INSERT) - Registro de movimientos históricos de obras (actualiza, pero vía SP).
--   - COLECCIONES_PERMANENTES (INSERT, UPDATE, DELETE) - Gestión de las colecciones.
--   - PROGRAMAS_MANT (INSERT) - Registro de programas de mantenimiento (solo inserta, actualizaciones vía otros roles/SPs).
--   - EXPOSICIONES_EVENTOS (INSERT, UPDATE) - Gestión de exposiciones y eventos.

-- USUARIO: restaurador01
-- ROLES ASIGNADOS: ROL_RESTAURADOR
-- PROCEDIMIENTOS QUE PUEDE EJECUTAR:
--   - SP_REGISTRAR_MANTENIMIENTO_OBRA (para registrar mantenimientos realizados a obras)
-- TABLAS DONDE PUEDE INSERTAR/ACTUALIZAR/BORRAR:
--   - No tiene permisos de INSERT/UPDATE/DELETE directos sobre tablas para evitar modificaciones accidentales. Solo puede consultar.

-- USUARIO: vigilante01
-- ROLES ASIGNADOS: ROL_VIGILANTE
-- PROCEDIMIENTOS QUE PUEDE EJECUTAR:
--   - SP_MOSTRAR_TURNOS_ACTUALES (para consultar sus turnos de vigilancia)
-- TABLAS DONDE PUEDE INSERTAR/ACTUALIZAR/BORRAR:
--   - No tiene permisos de INSERT/UPDATE/DELETE directos sobre tablas.

-- USUARIO: director01
-- ROLES ASIGNADOS: Ninguno directamente, privilegios explícitos.
-- PROCEDIMIENTOS QUE PUEDE EJECUTAR (para análisis y reportes):
--   - SP_CALCULAR_RANKING_MUSEO
--   - SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO
--   - SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO
--   - SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO
-- TABLAS/VISTAS DONDE PUEDE CONSULTAR (SELECT):
--   - V_MUSEOS_RANKING_SCORES
--   - VISTA_EXPOSICIONES_ABIERTAS
--   - VISTA_MUSEOS_TICKETS_ACTUALES
--   - MUSEOS
--   - OBRAS
--   - EMPLEADOS_PROFESIONALES
--   - HIST_EMPLEADOS
--   - COLECCIONES_PERMANENTES

-- USUARIO: analista_rrhh01
-- ROLES ASIGNADOS: ROL_ADMIN_MUSEO (hereda todos sus permisos).
-- PROCEDIMIENTOS QUE PUEDE EJECUTAR (además de los de ROL_ADMIN_MUSEO):
--   - SP_CALCULAR_RANKING_MUSEO
--   - SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO
--   - SP_MOSTRAR_INGRESOS_ANUALES_EVENTOS_MUSEO
--   - SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO
-- TABLAS/VISTAS DONDE PUEDE CONSULTAR (SELECT) (además de las de ROL_ADMIN_MUSEO):
--   - V_MUSEOS_RANKING_SCORES
--   - VISTA_EXPOSICIONES_ABIERTAS
--   - VISTA_MUSEOS_TICKETS_ACTUALES

*/

-- ========================================
-- DEMOSTRACIÓN DE PRIVILEGIOS POR USUARIO
-- ========================================

-- Habilitar la salida de DBMS_OUTPUT para ver los resultados de los procedimientos
SET SERVEROUTPUT ON;

-- DEMOSTRACIÓN PARA USUARIO: administrador01
-- (Conectarse como: CONNECT administrador01/123456;)

-- 1. Registrar un nuevo empleado
-- (Asegúrate de que 'DIRECCION' y el museo 1 existan)
DECLARE
    v_id_empleado NUMBER;
BEGIN
    SP_REGISTRAR_NUEVO_EMPLEADO(
        p_doc_identidad      => 100000001,
        p_primer_nombre      => 'Juan',
        p_primer_apellido    => 'Perez',
        p_fecha_nacimiento   => TO_DATE('1990-01-15', 'YYYY-MM-DD'),
        p_contacto           => 5551234567,
        p_segundo_nombre     => NULL,
        p_segundo_apellido   => NULL,
        p_id_museo           => 1, -- ID de un museo existente
        p_nombre_unidad_org  => 'DIRECCION', -- Nombre de una unidad organizacional existente para ese museo
        p_cargo              => 'ADMINISTRATIVO',
        p_fecha_inicio_cargo => SYSDATE,
        p_id_empleado_generado => v_id_empleado
    );
    DBMS_OUTPUT.PUT_LINE('Empleado Juan Perez registrado con ID: ' || v_id_empleado);
    COMMIT;
EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); ROLLBACK; END;
/

-- 2. Mover un empleado activo (ej. cambiar su cargo)
-- (Reemplaza 100000001 por la cedula de un empleado activo)
DECLARE
    v_empleado_id EMPLEADOS_PROFESIONALES.id_empleado%TYPE;
BEGIN
    SELECT id_empleado INTO v_empleado_id FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 100000001;
    SP_MOVER_EMPLEADO_ACTIVO(
        n_id_empleado => v_empleado_id,
        n_cargo       => 'CURADOR' -- Nuevo cargo
    );
    DBMS_OUTPUT.PUT_LINE('Empleado ' || v_empleado_id || ' movido a nuevo cargo.');
    COMMIT;
EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); ROLLBACK; END;
/

-- 3. Insertar una formación para un empleado
-- (Asegúrate de que el empleado 100000001 exista)
INSERT INTO FORMACIONES (id_formacion, id_empleado_prof, titulo, anio, descripcion_espec)
VALUES (seq_formacion.NEXTVAL, (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 100000001), 'Máster en Gestión Cultural', 2023, 'Especialización en museografía');
COMMIT;

-- 4. Actualizar un idioma de un empleado
-- (Asegúrate de que el empleado 100000001 y el idioma 1 existan y estén asociados)
UPDATE EMPLEADOS_IDIOMAS
SET id_idioma = 2 -- Nuevo ID de idioma existente
WHERE id_empleado = (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 100000001) AND id_idioma = 1;
COMMIT;

-- DEMOSTRACIÓN PARA USUARIO: curador01
-- (Conectarse como: CONNECT curador01/123456;)

-- 1. Registrar una nueva obra
-- (Asegúrate de tener IDs de museo, colección, sala, y empleado existentes para este museo)
DECLARE
    v_obra_id NUMBER;
BEGIN
    SP_REGISTRAR_OBRA_NUEVA(
        n_nombre            => 'La Noche Estrellada Réplica',
        n_fecha_periodo     => TO_DATE('1889-06-01', 'YYYY-MM-DD'),
        n_tipo_obra         => 'PINTURA',
        n_dimensiones       => '73.7 cm x 92.1 cm',
        n_desc_mat_tec      => 'Óleo sobre lienzo',
        n_desc_estilos      => 'Postimpresionismo',
        n_id_museo          => 1, -- Asegúrate que el museo 1 exista
        n_id_coleccion      => 1, -- Asegúrate que la colección 1 exista para el museo 1
        n_id_sala           => 1, -- Asegúrate que la sala 1 exista para el museo 1
        n_id_empleado       => 1, -- Asegúrate que el empleado 1 sea un curador/restaurador del museo 1
        n_tipo_adq          => 'COMPRADA',
        n_destacada         => 'SI',
        n_orden_recorrido   => NULL,
        n_valor_monetario   => 1500000
    );
    DBMS_OUTPUT.PUT_LINE('Obra registrada.');
    COMMIT;
EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); ROLLBACK; END;
/

-- 2. Mover una obra (ej. cambiarla de sala dentro del mismo museo)
-- (Asegúrate de que la obra 1 y las IDs de destino existan y pertenezcan al museo)
DECLARE
    v_obra_id_a_mover OBRAS.id_obra%TYPE;
BEGIN
    -- Obtener el ID de una obra existente (ajusta la consulta si es necesario)
    SELECT id_obra INTO v_obra_id_a_mover FROM OBRAS WHERE nombre = 'La Noche Estrellada Réplica';

    SP_MOVER_OBRA(
        n_id_obra                 => v_obra_id_a_mover,
        p_id_museo_destino        => 1, -- Mismo museo
        p_id_coleccion_destino    => 1, -- Misma colección o nueva
        p_id_sala_destino         => 2, -- Nueva sala en el mismo museo
        p_id_empleado_destino     => 1, -- El curador/restaurador actual
        p_destacada_destino       => 'SI' -- Opcional, si quieres cambiar su estado de destacada
    );
    DBMS_OUTPUT.PUT_LINE('Obra ' || v_obra_id_a_mover || ' movida.');
    COMMIT;
EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); ROLLBACK; END;
/

-- 3. Asignar una obra a una exposición
-- (Asegúrate de tener IDs de obra, exposición y museo existentes)
DECLARE
    v_obra_id_exposicion OBRAS.id_obra%TYPE;
BEGIN
    -- Obtener el ID de una obra existente
    SELECT id_obra INTO v_obra_id_exposicion FROM OBRAS WHERE nombre = 'La Noche Estrellada Réplica';
    SP_ASIGNAR_OBRA_A_EXPOSICION(
        p_id_obra             => v_obra_id_exposicion,
        p_id_expo             => 1, -- ID de una exposición activa existente
        p_id_museo            => 1, -- ID del museo
        p_orden_en_exposicion => 1
    );
    DBMS_OUTPUT.PUT_LINE('Obra ' || v_obra_id_exposicion || ' asignada a exposición.');
    COMMIT;
EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); ROLLBACK; END;
/

-- 4. Finalizar una exposición (ej. ID 9, museo 3, con 15000 visitantes, si ya no está activa ajusta ID)
EXECUTE SP_FINALIZAR_EXPOSICION(9, 3, 15000);
COMMIT;

-- 5. Insertar una nueva colección
-- (Asegúrate de que el museo 'MUSEO NACIONAL DE ARTE' y el departamento 'DIRECCION' existan)
EXECUTE SP_INSERTAR_COLECCION('MUSEO NACIONAL DE ARTE', 'DIRECCION', 'Colección de Arte Contemporáneo', 'Obras de arte contemporáneo de artistas latinoamericanos', 'CONTEMPORANEO', 5);
COMMIT;

-- 6. Actualizar una obra
-- (Asegúrate de que la obra con nombre 'La Noche Estrellada Réplica' exista)
UPDATE OBRAS SET dimensiones = '75 cm x 95 cm' WHERE nombre = 'La Noche Estrellada Réplica';
COMMIT;

-- DEMOSTRACIÓN PARA USUARIO: restaurador01
-- (Conectarse como: CONNECT restaurador01/123456;)

-- 1. Registrar un mantenimiento realizado a una obra
-- (Asegúrate de que exista un PROGRAMAS_MANT.id_mant y un empleado restaurador con esa id)
DECLARE
    v_id_empleado_restaurador EMPLEADOS_PROFESIONALES.id_empleado%TYPE;
    v_id_mant_programa PROGRAMAS_MANT.id_mant%TYPE;
BEGIN
    -- Puedes seleccionar un ID de programa de mantenimiento existente y un empleado restaurador
    SELECT id_empleado INTO v_id_empleado_restaurador FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 100000001; -- Asumiendo que este empleado fue asignado como restaurador
    SELECT id_mant INTO v_id_mant_programa FROM PROGRAMAS_MANT WHERE ROWNUM = 1; -- Selecciona cualquier programa existente

    SP_REGISTRAR_MANTENIMIENTO_OBRA(
        n_id_mant       => v_id_mant_programa,
        n_id_empleado   => v_id_empleado_restaurador,
        n_observaciones => 'Limpieza superficial y revisión de bastidor.',
        n_fecha_fin     => SYSDATE
    );
    DBMS_OUTPUT.PUT_LINE('Mantenimiento registrado.');
    COMMIT;
EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); ROLLBACK; END;
/

-- 2. Consultar obras (solo lectura)
SELECT id_obra, nombre FROM OBRAS WHERE ROWNUM <= 5;

-- DEMOSTRACIÓN PARA USUARIO: vigilante01
-- (Conectarse como: CONNECT vigilante01/123456;)

-- 1. Mostrar turnos actuales
EXECUTE SP_MOSTRAR_TURNOS_ACTUALES(1); -- ID del museo

-- DEMOSTRACIÓN PARA USUARIO: director01
-- (Conectarse como: CONNECT director01/123456;)

-- 1. Calcular el ranking de un museo
DECLARE
    v_antiguedad NUMBER;
    v_rotacion NUMBER;
    v_visitas NUMBER;
    v_categoria VARCHAR2(100);
BEGIN
    SP_CALCULAR_RANKING_MUSEO(
        p_id_museo                  => 1, -- ID de un museo existente
        p_antiguedad_promedio_anios => v_antiguedad,
        p_tasa_rotacion_alta_pct    => v_rotacion,
        p_visitas_ultimo_anio       => v_visitas,
        p_categoria_ranking         => v_categoria
    );
    DBMS_OUTPUT.PUT_LINE('Museo 1 Ranking: Antiguedad Promedio: ' || v_antiguedad || ' años, Rotación Alta: ' || v_rotacion || '%, Visitas Último Año: ' || v_visitas || ', Categoría: ' || v_categoria);
EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); END;
/

-- 2. Mostrar ingresos anuales de tickets para un museo
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_TICKETS_MUSEO(2, 2025); -- ID del museo, Año

-- 3. Mostrar ingresos anuales totales para un museo
EXECUTE SP_MOSTRAR_INGRESOS_ANUALES_TOTALES_MUSEO(2, 2025); -- ID del museo, Año

-- 4. Consultar el ranking de museos (vista)
SELECT * FROM V_MUSEOS_RANKING_SCORES WHERE ROWNUM <= 5;

-- 5. Consultar tablas maestras (solo SELECT)
SELECT id_museo, nombre FROM MUSEOS WHERE ROWNUM <= 3;
SELECT id_empleado, primer_nombre, primer_apellido FROM EMPLEADOS_PROFESIONALES WHERE ROWNUM <= 3;

-- DEMOSTRACIÓN PARA USUARIO: analista_rrhh01
-- (Conectarse como: CONNECT analista_rrhh01/123456;)

-- Este usuario tiene los mismos permisos que administrador01 + los de análisis del director.
-- Por lo tanto, puede ejecutar todas las demostraciones de administrador01 y director01.

-- Ejemplo de una operación de ADMINISTRADOR:
-- Registrar un nuevo empleado (el mismo ejemplo de administrador01, ajusta la cedula para que no se duplique)
DECLARE
    v_id_empleado NUMBER;
BEGIN
    SP_REGISTRAR_NUEVO_EMPLEADO(
        p_doc_identidad      => 100000002, -- Nueva cédula
        p_primer_nombre      => 'Maria',
        p_primer_apellido    => 'Gomez',
        p_fecha_nacimiento   => TO_DATE('1992-05-20', 'YYYY-MM-DD'),
        p_contacto           => 5559876543,
        p_segundo_nombre     => NULL,
        p_segundo_apellido   => NULL,
        p_id_museo           => 1,
        p_nombre_unidad_org  => 'DIRECCION',
        p_cargo              => 'ADMINISTRATIVO',
        p_fecha_inicio_cargo => SYSDATE,
        p_id_empleado_generado => v_id_empleado
    );
    DBMS_OUTPUT.PUT_LINE('Empleado Maria Gomez registrado con ID: ' || v_id_empleado);
    COMMIT;
EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); ROLLBACK; END;
/

-- Ejemplo de una operación de ANÁLISIS (similar a director01):
-- Calcular el ranking de un museo
DECLARE
    v_antiguedad NUMBER;
    v_rotacion NUMBER;
    v_visitas NUMBER;
    v_categoria VARCHAR2(100);
BEGIN
    SP_CALCULAR_RANKING_MUSEO(
        p_id_museo                  => 1,
        p_antiguedad_promedio_anios => v_antiguedad,
        p_tasa_rotacion_alta_pct    => v_rotacion,
        p_visitas_ultimo_anio       => v_visitas,
        p_categoria_ranking         => v_categoria
    );
    DBMS_OUTPUT.PUT_LINE('Museo 1 Ranking (Analista): Antiguedad Promedio: ' || v_antiguedad || ' años, Rotación Alta: ' || v_rotacion || '%, Visitas Último Año: ' || v_visitas || ', Categoría: ' || v_categoria);
EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); END;
/

-- Consultar el ranking de museos (vista)
SELECT * FROM V_MUSEOS_RANKING_SCORES WHERE ROWNUM <= 5;

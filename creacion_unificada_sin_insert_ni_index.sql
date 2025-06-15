-- 
-- 
-- CREATE SEQUENCE seq_lugar
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_obra
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_idioma
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_empleado_vigilante_mant
--     START WITH 1
--     INCREMENT BY 1;    
-- 
-- CREATE SEQUENCE seq_artista
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_empleado_profesional
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_formacion
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_museo
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_est_fisica
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_sala_exp
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_exposicion_evento
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_est_organizacional
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_coleccion_permanente
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_hist_obra_mov
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_programa_mant
--     START WITH 1
--     INCREMENT BY 1;
-- 
-- CREATE SEQUENCE seq_mant_obra_realizado
--     START WITH 1
--     INCREMENT BY 1;
-- 


-- NOTA: Los tickets NO usan secuencia global (cada museo tiene su numeración propia)


DROP TABLE TIPO_TICKETS;
DROP TABLE HIST_MUSEOS;
DROP TABLE TICKETS;
DROP TABLE HORARIOS;
DROP TABLE MANTENIMIENTOS_OBRAS_REALIZADOS;
DROP TABLE PROGRAMAS_MANT;
DROP TABLE HIST_OBRAS_MOV;
DROP TABLE HIST_EMPLEADOS;
DROP TABLE SALAS_COLECCIONES;
DROP TABLE COLECCIONES_PERMANENTES;
DROP TABLE EST_ORGANIZACIONAL;
DROP TABLE CIERRES_TEMPORALES;
DROP TABLE EXPOSICIONES_EVENTOS;
DROP TABLE SALAS_EXP;
DROP TABLE ASIGNACIONES_MES;
DROP TABLE EST_FISICA;
DROP TABLE MUSEOS;
DROP TABLE FORMACIONES;
DROP TABLE EMPLEADOS_IDIOMAS;
DROP TABLE EMPLEADOS_PROFESIONALES;
DROP TABLE ARTISTAS_OBRAS;
DROP TABLE ARTISTAS;
DROP TABLE EMPLEADOS_VIGILANTE_MANT;
DROP TABLE IDIOMAS;
DROP TABLE OBRAS;
DROP TABLE LUGARES;




CREATE TABLE LUGARES(
    id_lugar NUMBER DEFAULT seq_lugar.NEXTVAL PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    tipo VARCHAR2(10) NOT NULL,
    id_lugar_padre NUMBER, --FK
    continente VARCHAR2(15),
    CONSTRAINT fk_id_lugar_padre FOREIGN KEY(id_lugar_padre) REFERENCES LUGARES(id_lugar),
    CONSTRAINT check_tipo CHECK(tipo IN('PAIS', 'CIUDAD')),
    CONSTRAINT check_continente CHECK(
        (tipo = 'PAIS' AND continente IN('AMERICA', 'EUROPA', 'ASIA', 'OCEANIA', 'AFRICA', 'ANTARTICA')) OR 
        (tipo = 'CIUDAD' AND continente IS NULL)),
    CONSTRAINT check_lugar_padre CHECK(
        (tipo = 'PAIS' AND id_lugar_padre IS NULL) OR
        (tipo = 'CIUDAD' AND id_lugar_padre IS NOT NULL))
);

CREATE TABLE OBRAS(
    id_obra NUMBER DEFAULT seq_obra.NEXTVAL PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    fecha_periodo DATE NOT NULL,
    tipo_obra VARCHAR2(15) NOT NULL,
    dimensiones VARCHAR2(50) NOT NULL,
    desc_materiales_tecnicas VARCHAR2(300) NOT NULL,
    desc_estilos_generos VARCHAR2(300) NOT NULL,
    CONSTRAINT check_tipo_obra CHECK(tipo_obra IN('PINTURA', 'ESCULTURA'))
);

CREATE TABLE IDIOMAS(
    id_idioma NUMBER DEFAULT seq_idioma.NEXTVAL PRIMARY KEY,
    nombre VARCHAR2(30) NOT NULL
);

CREATE TABLE EMPLEADOS_VIGILANTE_MANT(
    id_vig_mant NUMBER DEFAULT seq_empleado_vigilante_mant.NEXTVAL PRIMARY KEY,
    nombre VARCHAR2(30) NOT NULL,
    apellido VARCHAR2(30) NOT NULL,
    doc_identidad NUMBER NOT NULL UNIQUE,
    tipo_responsable VARCHAR2(15) NOT NULL,
    CONSTRAINT check_tipo_responsable CHECK(tipo_responsable IN('VIGILANTE', 'MANTENIMIENTO'))
);

CREATE TABLE EMPLEADOS_PROFESIONALES(
    id_empleado NUMBER DEFAULT seq_empleado_profesional.NEXTVAL PRIMARY KEY,
    doc_identidad NUMBER NOT NULL UNIQUE,
    primer_nombre VARCHAR2(30) NOT NULL,
    primer_apellido VARCHAR2(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    contacto NUMBER NOT NULL,
    segundo_nombre VARCHAR2(30),
    segundo_apellido VARCHAR2(30)
);

CREATE TABLE ARTISTAS(
    id_artista NUMBER DEFAULT seq_artista.NEXTVAL PRIMARY KEY,
    resumen_caracteristicas VARCHAR2(300) NOT NULL,
    primer_nombre VARCHAR2(30),
    segundo_nombre VARCHAR2(30),
    primer_apellido VARCHAR2(30),
    segundo_apellido VARCHAR2(30),
    fecha_nacimiento DATE,
    fecha_difuncion DATE,
    apodo VARCHAR2(50),
    id_lugar NUMBER, --FK
    CONSTRAINT check_fechas CHECK(
        fecha_nacimiento IS NULL OR
        fecha_difuncion IS NULL OR
        fecha_difuncion >= fecha_nacimiento
    ),
    CONSTRAINT fk_id_lugar_artista FOREIGN KEY(id_lugar) REFERENCES LUGARES(id_lugar)
);

CREATE TABLE ARTISTAS_OBRAS(
    id_obra NUMBER NOT NULL, --PK FK
    id_artista NUMBER NOT NULL, --PK FK
    CONSTRAINT fk_obra_artista FOREIGN KEY(id_obra) REFERENCES OBRAS(id_obra),
    CONSTRAINT fk_artista_obra FOREIGN KEY(id_artista) REFERENCES ARTISTAS(id_artista),
    CONSTRAINT pk_artistas_obras PRIMARY KEY(id_obra, id_artista)
);

CREATE TABLE EMPLEADOS_IDIOMAS(
    id_empleado NUMBER NOT NULL, --PK FK
    id_idioma NUMBER NOT NULL, --PK FK
    CONSTRAINT fk_empleado_idioma FOREIGN KEY(id_empleado) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado),
    CONSTRAINT fk_idioma_empleado FOREIGN KEY(id_idioma) REFERENCES IDIOMAS(id_idioma),
    CONSTRAINT pk_empleados_idiomas PRIMARY KEY(id_empleado, id_idioma)
);

CREATE TABLE FORMACIONES(
    id_formacion NUMBER DEFAULT seq_formacion.NEXTVAL NOT NULL, --PK
    id_empleado_prof NUMBER NOT NULL, --PK FK
    titulo VARCHAR2(50) NOT NULL,
    anio NUMBER NOT NULL,
    descripcion_espec VARCHAR2(300) NOT NULL,
    CONSTRAINT fk_empleado_prof_formacion FOREIGN KEY(id_empleado_prof) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado),
    CONSTRAINT pk_formaciones PRIMARY KEY(id_formacion, id_empleado_prof)
);

CREATE TABLE MUSEOS(
    id_museo NUMBER DEFAULT seq_museo.NEXTVAL PRIMARY KEY, 
    id_lugar NUMBER NOT NULL, --FK
    nombre VARCHAR2(100) NOT NULL,
    fecha_fundacion DATE NOT NULL,
    mision VARCHAR2(300) NOT NULL,
    CONSTRAINT fk_lugar_museo FOREIGN KEY(id_lugar) REFERENCES LUGARES(id_lugar)
);

CREATE TABLE EST_FISICA(
    id_est NUMBER DEFAULT seq_est_fisica.NEXTVAL NOT NULL, --PK
    id_museo NUMBER NOT NULL, --PK FK
    nombre VARCHAR2(100) NOT NULL,
    tipo VARCHAR2(12) NOT NULL,
    descripcion VARCHAR2(300),
    direccion_edificio VARCHAR2(300),
    id_est_padre NUMBER, --FK
    CONSTRAINT fk_museo_est_fisica FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo),
    CONSTRAINT fk_est_fisica_padre FOREIGN KEY(id_est_padre, id_museo) REFERENCES EST_FISICA(id_est, id_museo),
    CONSTRAINT check_tipo_est_fisica CHECK(tipo IN('EDIFICIO', 'PISO', 'AREA')),
    CONSTRAINT pk_est_fisica PRIMARY KEY(id_est, id_museo)
);

CREATE TABLE ASIGNACIONES_MES(
    mes_anio DATE NOT NULL, --PK
    id_est NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    id_vig_mant NUMBER NOT NULL, --PK FK
    turno VARCHAR2(15) NOT NULL,
    CONSTRAINT fk_est_museo_asignacion FOREIGN KEY(id_est, id_museo) REFERENCES EST_FISICA(id_est, id_museo),
    CONSTRAINT fk_vig_mant_asignacion FOREIGN KEY(id_vig_mant) REFERENCES EMPLEADOS_VIGILANTE_MANT(id_vig_mant),
    CONSTRAINT check_turno CHECK(turno IN('MATUTINO', 'VESPERTINO', 'NOCTURNO')),
    CONSTRAINT pk_asignaciones_mes PRIMARY KEY(mes_anio, id_est, id_museo, id_vig_mant)
);

CREATE TABLE SALAS_EXP(
    id_sala NUMBER DEFAULT seq_sala_exp.NEXTVAL NOT NULL, --PK
    id_est NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    nombre VARCHAR2(50),
    descripcion VARCHAR2(300),
    CONSTRAINT fk_est_museo_sala FOREIGN KEY(id_est, id_museo) REFERENCES EST_FISICA(id_est, id_museo),
    CONSTRAINT pk_salas_exp PRIMARY KEY(id_sala, id_est, id_museo)
);

CREATE TABLE EXPOSICIONES_EVENTOS(
    id_expo NUMBER DEFAULT seq_exposicion_evento.NEXTVAL NOT NULL, --PK
    id_sala NUMBER NOT NULL, --PK FK
    id_est NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    nombre VARCHAR2(250) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    costo_persona NUMBER(8, 2),
    cant_visitantes NUMBER,
    institucion_educativa VARCHAR2(250),
    CONSTRAINT fk_sala_est_museo_exposicion FOREIGN KEY(id_sala, id_est, id_museo) REFERENCES SALAS_EXP(id_sala, id_est, id_museo),
    CONSTRAINT check_fechas_exp CHECK(fecha_inicio<=fecha_fin),
    CONSTRAINT pk_expo_eventos PRIMARY KEY(id_expo, id_sala, id_est, id_museo)
);

CREATE TABLE CIERRES_TEMPORALES(
    fecha_inicio DATE NOT NULL, --PK
    id_sala NUMBER NOT NULL, --PK FK
    id_est NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    fecha_fin DATE,
    CONSTRAINT fk_sala_est_museo_cierretemp FOREIGN KEY(id_sala, id_est, id_museo) REFERENCES SALAS_EXP(id_sala, id_est, id_museo),
    CONSTRAINT check_fechas_cierres CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
    CONSTRAINT pk_cierres_tem PRIMARY KEY(fecha_inicio, id_sala, id_est, id_museo)
);

CREATE TABLE EST_ORGANIZACIONAL(
    id_est_org NUMBER DEFAULT seq_est_organizacional.NEXTVAL NOT NULL, --PK
    id_museo NUMBER NOT NULL, --PK FK
    nombre VARCHAR2(100) NOT NULL, 
    tipo VARCHAR2(20) NOT NULL,
    nivel NUMBER NOT NULL,
    descripcion VARCHAR2(300) NOT NULL,
    id_est_org_padre NUMBER, --FK
    CONSTRAINT fk_museo_est_org FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo),
    CONSTRAINT fk_est_org_padre FOREIGN KEY(id_est_org_padre, id_museo) REFERENCES EST_ORGANIZACIONAL(id_est_org, id_museo),
    CONSTRAINT check_tipo_est_org CHECK(tipo IN('DIRECCION', 'DEPARTAMENTO', 'SECCION')),
    CONSTRAINT pk_est_organizacional PRIMARY KEY(id_est_org, id_museo)
);

CREATE TABLE COLECCIONES_PERMANENTES(
    id_coleccion NUMBER DEFAULT seq_coleccion_permanente.NEXTVAL NOT NULL, --PK
    id_est_org NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    nombre VARCHAR2(200) NOT NULL,
    caracteristicas VARCHAR2(300) NOT NULL,
    palabra_clave VARCHAR2(20) NOT NULL,
    orden_recorrido NUMBER NOT NULL,
    CONSTRAINT fk_est_org_museo_coleccion FOREIGN KEY(id_est_org, id_museo) REFERENCES EST_ORGANIZACIONAL(id_est_org, id_museo),
    CONSTRAINT pk_colecciones PRIMARY KEY(id_coleccion, id_est_org, id_museo)
);

CREATE TABLE SALAS_COLECCIONES(
    id_coleccion NUMBER NOT NULL, --PK FK
    id_est_org NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    id_sala NUMBER NOT NULL, --PK FK
    id_est_fisica NUMBER NOT NULL, --PK FK
    orden NUMBER NOT NULL,
    CONSTRAINT fk_sala_est_fis_museo FOREIGN KEY(id_sala, id_est_fisica, id_museo) REFERENCES SALAS_EXP(id_sala, id_est, id_museo),
    CONSTRAINT fk_coleccion_est_org_museo FOREIGN KEY(id_coleccion, id_est_org, id_museo) REFERENCES COLECCIONES_PERMANENTES(id_coleccion, id_est_org, id_museo),
    CONSTRAINT pk_salas_colecciones PRIMARY KEY(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica)
);

CREATE TABLE HIST_EMPLEADOS(
    fecha_inicio DATE NOT NULL, --PK
    id_est_org NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    id_empleado_prof NUMBER NOT NULL, --PK FK
    cargo VARCHAR2(50) NOT NULL,
    fecha_fin DATE,
    CONSTRAINT fk_est_org_museo_hist_emp FOREIGN KEY(id_est_org, id_museo) REFERENCES EST_ORGANIZACIONAL(id_est_org, id_museo),
    CONSTRAINT fk_empleado_hist_emp FOREIGN KEY(id_empleado_prof) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado),
    CONSTRAINT check_fechas_hist_emp CHECK(fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
    CONSTRAINT check_cargo CHECK(cargo IN('RESTAURADOR', 'CURADOR', 'DIRECTOR', 'ADMINISTRATIVO')),
    CONSTRAINT pk_hist_empleados PRIMARY KEY(fecha_inicio, id_est_org, id_museo, id_empleado_prof)
);

CREATE TABLE HIST_OBRAS_MOV(
    id_catalogo_museo NUMBER DEFAULT seq_hist_obra_mov.NEXTVAL NOT NULL, --PK
    id_obra NUMBER NOT NULL, --PK FK
    id_coleccion NUMBER NOT NULL, --FK
    id_sala NUMBER NOT NULL, --FK
    id_empleado NUMBER NOT NULL, --FK
    id_est_org NUMBER NOT NULL, --FK 
    id_museo NUMBER NOT NULL,   --FK sala y est org
    id_est_fis NUMBER NOT NULL, --FK sala
    fecha_entrada DATE NOT NULL,
    tipo_adquisicion VARCHAR2(20) NOT NULL,
    destacada VARCHAR2(2) NOT NULL,
    fecha_salida DATE,
    orden_recorrido NUMBER,
    valor_monetario NUMBER(*, 4),
    CONSTRAINT fk_obra_hist_obra FOREIGN KEY(id_obra) REFERENCES OBRAS(id_obra),
    CONSTRAINT fk_coleccion_hist_obra FOREIGN KEY(id_coleccion, id_est_org, id_museo) REFERENCES COLECCIONES_PERMANENTES(id_coleccion, id_est_org, id_museo),
    CONSTRAINT fk_sala_hist_obra FOREIGN KEY(id_sala, id_est_fis, id_museo) REFERENCES SALAS_EXP(id_sala, id_est, id_museo),
    CONSTRAINT fk_empleado_hist_obra FOREIGN KEY(id_empleado) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado),
    CONSTRAINT check_fechas_hist_ob_mov CHECK(fecha_salida IS NULL OR fecha_salida >= fecha_entrada),
    CONSTRAINT check_tipo_adq CHECK(tipo_adquisicion IN('COMPRADA', 'DONADA', 'COMPRADA A MUSEO', 'DONADA POR MUSEO')),
    CONSTRAINT check_destacada CHECK(destacada IN('SI', 'NO')),
    CONSTRAINT pk_hist_obras_mov PRIMARY KEY(id_catalogo_museo, id_obra)
);

CREATE TABLE PROGRAMAS_MANT(
    id_mant NUMBER DEFAULT seq_programa_mant.NEXTVAL NOT NULL, --PK
    id_catalogo NUMBER NOT NULL, --PK FK
    id_obra NUMBER NOT NULL, --PK FK
    actividad VARCHAR2(300) NOT NULL, 
    frecuencia VARCHAR2(100) NOT NULL,
    tipo_responsable VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_catalogo_mant FOREIGN KEY(id_catalogo, id_obra) REFERENCES HIST_OBRAS_MOV(id_catalogo_museo, id_obra),
    CONSTRAINT check_tipo_responsable_programa_mant CHECK(tipo_responsable IN('RESTAURADOR', 'CURADOR')),
    CONSTRAINT pk_programas_mant PRIMARY KEY(id_mant, id_catalogo, id_obra)
);

CREATE TABLE MANTENIMIENTOS_OBRAS_REALIZADOS(
    id_mant_realizado NUMBER DEFAULT seq_mant_obra_realizado.NEXTVAL NOT NULL, --PK
    id_mant NUMBER NOT NULL, --PK FK
    id_catalogo NUMBER NOT NULL, --PK FK
    id_obra NUMBER NOT NULL, --PK FK
    id_empleado NUMBER NOT NULL, --PK FK
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,  
    observaciones VARCHAR2(300),
    CONSTRAINT fk_mantenimiento_mant_realizado FOREIGN KEY(id_mant, id_catalogo, id_obra) REFERENCES PROGRAMAS_MANT(id_mant, id_catalogo, id_obra),
    CONSTRAINT fk_empleado_mant_realizado FOREIGN KEY(id_empleado) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado),
    CONSTRAINT check_fecha_mant_realizados CHECK(fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
    CONSTRAINT pk_mant_ralizado PRIMARY KEY(id_mant_realizado, id_mant, id_catalogo, id_obra, id_empleado)
);

CREATE TABLE HORARIOS(
    dia NUMBER NOT NULL, --PK
    id_museo NUMBER NOT NULL,  --PK FK
    hora_inicio DATE NOT NULL, 
    hora_cierre DATE NOT NULL, 
    CONSTRAINT fk_museo_horario FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo),
    CONSTRAINT check_dia CHECK(dia>=1 AND dia<=7),
    CONSTRAINT check_horas_validas CHECK (
        TO_CHAR(hora_inicio, 'HH24:MI:SS') < TO_CHAR(hora_cierre, 'HH24:MI:SS')
    ),
    CONSTRAINT pk_horarios PRIMARY KEY(dia, id_museo)
);

CREATE TABLE TICKETS(
    id_num_ticket NUMBER NOT NULL, -- PK, Se elimina el DEFAULT seq_ticket.NEXTVAL
    id_museo NUMBER NOT NULL, -- PK FK
    fecha_hora_emision DATE NOT NULL,
    tipo VARCHAR2(15) NOT NULL,
    precio NUMBER (*, 4) NOT NULL,
    CONSTRAINT fk_museo_ticket FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo),
    CONSTRAINT check_tipo_ticket CHECK(tipo IN('ESTUDIANTE', 'INFANTIL', 'ADULTO')),
    CONSTRAINT pk_ticket PRIMARY KEY(id_num_ticket, id_museo) 
);

CREATE TABLE HIST_MUSEOS(
    anio NUMBER(4) NOT NULL, --PK
    id_museo NUMBER NOT NULL, --PK FK
    hecho VARCHAR2(300) NOT NULL,
    CONSTRAINT fk_museo_hist_museo FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo),
    CONSTRAINT pk_hist_museo PRIMARY KEY(anio, id_museo)
);

CREATE TABLE TIPO_TICKETS(
    fecha_inicio DATE NOT NULL, --PK
    id_museo NUMBER NOT NULL, --PK FK
    precio NUMBER(*, 2) NOT NULL,
    tipo VARCHAR2(20) NOT NULL,
    fecha_fin DATE,
    CONSTRAINT fk_museo_tipo_ticket FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo),
    CONSTRAINT check_fechas_tipo_ticket CHECK(fecha_fin IS NULL OR fecha_fin>=fecha_inicio),
    CONSTRAINT check_tipo_hist_ticket CHECK(tipo IN('ESTUDIANTE', 'INFANTIL', 'ADULTO')),
    CONSTRAINT pk_tipo_tickets PRIMARY KEY(fecha_inicio, id_museo, tipo)
);

-- NOTA: No se agrega tabla OBSERVACIONES_MOVIMIENTOS para respetar el modelo ER fijo
-- Las observaciones se manejan a través de logs en los procedimientos

-- =============================================================================
-- CÓDIGOS DE ERROR PERSONALIZADOS UTILIZADOS EN STORED PROCEDURES
-- =============================================================================
-- Los siguientes códigos de error se utilizan consistentemente en todos los
-- procedimientos almacenados para proporcionar manejo robusto de errores:
--
-- VENTA DE TICKETS (SP_VENDER_TICKET):
-- -20010: Error de capacidad/tarifa en venta de tickets
-- -20011: Error de horario/múltiples tarifas en venta de tickets  
-- -20021: Error de concurrencia en generación de ID de ticket
-- -20022: Error interno en asignación de ID de ticket
--
-- GESTIÓN DE EMPLEADOS (SP_REGISTRAR_NUEVO_EMPLEADO):
-- -20012: Error en registro de empleados (unidad organizacional no encontrada)
--
-- GESTIÓN DE EXPOSICIONES (SP_FINALIZAR_EXPOSICION):
-- -20013: Error en finalización de exposiciones
--
-- RANKING DE MUSEOS (SP_CALCULAR_RANKING_MUSEO):
-- -20030: Error de validación de museo en ranking
-- -20031: Error inesperado en cálculo de ranking
--
-- ASIGNACIÓN DE OBRAS (SP_ASIGNAR_OBRA_A_EXPOSICION):
-- -20050: Error de validación de obra
-- -20051: Error de validación de exposición
-- -20053: Error de capacidad de exposición
-- -20059: Error inesperado en asignación de obras
-- Nota: -20052 se eliminó ya que ahora se maneja automáticamente el traspaso de obras
--
-- AUTOMATIZACIONES DE MANTENIMIENTO Y OPERACIONES:
-- -20060: Error en automatización de mantenimientos de obras
-- -20061: Error en automatización de cierres temporales
-- -20062: Error de validación de museo en programación de mantenimientos
-- -20063: Error inesperado en programación automática de mantenimientos
-- -20064: Error en automatización de historial de precios
-- -20065: Error de validación de museo en gestión de exposiciones
-- -20066: Error inesperado en gestión de estado de exposiciones
-- -20067: Error en consolidación de operaciones diarias
--
-- BLOQUES DE EJEMPLO DE USO:
-- -20040 a -20044: Errores específicos en bloques de ejemplo de uso
-- =============================================================================

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
    BEGIN
        SELECT id_museo INTO v_museo_id FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20040, 'Error: No se encontró el museo "Hamburger Kunsthalle"');
    END;

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
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
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
    BEGIN
        SELECT id_museo INTO v_museo_id FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20041, 'Error: No se encontró el museo "Museum der bildenden Künste Leipzig"');
    END;

    -- Llamar al procedimiento para registrar un nuevo Restaurador
    SP_REGISTRAR_NUEVO_EMPLEADO(
        p_doc_identidad      => 30000001,
        p_primer_nombre      => 'Clara',
        p_primer_apellido    => 'Schulz',
        p_fecha_nacimiento   => TO_DATE('1990-08-15', 'YYYY-MM-DD'),
        p_contacto           => 491798765432,
        p_id_museo           => v_museo_id,
        p_nombre_unidad_org  => 'Departamento de Colecciones MdbK',
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
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
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
    BEGIN
        SELECT id_expo, id_museo 
        INTO v_id_exposicion, v_id_museo_expo
        FROM EXPOSICIONES_EVENTOS
        WHERE nombre LIKE 'Impresionismo en Transición%' AND ROWNUM = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20042, 'Error: No se encontró ninguna exposición con el patrón "Impresionismo en Transición%"');
    END;

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
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
END;
/
*/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_CALCULAR_RANKING_MUSEO
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 07-JUN-2025
-- Descripción:
-- Calcula el ranking de un museo basándose en la permanencia de su personal.
-- Devuelve la antigüedad promedio en años, la tasa de rotación alta (personal
-- con menos de 5 años de servicio) y una categoría descriptiva del ranking.
-- Este procedimiento es llamado por la API para enriquecer el reporte de Ficha de Museo.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_CALCULAR_RANKING_MUSEO (
    p_id_museo                  IN  MUSEOS.id_museo%TYPE,
    p_antiguedad_promedio_anios OUT NUMBER,
    p_tasa_rotacion_alta_pct    OUT NUMBER,
    p_visitas_ultimo_anio       OUT NUMBER,
    p_categoria_ranking         OUT VARCHAR2
)
AS
    -- Variables para el cálculo de estabilidad del personal
    v_total_antiguedad_dias   NUMBER := 0;
    v_total_empleados         NUMBER := 0;
    v_empleados_alta_rotacion NUMBER := 0;
    v_antiguedad_promedio_anios NUMBER := 0;
    v_estabilidad_score       NUMBER := 0;

    -- Variables para el cálculo de popularidad
    v_visitas_anuales         NUMBER := 0;
    v_popularidad_score       NUMBER := 0;

    -- Variable para el ranking final
    v_ranking_final_score     NUMBER;
    
    -- Variable para validar que el museo existe
    v_museo_existe            NUMBER;

BEGIN
    -- ========= VALIDACIÓN INICIAL: Verificar que el museo existe =========
    BEGIN
        SELECT 1
        INTO v_museo_existe
        FROM MUSEOS
        WHERE id_museo = p_id_museo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20030, 
                'Error: No existe un museo con el ID ' || p_id_museo || '. Verifique el parámetro de entrada.');
    END;

    -- ========= PASO 1: Calcular la Estabilidad del Personal =========
    FOR rec IN (
        SELECT (COALESCE(fecha_fin, SYSDATE) - fecha_inicio) as dias_trabajados
        FROM HIST_EMPLEADOS
        WHERE id_museo = p_id_museo
    ) LOOP
        v_total_antiguedad_dias := v_total_antiguedad_dias + rec.dias_trabajados;
        v_total_empleados := v_total_empleados + 1;
        
        IF rec.dias_trabajados < (365.25 * 5) THEN
            v_empleados_alta_rotacion := v_empleados_alta_rotacion + 1;
        END IF;
    END LOOP;

    IF v_total_empleados > 0 THEN
        v_antiguedad_promedio_anios := (v_total_antiguedad_dias / v_total_empleados) / 365.25;
        p_antiguedad_promedio_anios := v_antiguedad_promedio_anios;
        p_tasa_rotacion_alta_pct := (v_empleados_alta_rotacion / v_total_empleados) * 100;
        
        -- Asignar un puntaje de estabilidad (0 a 10)
        v_estabilidad_score := LEAST(v_antiguedad_promedio_anios, 10);
    ELSE
        -- Si no hay empleados, asignar valores por defecto
        p_antiguedad_promedio_anios := 0;
        p_tasa_rotacion_alta_pct := 0;
        v_estabilidad_score := 1; -- Puntaje mínimo por no tener historial
    END IF;

    -- ========= PASO 2: Calcular la Popularidad por Visitas Anuales =========
    SELECT COUNT(id_num_ticket)
    INTO v_visitas_anuales
    FROM TICKETS
    WHERE id_museo = p_id_museo
      AND fecha_hora_emision >= (SYSDATE - 365);
      
    p_visitas_ultimo_anio := v_visitas_anuales;

    -- Asignar un puntaje de popularidad (0 a 10)
    IF v_visitas_anuales > 1000000 THEN v_popularidad_score := 10;
    ELSIF v_visitas_anuales > 500000 THEN v_popularidad_score := 8;
    ELSIF v_visitas_anuales > 250000 THEN v_popularidad_score := 6;
    ELSIF v_visitas_anuales > 100000 THEN v_popularidad_score := 4;
    ELSIF v_visitas_anuales > 50000 THEN v_popularidad_score := 2;
    ELSE v_popularidad_score := 1;
    END IF;

    -- ========= PASO 3: Calcular Ranking Final y Asignar Categoría =========
    -- Se da un 60% de peso a la estabilidad del personal y 40% a la popularidad.
    v_ranking_final_score := (v_estabilidad_score * 0.6) + (v_popularidad_score * 0.4);

    IF v_ranking_final_score >= 8 THEN
        p_categoria_ranking := 'Excelente (Líder del Sector)';
    ELSIF v_ranking_final_score >= 6 THEN
        p_categoria_ranking := 'Bueno (Sólido y Reconocido)';
    ELSIF v_ranking_final_score >= 4 THEN
        p_categoria_ranking := 'Regular (Estable con Potencial)';
    ELSE
        p_categoria_ranking := 'En Desarrollo (Nicho o Volátil)';
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        -- Manejo robusto de errores inesperados
        RAISE_APPLICATION_ERROR(-20031, 
            'Error inesperado al calcular el ranking del museo ID ' || p_id_museo || ': ' || SQLERRM);
END SP_CALCULAR_RANKING_MUSEO;
/

-- -----------------------------------------------------------------------------
-- VISTA: V_MUSEOS_RANKING_SCORES
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 15-NOV-2024
-- Descripción:
-- Vista que calcula los puntajes de ranking para todos los museos, permitiendo
-- comparaciones nacionales y mundiales. Reutiliza la lógica del SP_CALCULAR_RANKING_MUSEO
-- pero de forma eficiente para múltiples museos.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW V_MUSEOS_RANKING_SCORES AS
WITH EstabilidadPersonal AS (
    -- Calcular métricas de estabilidad del personal por museo
    SELECT 
        he.id_museo,
        COUNT(*) as total_empleados,
        AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25) as antiguedad_promedio_anios,
        SUM(CASE WHEN (COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) < (365.25 * 5) THEN 1 ELSE 0 END) / COUNT(*) * 100 as tasa_rotacion_alta_pct,
        -- Asignar puntaje de estabilidad (0 a 10)
        LEAST(AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25), 10) as estabilidad_score
    FROM HIST_EMPLEADOS he
    GROUP BY he.id_museo
),
PopularidadVisitas AS (
    -- Calcular métricas de popularidad por visitas anuales
    SELECT 
        t.id_museo,
        COUNT(*) as visitas_ultimo_anio,
        -- Asignar puntaje de popularidad (0 a 10)
        CASE 
            WHEN COUNT(*) > 1000000 THEN 10
            WHEN COUNT(*) > 500000 THEN 8
            WHEN COUNT(*) > 250000 THEN 6
            WHEN COUNT(*) > 100000 THEN 4
            WHEN COUNT(*) > 50000 THEN 2
            ELSE 1
        END as popularidad_score
    FROM TICKETS t
    WHERE t.fecha_hora_emision >= (SYSDATE - 365)
    GROUP BY t.id_museo
),
UbicacionMuseos AS (
    -- Obtener la ubicación (país) de cada museo
    SELECT 
        m.id_museo,
        m.nombre as nombre_museo,
        ciudad.nombre as ciudad,
        pais.id_lugar as id_pais,
        pais.nombre as pais
    FROM MUSEOS m
    JOIN LUGARES ciudad ON m.id_lugar = ciudad.id_lugar
    JOIN LUGARES pais ON ciudad.id_lugar_padre = pais.id_lugar
    WHERE ciudad.tipo = 'CIUDAD' AND pais.tipo = 'PAIS'
)
SELECT 
    um.id_museo,
    um.nombre_museo,
    um.ciudad,
    um.id_pais,
    um.pais,
    COALESCE(ep.antiguedad_promedio_anios, 0) as antiguedad_promedio_anios,
    COALESCE(ep.tasa_rotacion_alta_pct, 0) as tasa_rotacion_alta_pct,
    COALESCE(pv.visitas_ultimo_anio, 0) as visitas_ultimo_anio,
    COALESCE(ep.estabilidad_score, 1) as estabilidad_score,
    COALESCE(pv.popularidad_score, 1) as popularidad_score,
    -- Calcular puntaje final (60% estabilidad, 40% popularidad)
    (COALESCE(ep.estabilidad_score, 1) * 0.6) + (COALESCE(pv.popularidad_score, 1) * 0.4) as score_final,
    -- Asignar categoría descriptiva
    CASE 
        WHEN (COALESCE(ep.estabilidad_score, 1) * 0.6) + (COALESCE(pv.popularidad_score, 1) * 0.4) >= 8 THEN
            'Excelente (Líder del Sector)'
        WHEN (COALESCE(ep.estabilidad_score, 1) * 0.6) + (COALESCE(pv.popularidad_score, 1) * 0.4) >= 6 THEN
            'Bueno (Sólido y Reconocido)'
        WHEN (COALESCE(ep.estabilidad_score, 1) * 0.6) + (COALESCE(pv.popularidad_score, 1) * 0.4) >= 4 THEN
            'Regular (Estable con Potencial)'
        ELSE
            'En Desarrollo (Nicho o Volátil)'
    END as categoria_ranking
FROM UbicacionMuseos um
LEFT JOIN EstabilidadPersonal ep ON um.id_museo = ep.id_museo
LEFT JOIN PopularidadVisitas pv ON um.id_museo = pv.id_museo;
/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_ASIGNAR_OBRA_A_EXPOSICION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Procedimiento que asigna una obra a una exposición con manejo automático de traspasos.
-- Características principales:
-- - Si la obra está en otra exposición, automáticamente cierra esa estadía
-- - Verifica que la exposición exista y esté dentro del periodo válido
-- - Controla la capacidad máxima de obras por exposición
-- - Registra automáticamente el traspaso en las observaciones de movimiento
-- - Demuestra mejores prácticas de manejo de errores con RAISE_APPLICATION_ERROR
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_ASIGNAR_OBRA_A_EXPOSICION (
    p_id_obra              IN OBRAS.id_obra%TYPE,
    p_id_expo              IN EXPOSICIONES_EVENTOS.id_expo%TYPE,
    p_id_museo             IN EXPOSICIONES_EVENTOS.id_museo%TYPE,
    p_orden_en_exposicion  IN NUMBER DEFAULT NULL
)
AS
    -- Variables para validaciones
    v_obra_en_otra_expo    NUMBER := 0;
    v_exposicion_valida    NUMBER := 0;
    v_fecha_inicio_expo    DATE;
    v_fecha_fin_expo       DATE;
    v_nombre_expo          VARCHAR2(250);
    v_capacidad_actual     NUMBER := 0;
    v_capacidad_maxima     CONSTANT NUMBER := 50; -- Capacidad máxima por exposición
    
BEGIN
    -- ========= VALIDACIÓN 1: Verificar que la obra existe =========
    BEGIN
        SELECT 1 
        INTO v_obra_en_otra_expo -- Reutilizamos la variable para verificar existencia
        FROM OBRAS 
        WHERE id_obra = p_id_obra;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20050, 
                'Error: No existe una obra con el ID ' || p_id_obra || '. Verifique el parámetro de entrada.');
    END;

    -- ========= VALIDACIÓN 2: Verificar que la exposición existe y está activa =========
    BEGIN
        SELECT 1, fecha_inicio, fecha_fin, nombre
        INTO v_exposicion_valida, v_fecha_inicio_expo, v_fecha_fin_expo, v_nombre_expo
        FROM EXPOSICIONES_EVENTOS
        WHERE id_expo = p_id_expo 
          AND id_museo = p_id_museo
          AND SYSDATE BETWEEN fecha_inicio AND fecha_fin;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20051, 
                'Error: No existe una exposición activa con ID ' || p_id_expo || 
                ' en el museo ID ' || p_id_museo || ', o la exposición no está en período válido.');
    END;

    -- ========= PASO 3: Manejo automático de obra en otra exposición activa =========
    -- Si la obra está actualmente en otra exposición, cerramos automáticamente esa estadía
    -- para permitir su traspaso a la nueva exposición
    SELECT COUNT(*)
    INTO v_obra_en_otra_expo
    FROM HIST_OBRAS_MOV hom
    WHERE hom.id_obra = p_id_obra
      AND hom.fecha_salida IS NULL  -- La obra está actualmente activa en algún lugar
      AND hom.id_museo != p_id_museo; -- Y no está en el museo de destino

    IF v_obra_en_otra_expo > 0 THEN
        -- Cerrar automáticamente la estadía anterior de la obra
        UPDATE HIST_OBRAS_MOV
        SET fecha_salida = SYSDATE
        WHERE id_obra = p_id_obra
          AND fecha_salida IS NULL;
          
        -- Log informativo del traspaso (para auditoría en desarrollo)
        -- DBMS_OUTPUT.PUT_LINE('INFO: Obra ' || p_id_obra || ' trasladada automáticamente a exposición ID ' || p_id_expo);
    END IF;

    -- ========= VALIDACIÓN 3: Verificar capacidad de la exposición =========
    SELECT COUNT(*)
    INTO v_capacidad_actual
    FROM HIST_OBRAS_MOV hom
    JOIN EXPOSICIONES_EVENTOS ee ON (hom.id_museo = ee.id_museo)
    WHERE ee.id_expo = p_id_expo
      AND ee.id_museo = p_id_museo
      AND hom.fecha_salida IS NULL
      AND SYSDATE BETWEEN ee.fecha_inicio AND ee.fecha_fin;

    IF v_capacidad_actual >= v_capacidad_maxima THEN
        RAISE_APPLICATION_ERROR(-20053, 
            'Error: La exposición "' || v_nombre_expo || '" (ID: ' || p_id_expo || 
            ') ha alcanzado su capacidad máxima de ' || v_capacidad_maxima || ' obras.');
    END IF;

    -- ========= PASO 4: Insertar la obra en el historial de movimientos =========
    -- Nota: En una implementación real, esto requeriría más datos específicos
    -- como id_coleccion, id_sala, etc. Este es un ejemplo simplificado.
    INSERT INTO HIST_OBRAS_MOV (
        id_obra, 
        id_coleccion, 
        id_sala, 
        id_empleado, 
        id_est_org, 
        id_museo, 
        id_est_fis,
        fecha_entrada, 
        tipo_adquisicion, 
        destacada, 
        orden_recorrido
    ) 
    SELECT 
        p_id_obra,
        cp.id_coleccion,
        se.id_sala,
        1, -- ID del empleado responsable (simplificado)
        cp.id_est_org,
        p_id_museo,
        se.id_est,
        SYSDATE,
        'COMPRADA', -- Tipo por defecto
        'SI', -- Marcada como destacada en exposición
        NVL(p_orden_en_exposicion, v_capacidad_actual + 1)
    FROM COLECCIONES_PERMANENTES cp, SALAS_EXP se
    WHERE cp.id_museo = p_id_museo 
      AND se.id_museo = p_id_museo
      AND ROWNUM = 1; -- Simplificación: tomar la primera colección y sala disponible

    -- Confirmación de éxito (solo para depuración, en producción se eliminaría)
    -- DBMS_OUTPUT.PUT_LINE('Obra ' || p_id_obra || ' asignada exitosamente a la exposición "' || v_nombre_expo || '"');

EXCEPTION
    -- Los errores específicos ya se manejan con RAISE_APPLICATION_ERROR arriba
    -- Esta sección captura errores inesperados
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20059, 
            'Error inesperado al asignar la obra ' || p_id_obra || 
            ' a la exposición ' || p_id_expo || ': ' || SQLERRM);
            
END SP_ASIGNAR_OBRA_A_EXPOSICION;
/

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: SP_ASIGNAR_OBRA_A_EXPOSICION
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_id_obra         NUMBER := 1001; -- ID de una obra específica
    v_id_exposicion   NUMBER;
    v_id_museo        NUMBER;
BEGIN
    -- Obtener los datos de una exposición activa
    BEGIN
        SELECT id_expo, id_museo 
        INTO v_id_exposicion, v_id_museo
        FROM EXPOSICIONES_EVENTOS
        WHERE SYSDATE BETWEEN fecha_inicio AND fecha_fin
          AND ROWNUM = 1; -- Tomar la primera exposición activa
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20044, 'Error: No hay exposiciones activas disponibles');
    END;

    -- Asignar la obra a la exposición (con manejo automático de traspasos)
    SP_ASIGNAR_OBRA_A_EXPOSICION(
        p_id_obra              => v_id_obra,
        p_id_expo              => v_id_exposicion,
        p_id_museo             => v_id_museo,
        p_orden_en_exposicion  => 1
    );
    
    DBMS_OUTPUT.PUT_LINE('Obra ' || v_id_obra || ' asignada exitosamente a la exposición ID ' || v_id_exposicion);
    DBMS_OUTPUT.PUT_LINE('Si la obra estaba en otra exposición, se transfirió automáticamente.');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al asignar la obra: ' || SQLERRM);
        ROLLBACK;
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
END;
/
*/

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO (PL/SQL Anónimo)
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_museo_id_test NUMBER;
    v_antiguedad    NUMBER;
    v_tasa          NUMBER;
    v_visitas       NUMBER;
    v_categoria     VARCHAR2(100);
BEGIN
    -- Obtener el ID del museo con manejo de errores
    BEGIN
        SELECT id_museo INTO v_museo_id_test FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20043, 'Error: No se encontró el museo "Hamburger Kunsthalle"');
    END;

    -- Llamar al procedimiento de ranking
    SP_CALCULAR_RANKING_MUSEO(
        p_id_museo => v_museo_id_test,
        p_antiguedad_promedio_anios => v_antiguedad,
        p_tasa_rotacion_alta_pct => v_tasa,
        p_visitas_ultimo_anio => v_visitas,
        p_categoria_ranking => v_categoria
    );

    DBMS_OUTPUT.PUT_LINE('--- Ranking del Museo ID ' || v_museo_id_test || ' ---');
    DBMS_OUTPUT.PUT_LINE('Antigüedad Promedio: ' || ROUND(v_antiguedad, 2) || ' años');
    DBMS_OUTPUT.PUT_LINE('Tasa de Rotación (<5 años): ' || ROUND(v_tasa, 2) || '%');
    DBMS_OUTPUT.PUT_LINE('Visitas en el último año: ' || v_visitas);
    DBMS_OUTPUT.PUT_LINE('Categoría Final: ' || v_categoria);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al calcular el ranking: ' || SQLERRM);
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
END;
/
*/

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
-- STORED PROCEDURE: SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Automatiza la programación de mantenimientos basándose en la frecuencia
-- definida en PROGRAMAS_MANT. Identifica obras que requieren mantenimiento
-- y programa automáticamente las tareas pendientes.
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO (
    p_id_museo          IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_dias_anticipacion IN NUMBER DEFAULT 30,
    p_registros_procesados OUT NUMBER
)
AS
    v_contador NUMBER := 0;
    v_fecha_programada DATE;
    v_empleado_responsable NUMBER;
    
    -- Cursor para obras que requieren mantenimiento
    CURSOR c_obras_mantenimiento IS
        SELECT DISTINCT 
            pm.id_mant,
            pm.id_catalogo,
            pm.id_obra,
            pm.actividad,
            pm.frecuencia,
            pm.tipo_responsable,
            hom.id_museo,
            COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) as ultima_fecha_mant
        FROM PROGRAMAS_MANT pm
        JOIN HIST_OBRAS_MOV hom ON (pm.id_catalogo = hom.id_catalogo_museo AND pm.id_obra = hom.id_obra)
        LEFT JOIN MANTENIMIENTOS_OBRAS_REALIZADOS mor ON (pm.id_mant = mor.id_mant 
                                                          AND pm.id_catalogo = mor.id_catalogo 
                                                          AND pm.id_obra = mor.id_obra)
        WHERE hom.fecha_salida IS NULL -- Solo obras actualmente en el museo
          AND (p_id_museo IS NULL OR hom.id_museo = p_id_museo)
        GROUP BY pm.id_mant, pm.id_catalogo, pm.id_obra, pm.actividad, pm.frecuencia, 
                 pm.tipo_responsable, hom.id_museo, hom.fecha_entrada
        HAVING (
            -- Mantenimiento mensual
            (pm.frecuencia LIKE '%MENSUAL%' AND 
             COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 30 + p_dias_anticipacion) OR
            -- Mantenimiento trimestral
            (pm.frecuencia LIKE '%TRIMESTRAL%' AND 
             COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 90 + p_dias_anticipacion) OR
            -- Mantenimiento semestral
            (pm.frecuencia LIKE '%SEMESTRAL%' AND 
             COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 180 + p_dias_anticipacion) OR
            -- Mantenimiento anual
            (pm.frecuencia LIKE '%ANUAL%' AND 
             COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 365 + p_dias_anticipacion)
        );

BEGIN
    -- Validar que el museo existe si se especifica
    IF p_id_museo IS NOT NULL THEN
        BEGIN
            SELECT 1 INTO v_contador FROM MUSEOS WHERE id_museo = p_id_museo;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20062, 
                    'Error: No existe un museo con ID ' || p_id_museo);
        END;
    END IF;

    v_contador := 0;

    -- Procesar cada obra que requiere mantenimiento
    FOR rec IN c_obras_mantenimiento LOOP
        BEGIN
            -- Buscar un empleado responsable disponible
            SELECT id_empleado
            INTO v_empleado_responsable
            FROM HIST_EMPLEADOS he
            JOIN EMPLEADOS_PROFESIONALES ep ON he.id_empleado_prof = ep.id_empleado
            WHERE he.id_museo = rec.id_museo
              AND he.fecha_fin IS NULL
              AND he.cargo = rec.tipo_responsable
              AND ROWNUM = 1;

            -- Programar el mantenimiento
            INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
                id_mant,
                id_catalogo,
                id_obra,
                id_empleado,
                fecha_inicio,
                observaciones
            ) VALUES (
                rec.id_mant,
                rec.id_catalogo,
                rec.id_obra,
                v_empleado_responsable,
                SYSDATE,
                'Mantenimiento programado automáticamente. Actividad: ' || rec.actividad ||
                '. Frecuencia: ' || rec.frecuencia ||
                '. Último mantenimiento: ' || TO_CHAR(rec.ultima_fecha_mant, 'DD-MON-YYYY')
            );

            v_contador := v_contador + 1;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- No hay empleado disponible del tipo requerido
                CONTINUE;
            WHEN OTHERS THEN
                -- Log el error pero continuar con el siguiente
                CONTINUE;
        END;
    END LOOP;

    p_registros_procesados := v_contador;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20063, 
            'Error inesperado en programación automática de mantenimientos: ' || SQLERRM);
END SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO;
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
-- STORED PROCEDURE: SP_GESTIONAR_ESTADO_EXPOSICIONES
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Automatiza la gestión del estado de exposiciones basándose en fechas:
-- - Identifica exposiciones que deberían estar activas pero no tienen obras asignadas
-- - Identifica exposiciones vencidas que aún tienen obras asignadas
-- - Proporciona recomendaciones automáticas para la gestión
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_GESTIONAR_ESTADO_EXPOSICIONES (
    p_id_museo         IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_accion_automatica IN VARCHAR2 DEFAULT 'REPORTE', -- 'REPORTE' o 'EJECUTAR'
    p_registros_procesados OUT NUMBER
)
AS
    v_contador NUMBER := 0;
    v_obras_asignadas NUMBER;
    
    -- Cursor para exposiciones que requieren atención
    CURSOR c_exposiciones_revision IS
        SELECT 
            ee.id_expo,
            ee.id_museo,
            ee.nombre,
            ee.fecha_inicio,
            ee.fecha_fin,
            CASE 
                WHEN SYSDATE < ee.fecha_inicio THEN 'FUTURA'
                WHEN SYSDATE BETWEEN ee.fecha_inicio AND ee.fecha_fin THEN 'ACTIVA'
                WHEN SYSDATE > ee.fecha_fin THEN 'VENCIDA'
            END as estado_temporal,
            (SELECT COUNT(*) 
             FROM HIST_OBRAS_MOV hom 
             WHERE hom.id_museo = ee.id_museo 
               AND hom.fecha_salida IS NULL
               AND EXISTS (
                   SELECT 1 FROM HIST_OBRAS_MOV hom2 
                   WHERE hom2.id_obra = hom.id_obra 
                     AND hom2.fecha_entrada <= ee.fecha_fin
                     AND (hom2.fecha_salida IS NULL OR hom2.fecha_salida >= ee.fecha_inicio)
               )
            ) as obras_asignadas
        FROM EXPOSICIONES_EVENTOS ee
        WHERE (p_id_museo IS NULL OR ee.id_museo = p_id_museo)
          AND (
              -- Exposiciones activas sin obras asignadas
              (SYSDATE BETWEEN ee.fecha_inicio AND ee.fecha_fin AND 
               NOT EXISTS (
                   SELECT 1 FROM HIST_OBRAS_MOV hom 
                   WHERE hom.id_museo = ee.id_museo 
                     AND hom.fecha_salida IS NULL
               )) OR
              -- Exposiciones vencidas con obras aún asignadas
              (SYSDATE > ee.fecha_fin AND 
               EXISTS (
                   SELECT 1 FROM HIST_OBRAS_MOV hom 
                   WHERE hom.id_museo = ee.id_museo 
                     AND hom.fecha_salida IS NULL
               ))
          );

BEGIN
    -- Validar que el museo existe si se especifica
    IF p_id_museo IS NOT NULL THEN
        BEGIN
            SELECT 1 INTO v_contador FROM MUSEOS WHERE id_museo = p_id_museo;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20065, 
                    'Error: No existe un museo con ID ' || p_id_museo);
        END;
    END IF;

    v_contador := 0;

    -- Procesar cada exposición que requiere atención
    FOR rec IN c_exposiciones_revision LOOP
        IF p_accion_automatica = 'REPORTE' THEN
            -- Solo generar reporte (usar DBMS_OUTPUT para demostración)
            DBMS_OUTPUT.PUT_LINE('RECOMENDACIÓN: Exposición "' || rec.nombre || 
                               '" (ID: ' || rec.id_expo || 
                               ') - Estado: ' || rec.estado_temporal ||
                               ' - Obras asignadas: ' || rec.obras_asignadas);
            
        ELSIF p_accion_automatica = 'EJECUTAR' THEN
            -- Ejecutar acciones automáticas
            IF rec.estado_temporal = 'VENCIDA' AND rec.obras_asignadas > 0 THEN
                -- Liberar obras de exposiciones vencidas
                UPDATE HIST_OBRAS_MOV
                SET fecha_salida = rec.fecha_fin + 1
                WHERE id_museo = rec.id_museo
                  AND fecha_salida IS NULL
                  AND EXISTS (
                      SELECT 1 FROM HIST_OBRAS_MOV hom2 
                      WHERE hom2.id_obra = HIST_OBRAS_MOV.id_obra 
                        AND hom2.fecha_entrada <= rec.fecha_fin
                        AND (hom2.fecha_salida IS NULL OR hom2.fecha_salida >= rec.fecha_inicio)
                  );
                  
                -- Log informativo de liberación (para auditoría en desarrollo)
                -- DBMS_OUTPUT.PUT_LINE('INFO: Obras liberadas automáticamente de exposición: ' || rec.nombre);
            END IF;
        END IF;
        
        v_contador := v_contador + 1;
    END LOOP;

    p_registros_procesados := v_contador;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20066, 
            'Error inesperado en gestión de estado de exposiciones: ' || SQLERRM);
END SP_GESTIONAR_ESTADO_EXPOSICIONES;
/

-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_CONSOLIDAR_OPERACIONES_DIARIAS
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
-- Procedimiento maestro que ejecuta todas las automatizaciones diarias:
-- - Programación automática de mantenimientos
-- - Gestión de estados de exposiciones
-- - Limpieza de registros temporales
-- - Generación de reportes operativos
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_CONSOLIDAR_OPERACIONES_DIARIAS (
    p_id_museo         IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_ejecutar_acciones IN VARCHAR2 DEFAULT 'SI', -- 'SI' o 'NO' (solo reporte)
    p_resumen_operaciones OUT VARCHAR2
)
AS
    v_mant_programados NUMBER := 0;
    v_expo_revisadas NUMBER := 0;
    v_resumen VARCHAR2(4000);
BEGIN
    -- 1. Programar mantenimientos automáticos
    SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO(
        p_id_museo => p_id_museo,
        p_dias_anticipacion => 7, -- Una semana de anticipación
        p_registros_procesados => v_mant_programados
    );

    -- 2. Gestionar estado de exposiciones
    SP_GESTIONAR_ESTADO_EXPOSICIONES(
        p_id_museo => p_id_museo,
        p_accion_automatica => CASE WHEN p_ejecutar_acciones = 'SI' THEN 'EJECUTAR' ELSE 'REPORTE' END,
        p_registros_procesados => v_expo_revisadas
    );

    -- 3. Generar resumen
    v_resumen := 'CONSOLIDACIÓN DIARIA - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI') || CHR(10) ||
                 'Museo: ' || COALESCE(TO_CHAR(p_id_museo), 'TODOS') || CHR(10) ||
                 'Mantenimientos programados: ' || v_mant_programados || CHR(10) ||
                 'Exposiciones revisadas: ' || v_expo_revisadas || CHR(10) ||
                 'Modo: ' || CASE WHEN p_ejecutar_acciones = 'SI' THEN 'EJECUCIÓN' ELSE 'SOLO REPORTE' END;

    p_resumen_operaciones := v_resumen;

    -- Commit de todas las operaciones
    IF p_ejecutar_acciones = 'SI' THEN
        COMMIT;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20067, 
            'Error en consolidación de operaciones diarias: ' || SQLERRM);
END SP_CONSOLIDAR_OPERACIONES_DIARIAS;
/



-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: SISTEMA COMPLETO DE AUTOMATIZACIÓN
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_resumen_operaciones VARCHAR2(4000);
    v_mant_programados NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== DEMO: SISTEMA DE AUTOMATIZACIÓN DEL MUSEO ===');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- 1. Ejecutar consolidación diaria (modo reporte primero)
    DBMS_OUTPUT.PUT_LINE('1. Ejecutando análisis de operaciones diarias...');
    SP_CONSOLIDAR_OPERACIONES_DIARIAS(
        p_id_museo => NULL, -- Todos los museos
        p_ejecutar_acciones => 'NO', -- Solo reporte
        p_resumen_operaciones => v_resumen_operaciones
    );
    DBMS_OUTPUT.PUT_LINE(v_resumen_operaciones);
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('2. Programando mantenimientos automáticos...');
    
    -- 2. Programar mantenimientos específicos
    SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO(
        p_id_museo => 1, -- Solo el primer museo
        p_dias_anticipacion => 15, -- 15 días de anticipación
        p_registros_procesados => v_mant_programados
    );
    
    DBMS_OUTPUT.PUT_LINE('Mantenimientos programados: ' || v_mant_programados);
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('3. Ejemplo de triggers automáticos:');
    DBMS_OUTPUT.PUT_LINE('- TRG_MANEJAR_MANTENIMIENTOS_OBRAS: Cierra mantenimientos anteriores automáticamente');
    DBMS_OUTPUT.PUT_LINE('- TRG_AUTOMATIZAR_CIERRES_TEMPORALES: Gestiona cierres de salas automáticamente');
    DBMS_OUTPUT.PUT_LINE('- TRG_GESTIONAR_HISTORIAL_PRECIOS: Mantiene historial de precios automáticamente');
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=== AUTOMATIZACIÓN COMPLETADA ===');
    
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en demo de automatización: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/
*/



-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_INSERTAR_COLECCION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
--Automatiza la insercion de colecciones para que se actualice el orden 
--de recorrido del resto de las colecciones.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_INSERTAR_COLECCION(
    n_nombre_museo IN VARCHAR2, 
    n_nombre_depto IN VARCHAR2,
    n_nombre_coleccion IN VARCHAR2, 
    n_caracteristicas IN VARCHAR2, 
    n_palabra_clave IN VARCHAR2,    
    n_orden_recorrido IN NUMBER) IS v_id_museo NUMBER; v_id_depto NUMBER;
BEGIN
    IF n_orden_recorrido IS NOT NULL AND n_orden_recorrido>0 THEN
        UPDATE COLECCIONES_PERMANENTES SET orden_recorrido = orden_recorrido+1
        WHERE orden_recorrido >= n_orden_recorrido;
    END IF;
    
    SELECT id_museo INTO v_id_museo
    FROM MUSEOS
    WHERE nombre = n_nombre_museo;
    
    SELECT eo.id_est_org INTO v_id_depto
    FROM EST_ORGANIZACIONAL eo
    WHERE eo.id_museo = v_id_museo AND eo.nombre = n_nombre_depto;
    
    INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas,
        palabra_clave, orden_recorrido) VALUES (v_id_depto, v_id_museo, n_nombre_coleccion,
        n_caracteristicas, n_palabra_clave, n_orden_recorrido);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20064, 'Error: Museo "' || n_nombre_museo || '" o Departamento "' || n_nombre_depto || '" no encontrado.');
        WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20065, 'Error: Se encontraron múltiples registros para el Museo "' || n_nombre_museo || '" o el Departamento "' || n_nombre_depto || '".');
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20066, 'Error inesperado al insertar coleccion "' || n_nombre_coleccion || '": ' || SQLERRM);
END SP_INSERTAR_COLECCION;
/    

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: INSERTAR COLECCION
-- -----------------------------------------------------------------------------
/*
EXEC SP_INSERTAR_COLECCION('Musée du Petit Palais', 'Servicio de Exposiciones y Gestión de Colecciones', 'Coleccion Post-Moderna', 'Arte de la era digital y de la información', 'Digital', 3);
*/


-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_MODIFICAR_ORDEN_COLECCION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
--Automatiza la modificacion de colecciones para que se actualice el orden 
--de recorrido del resto de las colecciones.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_MODIFICAR_ORDEN_COLECCION
    (n_id_coleccion IN VARCHAR2,
    n_orden_recorrido IN NUMBER) 
    IS
    v_orden_viejo NUMBER;
BEGIN
    
    SELECT orden_recorrido INTO v_orden_viejo
    FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = n_id_coleccion;
    
    IF n_orden_recorrido IS NOT NULL AND n_orden_recorrido > 0 AND n_orden_recorrido != v_orden_viejo THEN
        IF n_orden_recorrido > v_orden_viejo THEN 
            UPDATE COLECCIONES_PERMANENTES
            SET orden_recorrido = orden_recorrido -1
            WHERE orden_recorrido > v_orden_viejo AND
            orden_recorrido <= n_orden_recorrido;
        ELSIF n_orden_recorrido < v_orden_viejo THEN
            UPDATE COLECCIONES_PERMANENTES
            SET orden_recorrido = orden_recorrido +1
            WHERE orden_recorrido < v_orden_viejo AND
            orden_recorrido >= n_orden_recorrido;
        END IF;
        UPDATE COLECCIONES_PERMANENTES
        SET orden_recorrido = n_orden_recorrido
        WHERE id_coleccion = n_id_coleccion;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20064, 'Error: Coleccion "' || n_id_coleccion || 'no encontrado.');
     WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20065, 'Error: Se encontraron múltiples registros la Coleccion "' || n_id_coleccion ||'".');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20066, 'Error inesperado al modificar orden de coleccion "' || n_id_coleccion || '": ' || SQLERRM);
END SP_MODIFICAR_ORDEN_COLECCION;
/


-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: MODIFICAR ORDEN DE RECORRIDO DE UNA COLECCION
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_id_museo NUMBER;
    v_id_coleccion NUMBER;
    v_id_org NUMBER;
BEGIN
    SELECT id_museo INTO v_id_museo
    FROM MUSEOS
    WHERE nombre='Musée du Petit Palais';
    
    SELECT id_est_org INTO v_id_org
    FROM EST_ORGANIZACIONAL
    WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
    id_museo = v_id_museo;
    
    SELECT id_coleccion INTO v_id_coleccion
    FROM COLECCIONES_PERMANENTES
    WHERE
    id_museo = v_id_museo AND
    id_est_org = v_id_org AND
    nombre = 'Coleccion Post-Moderna';
    
    SP_MODIFICAR_ORDEN_COLECCION(v_id_coleccion, 3);
    
END;
/
*/



-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_ELIMINAR_COLECCION
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción:
--Automatiza la eliminacion de colecciones para que se actualice el orden 
--de recorrido del resto de las colecciones.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_ELIMINAR_COLECCION (
    p_id_coleccion IN NUMBER 
)
IS
    v_orden_eliminado NUMBER;
BEGIN
    
    SELECT orden_recorrido
    INTO v_orden_eliminado
    FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = p_id_coleccion;

    DELETE FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = p_id_coleccion;

    IF v_orden_eliminado IS NOT NULL THEN
        UPDATE COLECCIONES_PERMANENTES
        SET orden_recorrido = orden_recorrido - 1
        WHERE orden_recorrido > v_orden_eliminado;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20068, 'Error: Colección con ID ' || p_id_coleccion || ' no encontrada para eliminar.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20069, 'Error inesperado al eliminar coleccion con ID ' || p_id_coleccion || ': ' || SQLERRM);
END SP_ELIMINAR_COLECCION;
/

-- -----------------------------------------------------------------------------
-- BLOQUE DE EJEMPLO DE USO: ELIMINAR COLECCION
-- -----------------------------------------------------------------------------
/*
DECLARE
    v_id_museo NUMBER;
    v_id_coleccion NUMBER;
    v_id_org NUMBER;
BEGIN
    SELECT id_museo INTO v_id_museo
    FROM MUSEOS
    WHERE nombre='Musée du Petit Palais';
    
    SELECT id_est_org INTO v_id_org
    FROM EST_ORGANIZACIONAL
    WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
    id_museo = v_id_museo;
    
    SELECT id_coleccion INTO v_id_coleccion
    FROM COLECCIONES_PERMANENTES
    WHERE
    id_museo = v_id_museo AND
    id_est_org = v_id_org AND
    nombre = 'Coleccion Post-Moderna';
    
    SP_ELIMINAR_COLECCION(v_id_coleccion);
    
END;
/
*/



-- -----------------------------------------------------------------------------
-- VISTA: VW_MOVIMIENTOS_ACTIVOS
-- -----------------------------------------------------------------------------
-- Descripción: Vista que facilita la consulta de movimientos de obras activos
-- utilizando únicamente las tablas del modelo ER original
-- -----------------------------------------------------------------------------

CREATE OR REPLACE VIEW VW_MOVIMIENTOS_ACTIVOS AS
SELECT 
    hom.id_catalogo_museo,
    hom.id_obra,
    o.nombre as nombre_obra,
    m.nombre as museo,
    hom.fecha_entrada,
    hom.fecha_salida,
    hom.tipo_adquisicion,
    hom.destacada,
    hom.orden_recorrido,
    hom.valor_monetario,
    CASE 
        WHEN hom.fecha_salida IS NULL THEN 'ACTIVA'
        ELSE 'FINALIZADA'
    END as estado_movimiento,
    -- Información adicional útil
    SYSDATE - hom.fecha_entrada as dias_en_ubicacion
FROM HIST_OBRAS_MOV hom
JOIN OBRAS o ON hom.id_obra = o.id_obra
JOIN MUSEOS m ON hom.id_museo = m.id_museo
WHERE hom.fecha_salida IS NULL  -- Solo movimientos activos
ORDER BY m.nombre, hom.fecha_entrada DESC;

-- =============================================================================
-- FIN DEL SCRIPT DE CREACIÓN UNIFICADA
-- =============================================================================



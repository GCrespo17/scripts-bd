-- =============================================================================
-- SECCIÓN 1: LIMPIEZA DEL ENTORNO (DROP OBJECTS)
-- =============================================================================
PROMPT --- Eliminando objetos en orden de dependencia inversa...

-- Triggers
PROMPT --- Eliminando Triggers...
DROP TRIGGER TRG_MANEJAR_HIST_EMPLEADOS;
DROP TRIGGER TRG_HIST_OBRAS_MOV_FECHAS;
DROP TRIGGER TRG_EVITAR_CIERRE_CON_EXPOSICION;
DROP TRIGGER TRG_MANEJAR_MANTENIMIENTOS_OBRAS;
DROP TRIGGER TRG_AUTOMATIZAR_CIERRES_TEMPORALES;
DROP TRIGGER TRG_GESTIONAR_HISTORIAL_PRECIOS;

-- Vistas
PROMPT --- Eliminando Vistas...
DROP VIEW V_MUSEOS_RANKING_SCORES;
DROP VIEW VW_MOVIMIENTOS_ACTIVOS;

-- Procedimientos
PROMPT --- Eliminando Procedimientos...
DROP PROCEDURE SP_VENDER_TICKET;
DROP PROCEDURE SP_REGISTRAR_NUEVO_EMPLEADO;
DROP PROCEDURE SP_FINALIZAR_EXPOSICION;
DROP PROCEDURE SP_CALCULAR_RANKING_MUSEO;
DROP PROCEDURE SP_ASIGNAR_OBRA_A_EXPOSICION;
DROP PROCEDURE SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO;
DROP PROCEDURE SP_GESTIONAR_ESTADO_EXPOSICIONES;
DROP PROCEDURE SP_CONSOLIDAR_OPERACIONES_DIARIAS;
DROP PROCEDURE SP_INSERTAR_COLECCION;
DROP PROCEDURE SP_MODIFICAR_ORDEN_COLECCION;
DROP PROCEDURE SP_ELIMINAR_COLECCION;

-- Paquetes
PROMPT --- Eliminando Paquetes...
DROP PACKAGE trigger_state_pkg;

-- Tablas
PROMPT --- Eliminando Tablas...
DROP TABLE MANTENIMIENTOS_OBRAS_REALIZADOS CASCADE CONSTRAINTS;
DROP TABLE PROGRAMAS_MANT CASCADE CONSTRAINTS;
DROP TABLE HIST_OBRAS_MOV CASCADE CONSTRAINTS;
DROP TABLE SALAS_COLECCIONES CASCADE CONSTRAINTS;
DROP TABLE COLECCIONES_PERMANENTES CASCADE CONSTRAINTS;
DROP TABLE CIERRES_TEMPORALES CASCADE CONSTRAINTS;
DROP TABLE EXPOSICIONES_EVENTOS CASCADE CONSTRAINTS;
DROP TABLE SALAS_EXP CASCADE CONSTRAINTS;
DROP TABLE ASIGNACIONES_MES CASCADE CONSTRAINTS;
DROP TABLE EST_FISICA CASCADE CONSTRAINTS;
DROP TABLE HIST_EMPLEADOS CASCADE CONSTRAINTS;
DROP TABLE EST_ORGANIZACIONAL CASCADE CONSTRAINTS;
DROP TABLE FORMACIONES CASCADE CONSTRAINTS;
DROP TABLE EMPLEADOS_IDIOMAS CASCADE CONSTRAINTS;
DROP TABLE ARTISTAS_OBRAS CASCADE CONSTRAINTS;
DROP TABLE ARTISTAS CASCADE CONSTRAINTS;
DROP TABLE EMPLEADOS_PROFESIONALES CASCADE CONSTRAINTS;
DROP TABLE EMPLEADOS_VIGILANTE_mant CASCADE CONSTRAINTS;
DROP TABLE TICKETS CASCADE CONSTRAINTS;
DROP TABLE TIPO_TICKETS CASCADE CONSTRAINTS;
DROP TABLE HORARIOS CASCADE CONSTRAINTS;
DROP TABLE HIST_MUSEOS CASCADE CONSTRAINTS;
DROP TABLE MUSEOS CASCADE CONSTRAINTS;
DROP TABLE IDIOMAS CASCADE CONSTRAINTS;
DROP TABLE OBRAS CASCADE CONSTRAINTS;
DROP TABLE LUGARES CASCADE CONSTRAINTS;

-- Secuencias
PROMPT --- Eliminando Secuencias...
DROP SEQUENCE seq_lugar;
DROP SEQUENCE seq_obra;
DROP SEQUENCE seq_idioma;
DROP SEQUENCE seq_empleado_vigilante_mant;
DROP SEQUENCE seq_artista;
DROP SEQUENCE seq_empleado_profesional;
DROP SEQUENCE seq_formacion;
DROP SEQUENCE seq_museo;
DROP SEQUENCE seq_est_fisica;
DROP SEQUENCE seq_sala_exp;
DROP SEQUENCE seq_exposicion_evento;
DROP SEQUENCE seq_est_organizacional;
DROP SEQUENCE seq_coleccion_permanente;
DROP SEQUENCE seq_hist_obra_mov;
DROP SEQUENCE seq_programa_mant;
DROP SEQUENCE seq_mant_obra_realizado;


/******************************************************************************
* -- PROYECTO: Gestión de Museos
* -- GRUPO 3
* -- DESCRIPCIÓN: Script unificado para la creación de la BDD.
******************************************************************************/
-- =============================================================================
-- SECCIÓN 1: CREACIÓN DE ESTRUCTURA (DDL)
-- =============================================================================
PROMPT --- Creando Secuencias...
CREATE SEQUENCE seq_lugar START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_obra START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_idioma START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_empleado_vigilante_mant START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_artista START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_empleado_profesional START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_formacion START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_museo START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_est_fisica START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sala_exp START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_exposicion_evento START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_est_organizacional START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_coleccion_permanente START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_hist_obra_mov START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_programa_mant START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_mant_obra_realizado START WITH 1 INCREMENT BY 1;

PROMPT --- Creando Tablas...
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

-- =============================================================================
-- SECCIÓN 3: INDICES
-- =============================================================================


PROMPT --- Creando Indices...
-- Índices para Triggers y optimización de concurrencia
CREATE INDEX idx_tickets_museo_num_ticket ON TICKETS(id_museo, id_num_ticket);
CREATE INDEX idx_tipo_tickets_museo_tipo_fechas ON TIPO_TICKETS(id_museo, tipo, fecha_inicio, fecha_fin);
CREATE INDEX idx_hist_empleados_emp_fechas ON HIST_EMPLEADOS(id_empleado_prof, fecha_inicio, fecha_fin);
CREATE INDEX idx_hist_obras_obra_fecha_salida ON HIST_OBRAS_MOV(id_obra, fecha_salida);
CREATE INDEX idx_exposiciones_sala_fechas ON EXPOSICIONES_EVENTOS(id_sala, id_est, id_museo, fecha_inicio, fecha_fin);
CREATE INDEX idx_mant_obras_catalogo_obra_fecha ON MANTENIMIENTOS_OBRAS_REALIZADOS(id_catalogo, id_obra, fecha_fin);
CREATE INDEX idx_cierres_sala_fecha_fin ON CIERRES_TEMPORALES(id_sala, id_est, id_museo, fecha_fin);
CREATE INDEX idx_tipo_tickets_museo_tipo_fin ON TIPO_TICKETS(id_museo, tipo, fecha_fin);
-- Índices para Stored Procedures
CREATE INDEX idx_est_org_museo_nombre ON EST_ORGANIZACIONAL(id_museo, nombre);
CREATE INDEX idx_exposiciones_expo_museo ON EXPOSICIONES_EVENTOS(id_expo, id_museo);
CREATE INDEX idx_hist_empleados_museo_cargo_activo ON HIST_EMPLEADOS(id_museo, cargo, fecha_fin);
CREATE INDEX idx_tickets_museo_fecha ON TICKETS(id_museo, fecha_hora_emision);
-- Índices para consultas del Backend y reportes
CREATE INDEX idx_hist_obras_museo_activas ON HIST_OBRAS_MOV(id_museo, fecha_salida, id_obra);
CREATE INDEX idx_salas_exp_museo ON SALAS_EXP(id_museo);
CREATE INDEX idx_est_org_museo ON EST_ORGANIZACIONAL(id_museo);
CREATE INDEX idx_est_fisica_museo ON EST_FISICA(id_museo);
CREATE INDEX idx_exposiciones_fechas_activas ON EXPOSICIONES_EVENTOS(fecha_inicio, fecha_fin, id_museo);
-- Índices adicionales para joins frecuentes
CREATE INDEX idx_artistas_obras_artista ON ARTISTAS_OBRAS(id_artista);
CREATE INDEX idx_horarios_museo ON HORARIOS(id_museo);
CREATE INDEX idx_formaciones_empleado ON FORMACIONES(id_empleado_prof);
CREATE INDEX idx_programas_mant_catalogo_obra ON PROGRAMAS_MANT(id_catalogo, id_obra);

COMMIT;

-- =============================================================================
-- SECCIÓN 4: VISTAS, PROCEDIMIENTOS Y PAQUETES
-- =============================================================================
PROMPT --- Creando Vistas de acceso a datos...

-- -----------------------------------------------------------------------------
-- VISTA: V_MUSEOS_RANKING_SCORES
-- Vista que calcula puntajes de ranking para museos basado en 
-- estabilidad de personal y popularidad de visitantes.
-- METODOLOGÍA DE RANKING:
-- 1. CRITERIO PRINCIPAL: Permanencia promedio del personal (estabilidad institucional)
--    - Más de 10 años: Score 1 (Excelente estabilidad)
--    - Entre 5-10 años: Score 2 (Estabilidad moderada)  
--    - Menos de 5 años: Score 3 (Alta rotación)
-- 2. CRITERIO DE DESEMPATE: Volumen de visitantes anuales (rangos estratificados)
-- 3. POSICIONAMIENTO: Rankings nacionales y mundiales pre-calculados
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW V_MUSEOS_RANKING_SCORES AS
WITH EstabilidadPersonal AS (
    -- Análisis de estabilidad de personal por institución
    SELECT 
        he.id_museo,
        COUNT(*) as total_empleados,
        AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25) as antiguedad_promedio_anios,
        SUM(CASE WHEN (COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) < (365.25 * 5) THEN 1 ELSE 0 END) / COUNT(*) * 100 as tasa_rotacion_alta_pct,
        -- Puntuación de estabilidad: 1=excelente, 2=bueno, 3=deficiente
        CASE 
            WHEN AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25) > 10 THEN 1
            WHEN AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25) >= 5 THEN 2
            ELSE 3
        END as puntuacion_rotacion
    FROM HIST_EMPLEADOS he
    GROUP BY he.id_museo
),
PopularidadVisitas AS (
    -- Métricas de afluencia de visitantes (último año) - VOLUMEN TOTAL
    -- Incluye: tickets de entrada general + visitantes de exposiciones específicas
    SELECT 
        id_museo,
        (tickets_anuales + visitas_exposiciones_anuales) as visitas_ultimo_anio,
        -- Clasificación por rangos de popularidad (volumen total)
        CASE 
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 50 THEN 1  -- Excelente afluencia
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 25 THEN 2  -- Buena afluencia
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 10 THEN 3  -- Afluencia regular
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 5 THEN 4   -- Afluencia baja
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 1 THEN 5   -- Afluencia muy baja
            ELSE 6                                                              -- Sin registro de visitas
        END as puntuacion_visitas
    FROM (
        SELECT 
            m.id_museo,
            -- Contar tickets de entrada general (último año)
            COALESCE((SELECT COUNT(*) 
                     FROM TICKETS t 
                     WHERE t.id_museo = m.id_museo 
                       AND t.fecha_hora_emision >= (SYSDATE - 365)), 0) as tickets_anuales,
            -- Sumar visitantes de exposiciones/eventos (último año)
            COALESCE((SELECT SUM(ee.cant_visitantes) 
                     FROM EXPOSICIONES_EVENTOS ee 
                     WHERE ee.id_museo = m.id_museo 
                       AND ee.cant_visitantes IS NOT NULL
                       AND ee.fecha_inicio >= (SYSDATE - 365)), 0) as visitas_exposiciones_anuales
        FROM MUSEOS m
    )
),
UbicacionMuseos AS (
    -- Datos geográficos para segmentación de ranking
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
),
ScoresBase AS (
    -- Consolidación de métricas y cálculo de score final
    SELECT 
        um.id_museo,
        um.nombre_museo,
        um.ciudad,
        um.id_pais,
        um.pais,
        COALESCE(ROUND(ep.antiguedad_promedio_anios, 2), 0) as antiguedad_promedio_anios,
        COALESCE(ROUND(ep.tasa_rotacion_alta_pct, 2), 100) as tasa_rotacion_alta_pct,
        COALESCE(pv.visitas_ultimo_anio, 0) as visitas_ultimo_anio,
        COALESCE(ep.puntuacion_rotacion, 3) as puntuacion_rotacion,
        COALESCE(pv.puntuacion_visitas, 6) as puntuacion_visitas,
        -- Score híbrido: prioridad a estabilidad de personal, desempate por popularidad
        COALESCE(ep.puntuacion_rotacion, 3) + (COALESCE(pv.puntuacion_visitas, 6) / 100.0) as score_final
    FROM UbicacionMuseos um
    LEFT JOIN EstabilidadPersonal ep ON um.id_museo = ep.id_museo
    LEFT JOIN PopularidadVisitas pv ON um.id_museo = pv.id_museo
)
SELECT 
    sb.id_museo,
    sb.nombre_museo,
    sb.ciudad,
    sb.id_pais,
    sb.pais,
    sb.antiguedad_promedio_anios,
    sb.tasa_rotacion_alta_pct,
    sb.visitas_ultimo_anio,
    sb.puntuacion_rotacion as estabilidad_score,
    sb.puntuacion_visitas as popularidad_score,
    sb.score_final,
    -- Categorización cualitativa basada en estabilidad de personal
    CASE sb.puntuacion_rotacion
        WHEN 1 THEN 'Excelente (Personal Muy Estable - +10 años promedio)'
        WHEN 2 THEN 'Bueno (Personal Estable - 5-10 años promedio)'
        WHEN 3 THEN 'En Desarrollo (Alta Rotación - <5 años promedio)'
        ELSE 'Sin Clasificar (Datos Insuficientes)'
    END as categoria_ranking,
    -- Rankings comparativos: menor score = mejor posición
    RANK() OVER (ORDER BY sb.score_final ASC) as posicion_mundial,
    COUNT(*) OVER () as total_mundial,
    RANK() OVER (PARTITION BY sb.id_pais ORDER BY sb.score_final ASC) as posicion_nacional,
    COUNT(*) OVER (PARTITION BY sb.id_pais) as total_nacional
FROM ScoresBase sb;
/


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
/



PROMPT --- Creando Paquetes de estado...

--- trigger_state_pkg: Paquete de utilidad para prevenir errores de tabla mutante
--- en triggers complejos, manteniendo un estado global para evitar ejecuciones recursivas.
CREATE OR REPLACE PACKAGE trigger_state_pkg AS
  g_is_updating BOOLEAN := FALSE;
END trigger_state_pkg;
/

PROMPT --- Creando Procedimientos de negocio...

--- SP_VENDER_TICKET: Proceso de negocio que garantiza la venta atómica de un ticket, 
--- validando tarifas activas y gestionando la concurrencia para la generación 
--- de IDs secuenciales por museo.
CREATE OR REPLACE PROCEDURE SP_VENDER_TICKET (
    p_id_museo          IN  TICKETS.id_museo%TYPE,
    p_tipo_ticket       IN  TICKETS.tipo%TYPE,
    p_id_ticket_generado OUT TICKETS.id_num_ticket%TYPE
)
AS
    v_precio_vigente    TIPO_TICKETS.precio%TYPE;
    v_nuevo_id_ticket   TICKETS.id_num_ticket%TYPE;
    v_max_attempts      CONSTANT NUMBER := 5;
    v_attempt           NUMBER := 0;
    ex_duplicate_key    EXCEPTION;
    PRAGMA EXCEPTION_INIT(ex_duplicate_key, -00001);
BEGIN
    BEGIN
        SELECT precio
        INTO v_precio_vigente
        FROM TIPO_TICKETS
        WHERE id_museo = p_id_museo
          AND tipo = p_tipo_ticket
          AND SYSDATE BETWEEN fecha_inicio AND NVL(fecha_fin, SYSDATE);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20010, 'No existe una tarifa de ticket activa para el tipo "' || p_tipo_ticket || '" en el museo ID ' || p_id_museo || '.');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20011, 'Error de datos: Múltiples tarifas activas encontradas para el tipo "' || p_tipo_ticket || '" en el museo ID ' || p_id_museo || '.');
    END;

    WHILE v_attempt < v_max_attempts LOOP
        BEGIN
            v_attempt := v_attempt + 1;
            SAVEPOINT sp_ticket_attempt;
            
            SELECT NVL(MAX(id_num_ticket), 0) + 1
            INTO v_nuevo_id_ticket
            FROM TICKETS
            WHERE id_museo = p_id_museo;

            INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
            VALUES (v_nuevo_id_ticket, p_id_museo, SYSDATE, p_tipo_ticket, v_precio_vigente);

            p_id_ticket_generado := v_nuevo_id_ticket;
            EXIT; 

        EXCEPTION
            WHEN ex_duplicate_key THEN
                ROLLBACK TO sp_ticket_attempt;
                IF v_attempt >= v_max_attempts THEN
                    RAISE_APPLICATION_ERROR(-20021, 'Error: No se pudo generar un ID único de ticket después de ' || v_max_attempts || ' intentos. Intente nuevamente.');
                END IF;
            WHEN OTHERS THEN
                ROLLBACK TO sp_ticket_attempt;
                RAISE;
        END;
    END LOOP;

    IF p_id_ticket_generado IS NULL THEN
        RAISE_APPLICATION_ERROR(-20022, 'Error interno: No se pudo asignar un ID de ticket válido.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END SP_VENDER_TICKET;
/

--- SP_REGISTRAR_NUEVO_EMPLEADO: Centraliza el proceso de alta de un nuevo empleado, 
--- asegurando la creación atómica de su registro personal y su primer puesto en 
--- el historial de cargos.
CREATE OR REPLACE PROCEDURE SP_REGISTRAR_NUEVO_EMPLEADO (
    p_doc_identidad     IN EMPLEADOS_PROFESIONALES.doc_identidad%TYPE,
    p_primer_nombre     IN EMPLEADOS_PROFESIONALES.primer_nombre%TYPE,
    p_primer_apellido   IN EMPLEADOS_PROFESIONALES.primer_apellido%TYPE,
    p_fecha_nacimiento  IN EMPLEADOS_PROFESIONALES.fecha_nacimiento%TYPE,
    p_contacto          IN EMPLEADOS_PROFESIONALES.contacto%TYPE,
    p_segundo_nombre    IN EMPLEADOS_PROFESIONALES.segundo_nombre%TYPE DEFAULT NULL,
    p_segundo_apellido  IN EMPLEADOS_PROFESIONALES.segundo_apellido%TYPE DEFAULT NULL,
    p_id_museo          IN MUSEOS.id_museo%TYPE,
    p_nombre_unidad_org IN EST_ORGANIZACIONAL.nombre%TYPE,
    p_cargo             IN HIST_EMPLEADOS.cargo%TYPE,
    p_fecha_inicio_cargo IN HIST_EMPLEADOS.fecha_inicio%TYPE,
    p_id_empleado_generado OUT EMPLEADOS_PROFESIONALES.id_empleado%TYPE
)
AS
    v_id_est_org        EST_ORGANIZACIONAL.id_est_org%TYPE;
BEGIN
    INSERT INTO EMPLEADOS_PROFESIONALES (
        doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido
    ) VALUES (
        p_doc_identidad, p_primer_nombre, p_primer_apellido, p_fecha_nacimiento, p_contacto, p_segundo_nombre, p_segundo_apellido
    ) RETURNING id_empleado INTO p_id_empleado_generado;

    BEGIN
        SELECT id_est_org
        INTO v_id_est_org
        FROM EST_ORGANIZACIONAL
        WHERE nombre = p_nombre_unidad_org
          AND id_museo = p_id_museo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20012, 'La unidad organizacional "' || p_nombre_unidad_org || '" no existe para el museo ID ' || p_id_museo || '.');
    END;

    INSERT INTO HIST_EMPLEADOS (
        fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin
    ) VALUES (
        p_fecha_inicio_cargo, v_id_est_org, p_id_museo, p_id_empleado_generado, p_cargo, NULL
    );
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END SP_REGISTRAR_NUEVO_EMPLEADO;
/

--- SP_FINALIZAR_EXPOSICION: Proporciona una interfaz controlada para concluir 
--- una exposición, actualizando su fecha de fin para reflejar el cierre operativo.
CREATE OR REPLACE PROCEDURE SP_FINALIZAR_EXPOSICION (
    p_id_expo    IN EXPOSICIONES_EVENTOS.id_expo%TYPE,
    p_id_museo   IN EXPOSICIONES_EVENTOS.id_museo%TYPE
)
AS
BEGIN
    UPDATE EXPOSICIONES_EVENTOS
    SET fecha_fin = SYSDATE
    WHERE id_expo = p_id_expo
      AND id_museo = p_id_museo;

    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20013, 'Error: No se encontró la exposición con ID ' || p_id_expo || ' en el museo con ID ' || p_id_museo || '. No se realizó ninguna actualización.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END SP_FINALIZAR_EXPOSICION;
/

-- -----------------------------------------------------------------------------
-- PROCEDIMIENTO: SP_CALCULAR_RANKING_MUSEO
-- -----------------------------------------------------------------------------
-- Descripción: Calcula métricas de ranking institucional para un museo específico
-- basado en estabilidad de personal y popularidad de visitantes.
-- METODOLOGÍA:
-- 1. Estabilidad de Personal: Evaluación de permanencia promedio de empleados
-- 2. Popularidad: Análisis de afluencia de visitantes anual con rangos estratificados
-- 3. Categorización: Clasificación cualitativa basada en métricas cuantitativas
-- Parámetros de salida proporcionan datos para reportes de evaluación institucional.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_CALCULAR_RANKING_MUSEO (
    p_id_museo                  IN  MUSEOS.id_museo%TYPE,
    p_antiguedad_promedio_anios OUT NUMBER,
    p_tasa_rotacion_alta_pct    OUT NUMBER,
    p_visitas_ultimo_anio       OUT NUMBER,
    p_categoria_ranking         OUT VARCHAR2
)
AS
    -- Variables para análisis de estabilidad de personal
    v_total_antiguedad_dias   NUMBER := 0;
    v_total_empleados         NUMBER := 0;
    v_empleados_alta_rotacion NUMBER := 0;
    v_antiguedad_promedio_anios NUMBER := 0;
    
    -- Variables para análisis de popularidad
    v_visitas_anuales         NUMBER := 0;
    v_visitas_exposiciones    NUMBER := 0;
    v_puntuacion_visitas      NUMBER := 6; -- Valor por defecto (sin visitas)
    
    -- Variables para clasificación de ranking
    v_puntuacion_rotacion     NUMBER := 3; -- Valor por defecto (alta rotación)
    
    -- Variable de validación
    v_museo_existe            NUMBER;

BEGIN
    -- ========= VALIDACIÓN: Verificar existencia del museo =========
    BEGIN
        SELECT 1
        INTO v_museo_existe
        FROM MUSEOS
        WHERE id_museo = p_id_museo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20030, 
                'Museo con ID ' || p_id_museo || ' no encontrado en el sistema.');
    END;

    -- ========= ANÁLISIS DE ESTABILIDAD DE PERSONAL =========
    FOR rec IN (
        SELECT (COALESCE(fecha_fin, SYSDATE) - fecha_inicio) as dias_trabajados
        FROM HIST_EMPLEADOS
        WHERE id_museo = p_id_museo
    ) LOOP
        v_total_antiguedad_dias := v_total_antiguedad_dias + rec.dias_trabajados;
        v_total_empleados := v_total_empleados + 1;
        
        -- Contabilizar empleados con alta rotación (< 5 años)
        IF rec.dias_trabajados < (365.25 * 5) THEN
            v_empleados_alta_rotacion := v_empleados_alta_rotacion + 1;
        END IF;
    END LOOP;

    IF v_total_empleados > 0 THEN
        v_antiguedad_promedio_anios := (v_total_antiguedad_dias / v_total_empleados) / 365.25;
        p_antiguedad_promedio_anios := ROUND(v_antiguedad_promedio_anios, 2);
        p_tasa_rotacion_alta_pct := ROUND((v_empleados_alta_rotacion / v_total_empleados) * 100, 2);
        
        -- Asignación de puntuación de estabilidad
        IF v_antiguedad_promedio_anios > 10 THEN
            v_puntuacion_rotacion := 1; -- Excelente estabilidad
        ELSIF v_antiguedad_promedio_anios >= 5 THEN
            v_puntuacion_rotacion := 2; -- Estabilidad moderada
        ELSE
            v_puntuacion_rotacion := 3; -- Alta rotación
        END IF;
    ELSE
        -- Valores por defecto para instituciones sin registro de personal
        p_antiguedad_promedio_anios := 0;
        p_tasa_rotacion_alta_pct := 100;
        v_puntuacion_rotacion := 3;
    END IF;

    -- ========= ANÁLISIS DE POPULARIDAD (VOLUMEN TOTAL DE VISITAS) =========
    -- Incluye: tickets de entrada general + visitantes de exposiciones específicas
    
    -- Contar tickets de entrada general del último año
    SELECT COUNT(id_num_ticket)
    INTO v_visitas_anuales
    FROM TICKETS
    WHERE id_museo = p_id_museo
      AND fecha_hora_emision >= (SYSDATE - 365);
    
    -- Sumar visitantes de exposiciones/eventos del último año
    SELECT COALESCE(SUM(cant_visitantes), 0)
    INTO v_visitas_exposiciones
    FROM EXPOSICIONES_EVENTOS
    WHERE id_museo = p_id_museo
      AND cant_visitantes IS NOT NULL
      AND fecha_inicio >= (SYSDATE - 365);
    
    -- Calcular volumen total de visitas anuales
    p_visitas_ultimo_anio := v_visitas_anuales + v_visitas_exposiciones;

    -- Asignación de puntuación por rangos de popularidad (volumen total)
    IF p_visitas_ultimo_anio >= 50 THEN
        v_puntuacion_visitas := 1; -- Excelente afluencia
    ELSIF p_visitas_ultimo_anio >= 25 THEN
        v_puntuacion_visitas := 2; -- Buena afluencia
    ELSIF p_visitas_ultimo_anio >= 10 THEN
        v_puntuacion_visitas := 3; -- Afluencia regular
    ELSIF p_visitas_ultimo_anio >= 5 THEN
        v_puntuacion_visitas := 4; -- Afluencia baja
    ELSIF p_visitas_ultimo_anio >= 1 THEN
        v_puntuacion_visitas := 5; -- Afluencia muy baja
    ELSE
        v_puntuacion_visitas := 6; -- Sin registro de visitas
    END IF;

    -- ========= CATEGORIZACIÓN INSTITUCIONAL =========
    CASE v_puntuacion_rotacion
        WHEN 1 THEN
            p_categoria_ranking := 'Excelente (Personal Muy Estable - +10 años promedio)';
        WHEN 2 THEN
            p_categoria_ranking := 'Bueno (Personal Estable - 5-10 años promedio)';
        WHEN 3 THEN
            p_categoria_ranking := 'En Desarrollo (Alta Rotación - <5 años promedio)';
        ELSE
            p_categoria_ranking := 'Sin Clasificar (Datos Insuficientes)';
    END CASE;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20031, 
            'Error en cálculo de ranking para museo ID ' || p_id_museo || ': ' || SQLERRM);
END SP_CALCULAR_RANKING_MUSEO;
/

--- SP_ASIGNAR_OBRA_A_EXPOSICION: Gestiona la logística de asignación de obras a exposiciones. 
--- Automatiza el traspaso de una obra desde su ubicación actual, valida la capacidad
--- de la exposición y registra el movimiento.
CREATE OR REPLACE PROCEDURE SP_ASIGNAR_OBRA_A_EXPOSICION (
    p_id_obra              IN OBRAS.id_obra%TYPE,
    p_id_expo              IN EXPOSICIONES_EVENTOS.id_expo%TYPE,
    p_id_museo             IN EXPOSICIONES_EVENTOS.id_museo%TYPE,
    p_orden_en_exposicion  IN NUMBER DEFAULT NULL
)
AS
    v_obra_en_otra_expo    NUMBER := 0;
    v_exposicion_valida    NUMBER := 0;
    v_fecha_inicio_expo    DATE;
    v_fecha_fin_expo       DATE;
    v_nombre_expo          VARCHAR2(250);
    v_capacidad_actual     NUMBER := 0;
    v_capacidad_maxima     CONSTANT NUMBER := 50;
BEGIN
    BEGIN
        SELECT 1 INTO v_obra_en_otra_expo
        FROM OBRAS WHERE id_obra = p_id_obra;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20050, 'Error: No existe una obra con el ID ' || p_id_obra || '.');
    END;

    BEGIN
        SELECT 1, fecha_inicio, fecha_fin, nombre
        INTO v_exposicion_valida, v_fecha_inicio_expo, v_fecha_fin_expo, v_nombre_expo
        FROM EXPOSICIONES_EVENTOS
        WHERE id_expo = p_id_expo AND id_museo = p_id_museo
          AND SYSDATE BETWEEN fecha_inicio AND fecha_fin;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20051, 'Error: No existe una exposición activa con ID ' || p_id_expo || ' en el museo ID ' || p_id_museo || '.');
    END;

    SELECT COUNT(*) INTO v_obra_en_otra_expo
    FROM HIST_OBRAS_MOV hom
    WHERE hom.id_obra = p_id_obra AND hom.fecha_salida IS NULL AND hom.id_museo != p_id_museo;

    IF v_obra_en_otra_expo > 0 THEN
        UPDATE HIST_OBRAS_MOV
        SET fecha_salida = SYSDATE
        WHERE id_obra = p_id_obra AND fecha_salida IS NULL;
    END IF;

    SELECT COUNT(*) INTO v_capacidad_actual
    FROM HIST_OBRAS_MOV hom
    JOIN EXPOSICIONES_EVENTOS ee ON (hom.id_museo = ee.id_museo)
    WHERE ee.id_expo = p_id_expo AND ee.id_museo = p_id_museo
      AND hom.fecha_salida IS NULL AND SYSDATE BETWEEN ee.fecha_inicio AND ee.fecha_fin;

    IF v_capacidad_actual >= v_capacidad_maxima THEN
        RAISE_APPLICATION_ERROR(-20053, 'Error: La exposición "' || v_nombre_expo || '" (ID: ' || p_id_expo || ') ha alcanzado su capacidad máxima de ' || v_capacidad_maxima || ' obras.');
    END IF;

    INSERT INTO HIST_OBRAS_MOV (
        id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis,
        fecha_entrada, tipo_adquisicion, destacada, orden_recorrido
    ) 
    SELECT 
        p_id_obra, cp.id_coleccion, se.id_sala, 1, cp.id_est_org, p_id_museo, se.id_est,
        SYSDATE, 'COMPRADA', 'SI', NVL(p_orden_en_exposicion, v_capacidad_actual + 1)
    FROM COLECCIONES_PERMANENTES cp, SALAS_EXP se
    WHERE cp.id_museo = p_id_museo AND se.id_museo = p_id_museo
      AND ROWNUM = 1;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20059, 'Error inesperado al asignar la obra ' || p_id_obra || ' a la exposición ' || p_id_expo || ': ' || SQLERRM);
END SP_ASIGNAR_OBRA_A_EXPOSICION;
/

--- SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO: Automatiza la creación de tareas de mantenimiento 
--- para obras basándose en la frecuencia definida, identificando las que están próximas 
--- a requerir servicio.
CREATE OR REPLACE PROCEDURE SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO (
    p_id_museo          IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_dias_anticipacion IN NUMBER DEFAULT 30,
    p_registros_procesados OUT NUMBER
)
AS
    v_contador NUMBER := 0;
    v_empleado_responsable NUMBER;
    CURSOR c_obras_mantenimiento IS
        SELECT DISTINCT pm.id_mant, pm.id_catalogo, pm.id_obra, pm.actividad, pm.frecuencia, pm.tipo_responsable,
            hom.id_museo, COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) as ultima_fecha_mant
        FROM PROGRAMAS_MANT pm
        JOIN HIST_OBRAS_MOV hom ON (pm.id_catalogo = hom.id_catalogo_museo AND pm.id_obra = hom.id_obra)
        LEFT JOIN MANTENIMIENTOS_OBRAS_REALIZADOS mor ON (pm.id_mant = mor.id_mant AND pm.id_catalogo = mor.id_catalogo AND pm.id_obra = mor.id_obra)
        WHERE hom.fecha_salida IS NULL AND (p_id_museo IS NULL OR hom.id_museo = p_id_museo)
        GROUP BY pm.id_mant, pm.id_catalogo, pm.id_obra, pm.actividad, pm.frecuencia, pm.tipo_responsable, hom.id_museo, hom.fecha_entrada
        HAVING (
            (pm.frecuencia LIKE '%MENSUAL%' AND COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 30 + p_dias_anticipacion) OR
            (pm.frecuencia LIKE '%TRIMESTRAL%' AND COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 90 + p_dias_anticipacion) OR
            (pm.frecuencia LIKE '%SEMESTRAL%' AND COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 180 + p_dias_anticipacion) OR
            (pm.frecuencia LIKE '%ANUAL%' AND COALESCE(MAX(mor.fecha_fin), hom.fecha_entrada) <= SYSDATE - 365 + p_dias_anticipacion)
        );
BEGIN
    IF p_id_museo IS NOT NULL THEN
        BEGIN
            SELECT 1 INTO v_contador FROM MUSEOS WHERE id_museo = p_id_museo;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20062, 'Error: No existe un museo con ID ' || p_id_museo);
        END;
    END IF;
    v_contador := 0;

    FOR rec IN c_obras_mantenimiento LOOP
        BEGIN
            SELECT id_empleado INTO v_empleado_responsable
            FROM HIST_EMPLEADOS he
            JOIN EMPLEADOS_PROFESIONALES ep ON he.id_empleado_prof = ep.id_empleado
            WHERE he.id_museo = rec.id_museo AND he.fecha_fin IS NULL AND he.cargo = rec.tipo_responsable AND ROWNUM = 1;

            INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, observaciones)
            VALUES (rec.id_mant, rec.id_catalogo, rec.id_obra, v_empleado_responsable, SYSDATE,
                'Mantenimiento programado automáticamente. Actividad: ' || rec.actividad || '. Frecuencia: ' || rec.frecuencia ||
                '. Último mantenimiento: ' || TO_CHAR(rec.ultima_fecha_mant, 'DD-MON-YYYY'));
            v_contador := v_contador + 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN CONTINUE;
            WHEN OTHERS THEN CONTINUE;
        END;
    END LOOP;
    p_registros_procesados := v_contador;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20063, 'Error inesperado en programación automática de mantenimientos: ' || SQLERRM);
END SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO;
/

--- SP_GESTIONAR_ESTADO_EXPOSICIONES: Proceso de auditoría que revisa la consistencia
--- del estado de las exposiciones, identificando anomalías como exposiciones activas
--- sin obras o vencidas con obras aún asignadas.
CREATE OR REPLACE PROCEDURE SP_GESTIONAR_ESTADO_EXPOSICIONES (
    p_id_museo         IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_accion_automatica IN VARCHAR2 DEFAULT 'REPORTE',
    p_registros_procesados OUT NUMBER
)
AS
    v_contador NUMBER := 0;
    CURSOR c_exposiciones_revision IS
        SELECT ee.id_expo, ee.id_museo, ee.nombre, ee.fecha_inicio, ee.fecha_fin,
            CASE WHEN SYSDATE < ee.fecha_inicio THEN 'FUTURA' WHEN SYSDATE BETWEEN ee.fecha_inicio AND ee.fecha_fin THEN 'ACTIVA' ELSE 'VENCIDA' END as estado_temporal,
            (SELECT COUNT(*) FROM HIST_OBRAS_MOV hom WHERE hom.id_museo = ee.id_museo AND hom.fecha_salida IS NULL AND EXISTS (
                   SELECT 1 FROM HIST_OBRAS_MOV hom2 WHERE hom2.id_obra = hom.id_obra AND hom2.fecha_entrada <= ee.fecha_fin AND (hom2.fecha_salida IS NULL OR hom2.fecha_salida >= ee.fecha_inicio)))
            as obras_asignadas
        FROM EXPOSICIONES_EVENTOS ee
        WHERE (p_id_museo IS NULL OR ee.id_museo = p_id_museo) AND (
              (SYSDATE BETWEEN ee.fecha_inicio AND ee.fecha_fin AND NOT EXISTS (SELECT 1 FROM HIST_OBRAS_MOV hom WHERE hom.id_museo = ee.id_museo AND hom.fecha_salida IS NULL)) OR
              (SYSDATE > ee.fecha_fin AND EXISTS (SELECT 1 FROM HIST_OBRAS_MOV hom WHERE hom.id_museo = ee.id_museo AND hom.fecha_salida IS NULL))
          );
BEGIN
    IF p_id_museo IS NOT NULL THEN
        BEGIN
            SELECT 1 INTO v_contador FROM MUSEOS WHERE id_museo = p_id_museo;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20065, 'Error: No existe un museo con ID ' || p_id_museo);
        END;
    END IF;
    v_contador := 0;

    FOR rec IN c_exposiciones_revision LOOP
        IF p_accion_automatica = 'EJECUTAR' THEN
            IF rec.estado_temporal = 'VENCIDA' AND rec.obras_asignadas > 0 THEN
                UPDATE HIST_OBRAS_MOV SET fecha_salida = rec.fecha_fin + 1
                WHERE id_museo = rec.id_museo AND fecha_salida IS NULL AND EXISTS (
                      SELECT 1 FROM HIST_OBRAS_MOV hom2 WHERE hom2.id_obra = HIST_OBRAS_MOV.id_obra AND hom2.fecha_entrada <= rec.fecha_fin
                        AND (hom2.fecha_salida IS NULL OR hom2.fecha_salida >= rec.fecha_inicio));
            END IF;
        END IF;
        v_contador := v_contador + 1;
    END LOOP;
    p_registros_procesados := v_contador;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20066, 'Error inesperado en gestión de estado de exposiciones: ' || SQLERRM);
END SP_GESTIONAR_ESTADO_EXPOSICIONES;
/

--- SP_CONSOLIDAR_OPERACIONES_DIARIAS: Procedimiento maestro que orquesta la ejecución 
--- de tareas de automatización diarias, como la programación de mantenimientos y la
--- auditoría del estado de exposiciones.
CREATE OR REPLACE PROCEDURE SP_CONSOLIDAR_OPERACIONES_DIARIAS (
    p_id_museo         IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_ejecutar_acciones IN VARCHAR2 DEFAULT 'SI',
    p_resumen_operaciones OUT VARCHAR2
)
AS
    v_mant_programados NUMBER := 0;
    v_expo_revisadas NUMBER := 0;
    v_resumen VARCHAR2(4000);
BEGIN
    SP_PROGRAMAR_MANTENIMIENTO_AUTOMATICO(
        p_id_museo => p_id_museo,
        p_dias_anticipacion => 7,
        p_registros_procesados => v_mant_programados
    );
    SP_GESTIONAR_ESTADO_EXPOSICIONES(
        p_id_museo => p_id_museo,
        p_accion_automatica => CASE WHEN p_ejecutar_acciones = 'SI' THEN 'EJECUTAR' ELSE 'REPORTE' END,
        p_registros_procesados => v_expo_revisadas
    );
    v_resumen := 'CONSOLIDACIÓN DIARIA - ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI') || CHR(10) ||
                 'Museo: ' || COALESCE(TO_CHAR(p_id_museo), 'TODOS') || CHR(10) ||
                 'Mantenimientos programados: ' || v_mant_programados || CHR(10) ||
                 'Exposiciones revisadas: ' || v_expo_revisadas || CHR(10) ||
                 'Modo: ' || CASE WHEN p_ejecutar_acciones = 'SI' THEN 'EJECUCIÓN' ELSE 'SOLO REPORTE' END;
    p_resumen_operaciones := v_resumen;
    IF p_ejecutar_acciones = 'SI' THEN
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20067, 'Error en consolidación de operaciones diarias: ' || SQLERRM);
END SP_CONSOLIDAR_OPERACIONES_DIARIAS;
/

--- SP_INSERTAR_COLECCION: Gestiona la inserción de una nueva colección, ajustando 
--- automáticamente el `orden_recorrido` de las colecciones existentes para mantener 
--- la consistencia secuencial.
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
    
    SELECT id_museo INTO v_id_museo FROM MUSEOS WHERE nombre = n_nombre_museo;
    SELECT eo.id_est_org INTO v_id_depto FROM EST_ORGANIZACIONAL eo WHERE eo.id_museo = v_id_museo AND eo.nombre = n_nombre_depto;
    
    INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) 
    VALUES (v_id_depto, v_id_museo, n_nombre_coleccion, n_caracteristicas, n_palabra_clave, n_orden_recorrido);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20064, 'Error: Museo "' || n_nombre_museo || '" o Departamento "' || n_nombre_depto || '" no encontrado.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20066, 'Error inesperado al insertar coleccion "' || n_nombre_coleccion || '": ' || SQLERRM);
END SP_INSERTAR_COLECCION;
/

--- SP_MODIFICAR_ORDEN_COLECCION: Permite la reordenación de una colección, actualizando 
--- de forma transaccional el `orden_recorrido` de las demás colecciones afectadas para
--- evitar duplicados o huecos en la secuencia.
CREATE OR REPLACE PROCEDURE SP_MODIFICAR_ORDEN_COLECCION
    (n_id_coleccion IN VARCHAR2,
    n_orden_recorrido IN NUMBER) 
    IS
    v_orden_viejo NUMBER;
BEGIN
    SELECT orden_recorrido INTO v_orden_viejo FROM COLECCIONES_PERMANENTES WHERE id_coleccion = n_id_coleccion;
    
    IF n_orden_recorrido IS NOT NULL AND n_orden_recorrido > 0 AND n_orden_recorrido != v_orden_viejo THEN
        IF n_orden_recorrido > v_orden_viejo THEN 
            UPDATE COLECCIONES_PERMANENTES SET orden_recorrido = orden_recorrido -1
            WHERE orden_recorrido > v_orden_viejo AND orden_recorrido <= n_orden_recorrido;
        ELSIF n_orden_recorrido < v_orden_viejo THEN
            UPDATE COLECCIONES_PERMANENTES SET orden_recorrido = orden_recorrido +1
            WHERE orden_recorrido < v_orden_viejo AND orden_recorrido >= n_orden_recorrido;
        END IF;
        UPDATE COLECCIONES_PERMANENTES SET orden_recorrido = n_orden_recorrido
        WHERE id_coleccion = n_id_coleccion;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20064, 'Error: Coleccion "' || n_id_coleccion || 'no encontrado.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20066, 'Error inesperado al modificar orden de coleccion "' || n_id_coleccion || '": ' || SQLERRM);
END SP_MODIFICAR_ORDEN_COLECCION;
/

--- SP_ELIMINAR_COLECCION: Proceso para la eliminación de una colección que recalcula
--- el `orden_recorrido` de las colecciones restantes para mantener una secuencia
--- coherente y sin huecos.
CREATE OR REPLACE PROCEDURE SP_ELIMINAR_COLECCION (
    p_id_coleccion IN NUMBER 
)
IS
    v_orden_eliminado NUMBER;
BEGIN
    SELECT orden_recorrido INTO v_orden_eliminado
    FROM COLECCIONES_PERMANENTES WHERE id_coleccion = p_id_coleccion;

    DELETE FROM COLECCIONES_PERMANENTES WHERE id_coleccion = p_id_coleccion;

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


-- STORED PROCEDURE: SP_REGISTRAR_OBRA
-- Automatiza el registro de las obras en un museo

CREATE OR REPLACE PROCEDURE SP_REGISTRAR_OBRA_NUEVA
(
    -- DATOS DE LA OBRA
    n_nombre IN OBRAS.nombre%TYPE,
    n_fecha_periodo IN OBRAS.fecha_periodo%TYPE,
    n_tipo_obra IN OBRAS.tipo_obra%TYPE,
    n_dimensiones IN OBRAS.dimensiones%TYPE,
    n_desc_mat_tec IN OBRAS.desc_materiales_tecnicas%TYPE,
    n_desc_estilos IN OBRAS.desc_estilos_generos%TYPE,
    -- DATOS DEL HIST DE LA OBRA
    n_id_museo IN MUSEOS.id_museo%TYPE,
    n_id_coleccion IN COLECCIONES_PERMANENTES.id_coleccion%TYPE,
    n_id_sala IN SALAS_EXP.id_sala%TYPE,
    n_id_empleado IN EMPLEADOS_PROFESIONALES.id_empleado%TYPE,
    n_tipo_adq IN HIST_OBRAS_MOV.tipo_adquisicion%TYPE,
    n_destacada IN HIST_OBRAS_MOV.destacada%TYPE,
    n_orden_recorrido IN HIST_OBRAS_MOV.orden_recorrido%TYPE DEFAULT NULL,
    n_valor_monetario IN HIST_OBRAS_MOV.valor_monetario%TYPE DEFAULT NULL
)
IS
    v_orden_ultima_destacada NUMBER;
    v_orden_primera_nodestacada NUMBER;
    v_id_obra NUMBER;
    v_id_est_org NUMBER;
    v_id_est_fis NUMBER;
    v_orden_ultima_nodestacada NUMBER;
    v_orden_recorrido_final NUMBER; -- Variable local para manejar el orden
BEGIN
    -- INSERTAR LA OBRA EN TABLA OBRAS
    INSERT INTO OBRAS(nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
        VALUES(n_nombre, n_fecha_periodo, n_tipo_obra, n_dimensiones, n_desc_mat_tec, n_desc_estilos)
        RETURNING id_obra INTO v_id_obra;
    
    IF n_destacada = 'SI' THEN
        IF n_orden_recorrido IS NOT NULL AND n_orden_recorrido > 0 THEN
            v_orden_recorrido_final := n_orden_recorrido;
            UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido+1
            WHERE id_museo = n_id_museo AND
            orden_recorrido >= v_orden_recorrido_final AND
            fecha_salida IS NULL;
        ELSIF n_orden_recorrido IS NULL THEN
            -- SELECCIONA EL ORDEN DE RECORRIDO DE LA ULTIMA OBRA DESTACADA
            SELECT NVL(MAX(orden_recorrido), 0) INTO v_orden_ultima_destacada
            FROM HIST_OBRAS_MOV
            WHERE id_museo = n_id_museo AND
            destacada = 'SI' AND
            orden_recorrido IS NOT NULL;
            
            v_orden_recorrido_final := v_orden_ultima_destacada+1;
            
            UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido+1
            WHERE id_museo = n_id_museo AND
            destacada = 'NO' AND
            fecha_salida IS NULL;
        END IF;
    ELSIF n_destacada = 'NO'THEN
        SELECT NVL(MAX(orden_recorrido), 0) + 1 INTO v_orden_primera_nodestacada
            FROM HIST_OBRAS_MOV
            WHERE id_museo = n_id_museo AND
            destacada = 'SI' AND
            orden_recorrido IS NOT NULL AND
            fecha_salida IS NULL;
        IF n_orden_recorrido IS NOT NULL AND n_orden_recorrido > 0 THEN
            IF n_orden_recorrido < v_orden_primera_nodestacada THEN
                RAISE_APPLICATION_ERROR(-20200, 'La obra no destacada no puede 
                    tener un orden de recorrido mayor o igual a una destacada');
            ELSE
                v_orden_recorrido_final := n_orden_recorrido;
                UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido+1
                WHERE id_museo = n_id_museo AND
                orden_recorrido >= v_orden_recorrido_final AND
                fecha_salida IS NULL;
            END IF;
        ELSIF n_orden_recorrido IS NULL THEN
            SELECT NVL(MAX(orden_recorrido), 0) INTO v_orden_ultima_nodestacada
            FROM HIST_OBRAS_MOV
            WHERE id_museo = n_id_museo AND
            destacada = 'NO' AND
            orden_recorrido IS NOT NULL AND
            fecha_salida IS NULL;
            v_orden_recorrido_final := v_orden_ultima_nodestacada+1;
        END IF;
    END IF;
    
    -- CONSULTA PARA ENCONTRAR A LA EST_ORG
    SELECT id_est_org INTO v_id_est_org
    FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = n_id_coleccion;
    
    --CONSULTA PARA ENCONTRAR A LA EST_FIS
    SELECT id_est INTO v_id_est_fis
    FROM SALAS_EXP
    WHERE id_sala = n_id_sala;
    
    
    INSERT INTO HIST_OBRAS_MOV(id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, 
        id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
        VALUES(v_id_obra, n_id_coleccion, n_id_sala, n_id_empleado, v_id_est_org, n_id_museo, 
        v_id_est_fis, SYSDATE,n_tipo_adq, n_destacada, NULL, v_orden_recorrido_final, n_valor_monetario);
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20100, 'Error inesperado en SP_REGISTRAR_OBRA_NUEVA: ' || SQLERRM);
END SP_REGISTRAR_OBRA_NUEVA;
/





-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_MOVER_OBRA
-- Automatiza el movimiento de una obra en un museo, o hacia otro museo
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_MOVER_OBRA
(
    n_id_obra IN OBRAS.id_obra%TYPE,
    p_id_museo_destino IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    p_id_coleccion_destino IN COLECCIONES_PERMANENTES.id_coleccion%TYPE DEFAULT NULL,
    p_id_sala_destino IN SALAS_EXP.id_sala%TYPE DEFAULT NULL,
    p_id_empleado_destino IN EMPLEADOS_PROFESIONALES.id_empleado%TYPE DEFAULT NULL, -- Empleado encargado de la obra en el destino (opcional)
    p_tipo_adq_destino IN HIST_OBRAS_MOV.tipo_adquisicion%TYPE DEFAULT NULL,
    p_destacada_destino IN HIST_OBRAS_MOV.destacada%TYPE DEFAULT NULL,
    p_orden_recorrido_destino IN HIST_OBRAS_MOV.orden_recorrido%TYPE DEFAULT NULL,
    p_valor_monetario_destino IN HIST_OBRAS_MOV.valor_monetario%TYPE DEFAULT NULL
)
IS
    
    v_current_id_hist          HIST_OBRAS_MOV.id_catalogo_museo%TYPE;
    v_current_museo_id         MUSEOS.id_museo%TYPE;
    v_current_coleccion_id     COLECCIONES_PERMANENTES.id_coleccion%TYPE;
    v_current_sala_id          SALAS_EXP.id_sala%TYPE;
    v_current_tipo_adq         HIST_OBRAS_MOV.tipo_adquisicion%TYPE;
    v_current_destacada        HIST_OBRAS_MOV.destacada%TYPE;
    v_current_valor_monetario  HIST_OBRAS_MOV.valor_monetario%TYPE;
    v_current_id_empleado      EMPLEADOS_PROFESIONALES.id_empleado%TYPE;
    v_current_orden_recorrido  HIST_OBRAS_MOV.orden_recorrido%TYPE;

    
    v_id_museo_destino_final         MUSEOS.id_museo%TYPE;
    v_id_coleccion_destino_final     COLECCIONES_PERMANENTES.id_coleccion%TYPE;
    v_id_sala_destino_final          SALAS_EXP.id_sala%TYPE;
    v_id_empleado_destino_final      EMPLEADOS_PROFESIONALES.id_empleado%TYPE; 
    v_tipo_adq_destino_final         HIST_OBRAS_MOV.tipo_adquisicion%TYPE;
    v_destacada_destino_final        HIST_OBRAS_MOV.destacada%TYPE;
    v_orden_recorrido_destino_final  HIST_OBRAS_MOV.orden_recorrido%TYPE;
    v_valor_monetario_destino_final  HIST_OBRAS_MOV.valor_monetario%TYPE;


    v_orden_ultima_destacada NUMBER;
    v_orden_primera_nodestacada NUMBER;
    v_orden_ultima_nodestacada NUMBER;


    v_id_est_org_destino NUMBER;
    v_id_est_fis_destino NUMBER;

BEGIN
    -- ENCONTRAR LOS VALORES ACTUALES DEL REGISTRO HISTORICO DE LA OBRA
    BEGIN
        SELECT id_catalogo_museo, id_museo, id_coleccion, id_sala,
               tipo_adquisicion, destacada, valor_monetario, id_empleado, orden_recorrido
        INTO v_current_id_hist, v_current_museo_id, v_current_coleccion_id, v_current_sala_id,
             v_current_tipo_adq, v_current_destacada, v_current_valor_monetario, v_current_id_empleado, v_current_orden_recorrido
        FROM HIST_OBRAS_MOV
        WHERE id_obra = n_id_obra
        AND fecha_salida IS NULL; 
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se encontró un registro activo para la obra con ID ' || n_id_obra || '. La obra no está en un lugar registrado o ya tiene fecha de salida.');
    END;

    -- SE ASIGNA LOS VALORES A DONDE SE QUIERE MOVER LA OBRA
    v_id_museo_destino_final        := NVL(p_id_museo_destino, v_current_museo_id);
    v_id_coleccion_destino_final    := NVL(p_id_coleccion_destino, v_current_coleccion_id);
    v_id_sala_destino_final         := NVL(p_id_sala_destino, v_current_sala_id);
    v_id_empleado_destino_final     := NVL(p_id_empleado_destino, v_current_id_empleado);
    v_tipo_adq_destino_final        := NVL(p_tipo_adq_destino, v_current_tipo_adq);
    v_destacada_destino_final       := NVL(p_destacada_destino, v_current_destacada);
    v_valor_monetario_destino_final := NVL(p_valor_monetario_destino, v_current_valor_monetario);


    -- VALIDAR SI LA OBRA YA SE ENCUENTRA DONDE SE QUIERE MOVER
    IF v_id_museo_destino_final = v_current_museo_id AND
       v_id_coleccion_destino_final = v_current_coleccion_id AND
       v_id_sala_destino_final = v_current_sala_id AND
       v_id_empleado_destino_final = v_current_id_empleado AND 
       v_tipo_adq_destino_final = v_current_tipo_adq AND
       v_destacada_destino_final = v_current_destacada AND
       v_valor_monetario_destino_final = v_current_valor_monetario
       THEN
        RAISE_APPLICATION_ERROR(-20002, 'La obra ya se encuentra en la ubicación de destino especificada sin cambios relevantes.');
    END IF;

    -- SE CIERRA EL ANTERIOR REGISTRO HISTORICO ACTIVO DE ESTA OBRA
    UPDATE HIST_OBRAS_MOV
    SET fecha_salida = SYSDATE
    WHERE id_catalogo_museo = v_current_id_hist;

   
    -- SE AJUSTA EL ORDEN DE RECORRIDO DEPENDIENDO DE LO QUE SE COLOQUE


    IF p_orden_recorrido_destino IS NULL AND v_current_orden_recorrido IS NOT NULL AND v_destacada_destino_final = v_current_destacada THEN
        v_orden_recorrido_destino_final := v_current_orden_recorrido;
    ELSE
        IF v_destacada_destino_final = 'SI' THEN
            IF p_orden_recorrido_destino IS NOT NULL AND p_orden_recorrido_destino > 0 THEN
                v_orden_recorrido_destino_final := p_orden_recorrido_destino;
                UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido + 1
                WHERE id_museo = v_id_museo_destino_final AND
                orden_recorrido >= v_orden_recorrido_destino_final
                AND fecha_salida IS NULL;
            ELSIF p_orden_recorrido_destino IS NULL THEN
                -- SE COLOCA AL FINAL DE LAS OBRAS DESTACADAS
                SELECT NVL(MAX(orden_recorrido), 0) INTO v_orden_ultima_destacada
                FROM HIST_OBRAS_MOV
                WHERE id_museo = v_id_museo_destino_final AND
                destacada = 'SI' AND
                orden_recorrido IS NOT NULL
                AND fecha_salida IS NULL;
    
                v_orden_recorrido_destino_final := v_orden_ultima_destacada + 1;
    
                -- DESPLAZAR LAS OBRAS NO DESTACADAS DE SER NECESARIO
                UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido + 1
                WHERE id_museo = v_id_museo_destino_final AND
                destacada = 'NO'
                AND fecha_salida IS NULL;
            END IF;
        ELSIF v_destacada_destino_final = 'NO' THEN
            -- CONSULTA PARA OBTENER LA PRIMERA OBRA NO DESTACADA
            SELECT NVL(MAX(orden_recorrido), 0) + 1 INTO v_orden_primera_nodestacada
            FROM HIST_OBRAS_MOV
            WHERE id_museo = v_id_museo_destino_final AND
            destacada = 'SI' AND
            orden_recorrido IS NOT NULL
            AND fecha_salida IS NULL;
    
            IF p_orden_recorrido_destino IS NOT NULL AND p_orden_recorrido_destino > 0 THEN
                IF p_orden_recorrido_destino < v_orden_primera_nodestacada THEN
                    RAISE_APPLICATION_ERROR(-20204, 'La obra no destacada no puede tener un orden de recorrido menor al siguiente disponible después de las destacadas en el museo destino.');
                ELSE
                    v_orden_recorrido_destino_final := p_orden_recorrido_destino;
                    UPDATE HIST_OBRAS_MOV SET orden_recorrido = orden_recorrido + 1
                    WHERE id_museo = v_id_museo_destino_final AND
                    orden_recorrido >= v_orden_recorrido_destino_final
                    AND fecha_salida IS NULL; 
                END IF;
            ELSIF p_orden_recorrido_destino IS NULL THEN
                -- SE COLOCAL AL FINAL DE LAS OBRAS NO DESTACADAS
                SELECT NVL(MAX(orden_recorrido), 0) INTO v_orden_ultima_nodestacada
                FROM HIST_OBRAS_MOV
                WHERE id_museo = v_id_museo_destino_final AND
                destacada = 'NO' AND
                orden_recorrido IS NOT NULL
                AND fecha_salida IS NULL; 
    
                v_orden_recorrido_destino_final := v_orden_ultima_nodestacada + 1;
            END IF;
        END IF;
    END IF;
    
    -- ENCONTRAR LA EST ORG DE LA COLECCION Y LE EST FIS DE LA SALA
    
    SELECT id_est_org INTO v_id_est_org_destino
    FROM COLECCIONES_PERMANENTES
    WHERE id_coleccion = v_id_coleccion_destino_final;

    SELECT id_est INTO v_id_est_fis_destino
    FROM SALAS_EXP
    WHERE id_sala = v_id_sala_destino_final;

    
    -- INSERTAR LOS NUEVOS REGISTROS DE LAS OBRAS
    
    INSERT INTO HIST_OBRAS_MOV
    (
        id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo,
        id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida,
        orden_recorrido, valor_monetario
    )
    VALUES
    (
        n_id_obra, v_id_coleccion_destino_final, v_id_sala_destino_final, v_id_empleado_destino_final,
        v_id_est_org_destino, v_id_museo_destino_final, v_id_est_fis_destino,
        SYSDATE, v_tipo_adq_destino_final, v_destacada_destino_final, NULL,
        v_orden_recorrido_destino_final, v_valor_monetario_destino_final
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error: Datos no encontrados durante el movimiento de la obra. ' || SQLERRM);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20005, 'Error inesperado en SP_MOVER_OBRA: ' || SQLERRM);
END SP_MOVER_OBRA;
/


-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_MOVER_EMPLEADO_ACTVO
-- Automatiza el movimiento de un empleado activo
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_MOVER_EMPLEADO_ACTIVO
(
    n_id_empleado IN EMPLEADOS_PROFESIONALES.id_empleado%TYPE,
    n_id_museo IN MUSEOS.id_museo%TYPE DEFAULT NULL,
    n_id_est_org IN EST_ORGANIZACIONAL.id_est_org%TYPE DEFAULT NULL,
    n_cargo IN HIST_EMPLEADOS.cargo%TYPE DEFAULT NULL
)
IS
    v_current_museo HIST_EMPLEADOS.id_museo%TYPE;
    v_current_org HIST_EMPLEADOS.id_est_org%TYPE;
    v_current_cargo HIST_EMPLEADOS.cargo%TYPE;
    v_current_fecha_inicio HIST_EMPLEADOS.fecha_inicio%TYPE;
    v_destino_museo HIST_EMPLEADOS.id_museo%TYPE;
    v_destino_org HIST_EMPLEADOS.id_est_org%TYPE;
    v_destino_cargo HIST_EMPLEADOS.cargo%TYPE;
BEGIN

    BEGIN
        SELECT fecha_inicio, id_museo, id_est_org, cargo
        INTO v_current_fecha_inicio, v_current_museo, v_current_org, v_current_cargo
        FROM HIST_EMPLEADOS
        WHERE id_empleado_prof = n_id_empleado AND
        fecha_fin IS NULL;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20401, 'Error: No se encontró un registro histórico ACTIVO para el empleado con ID ' || n_id_empleado || '. Este procedimiento es solo para empleados activos.');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20402, 'Error de consistencia de datos: El empleado con ID ' || n_id_empleado || ' tiene múltiples registros históricos activos (fecha_fin IS NULL).');
    END;

    v_destino_museo := NVL(n_id_museo, v_current_museo);
    v_destino_org := NVL(n_id_est_org, v_current_org);
    v_destino_cargo := NVL(n_cargo, v_current_cargo);
    
    IF v_destino_museo = v_current_museo AND
       v_destino_org = v_current_org AND
       v_destino_cargo = v_current_cargo THEN
        RAISE_APPLICATION_ERROR(-20403, 'No hay cambios en la ubicación o cargo del empleado. Operación no realizada.');
    END IF;
    
    
    UPDATE HIST_EMPLEADOS SET fecha_fin = SYSDATE
    WHERE id_empleado_prof = n_id_empleado AND
    id_museo = v_current_museo AND
    id_est_org = v_current_org AND
    fecha_inicio = v_current_fecha_inicio;
    
    INSERT INTO HIST_EMPLEADOS(fecha_inicio, id_est_org, id_museo, id_empleado_prof,
        cargo, fecha_fin) VALUES (SYSDATE, v_destino_org, v_destino_museo, n_id_empleado,
        v_destino_cargo, NULL);

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20405, 'Error inesperado en SP_MOVER_EMPLEADO_ACTIVO: ' || SQLERRM);
END SP_MOVER_EMPLEADO_ACTIVO;
/



-- -----------------------------------------------------------------------------
-- STORED PROCEDURE: SP_MOVER_EMPLEADO_INACTIVO
-- Automatiza el movimiento de un empleado inactivo, con historico cerrado en ese
-- museo o un nuevo empleado en general
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_MOVER_EMPLEADO_INACTIVO
(
    n_id_empleado IN HIST_EMPLEADOS.id_empleado_prof%TYPE,
    n_id_museo IN HIST_EMPLEADOS.id_museo%TYPE,
    n_id_est_org IN HIST_EMPLEADOS.id_est_org%TYPE,
    n_cargo IN HIST_EMPLEADOS.cargo%TYPE
)
IS
BEGIN
    
    INSERT INTO HIST_EMPLEADOS(fecha_inicio, id_est_org, id_museo, id_empleado_prof,
        cargo, fecha_fin) VALUES (SYSDATE, n_id_est_org, n_id_museo, n_id_empleado,
        n_cargo, NULL);

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20406, 'Error inesperado en SP_MOVER_EMPLEADO_INACTIVO: ' || SQLERRM);
END SP_MOVER_EMPLEADO_INACTIVO;
/




-- =============================================================================
-- SECCIÓN 5: TRIGGERS (AUTOMATIZACIÓN E INTEGRIDAD)
-- =============================================================================
PROMPT --- Creando Triggers para integridad y automatización...

--- TRG_MANEJAR_HIST_EMPLEADOS: Mantiene la integridad de la línea de tiempo histórica. 
--- Cierra automáticamente el registro anterior de un empleado (`fecha_fin`) al 
--- registrar un nuevo cargo, evitando solapamientos temporales.
CREATE OR REPLACE TRIGGER TRG_MANEJAR_HIST_EMPLEADOS
FOR INSERT OR UPDATE ON HIST_EMPLEADOS
COMPOUND TRIGGER
    TYPE t_empleado_hist_rec IS RECORD (
        id_empleado_prof HIST_EMPLEADOS.id_empleado_prof%TYPE,
        fecha_inicio     HIST_EMPLEADOS.fecha_inicio%TYPE
    );
    TYPE t_empleado_hist_table IS TABLE OF t_empleado_hist_rec INDEX BY PLS_INTEGER;
    g_new_empleados t_empleado_hist_table;

    BEFORE EACH ROW IS
        v_overlap_count NUMBER;
    BEGIN
        IF UPDATING AND NOT trigger_state_pkg.g_is_updating THEN
            SELECT COUNT(*) INTO v_overlap_count
            FROM HIST_EMPLEADOS
            WHERE id_empleado_prof = :NEW.id_empleado_prof AND ROWID != :OLD.ROWID
              AND fecha_inicio <= NVL(:NEW.fecha_fin, TO_DATE('9999-12-31', 'YYYY-MM-DD'))
              AND NVL(fecha_fin, TO_DATE('9999-12-31', 'YYYY-MM-DD')) >= :NEW.fecha_inicio;

            IF v_overlap_count > 0 THEN
                RAISE_APPLICATION_ERROR(-20003, 'Error: La actualización crearía un solapamiento de fechas para el empleado ID ' || :NEW.id_empleado_prof || '.');
            END IF;
        END IF;
    END BEFORE EACH ROW;

    AFTER EACH ROW IS
    BEGIN
        IF INSERTING THEN
            g_new_empleados(g_new_empleados.COUNT + 1).id_empleado_prof := :NEW.id_empleado_prof;
            g_new_empleados(g_new_empleados.COUNT).fecha_inicio     := :NEW.fecha_inicio;
        END IF;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        IF INSERTING AND g_new_empleados.COUNT > 0 THEN
            trigger_state_pkg.g_is_updating := TRUE;
            FOR i IN 1..g_new_empleados.COUNT LOOP
                UPDATE HIST_EMPLEADOS
                SET fecha_fin = g_new_empleados(i).fecha_inicio
                WHERE id_empleado_prof = g_new_empleados(i).id_empleado_prof
                  AND fecha_fin IS NULL
                  AND fecha_inicio < g_new_empleados(i).fecha_inicio;
            END LOOP;
            trigger_state_pkg.g_is_updating := FALSE;
        END IF;
        g_new_empleados.DELETE;
    EXCEPTION
        WHEN OTHERS THEN
            trigger_state_pkg.g_is_updating := FALSE;
            g_new_empleados.DELETE;
            RAISE;
    END AFTER STATEMENT;
END TRG_MANEJAR_HIST_EMPLEADOS;
/

--- TRG_HIST_OBRAS_MOV_FECHAS: Garantiza la consistencia en la cadena de custodia de una obra. 
--- Al registrar un nuevo movimiento, cierra automáticamente el registro de ubicación anterior, 
--- manteniendo un historial sin solapamientos.
CREATE OR REPLACE TRIGGER TRG_HIST_OBRAS_MOV_FECHAS
FOR INSERT ON HIST_OBRAS_MOV
COMPOUND TRIGGER
    TYPE t_obra_hist_rec IS RECORD (
        id_obra       HIST_OBRAS_MOV.id_obra%TYPE,
        fecha_entrada HIST_OBRAS_MOV.fecha_entrada%TYPE,
        row_id        UROWID
    );
    TYPE t_obra_hist_table IS TABLE OF t_obra_hist_rec INDEX BY PLS_INTEGER;
    g_new_obras t_obra_hist_table;

    AFTER EACH ROW IS
    BEGIN
        g_new_obras(g_new_obras.COUNT + 1).id_obra := :NEW.id_obra;
        g_new_obras(g_new_obras.COUNT).fecha_entrada := :NEW.fecha_entrada;
        g_new_obras(g_new_obras.COUNT).row_id := :NEW.ROWID;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        IF g_new_obras.COUNT > 0 THEN
            FOR i IN 1..g_new_obras.COUNT LOOP
                DECLARE
                    v_open_records_count NUMBER;
                BEGIN
                    SELECT COUNT(*) INTO v_open_records_count
                    FROM HIST_OBRAS_MOV
                    WHERE id_obra = g_new_obras(i).id_obra AND fecha_salida IS NULL
                      AND ROWID != g_new_obras(i).row_id;

                    IF v_open_records_count > 1 THEN
                        RAISE_APPLICATION_ERROR(-20004, 'Error de consistencia: La obra ID ' || g_new_obras(i).id_obra || ' tiene múltiples registros de historial abiertos.');
                    ELSIF v_open_records_count = 1 THEN
                        UPDATE HIST_OBRAS_MOV
                        SET fecha_salida = g_new_obras(i).fecha_entrada
                        WHERE id_obra = g_new_obras(i).id_obra
                          AND fecha_salida IS NULL
                          AND ROWID != g_new_obras(i).row_id;
                    END IF;
                END;
            END LOOP;
        END IF;
        g_new_obras.DELETE;
    EXCEPTION
        WHEN OTHERS THEN
            g_new_obras.DELETE;
            RAISE_APPLICATION_ERROR(-20005, 'Error inesperado en TRG_HIST_OBRAS_MOV_FECHAS: ' || SQLERRM);
    END AFTER STATEMENT;
END TRG_HIST_OBRAS_MOV_FECHAS;
/

--- TRG_EVITAR_CIERRE_CON_EXPOSICION: Impone una regla de negocio de planificación.
--- Previene el cierre temporal de una sala si existe una exposición programada 
--- que se solapa con las fechas del cierre.
CREATE OR REPLACE TRIGGER TRG_EVITAR_CIERRE_CON_EXPOSICION
BEFORE INSERT ON CIERRES_TEMPORALES
FOR EACH ROW
DECLARE
    v_expo_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_expo_count
    FROM EXPOSICIONES_EVENTOS
    WHERE id_sala = :NEW.id_sala AND id_est = :NEW.id_est AND id_museo = :NEW.id_museo
      AND fecha_inicio <= NVL(:NEW.fecha_fin, TO_DATE('9999-12-31', 'YYYY-MM-DD'))
      AND fecha_fin >= :NEW.fecha_inicio;

    IF v_expo_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Error: No se puede programar el cierre. Existe una exposición programada en la sala ' || :NEW.id_sala || ' que se solapa con las fechas del cierre.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20007, 'Error inesperado en TRG_EVITAR_CIERRE_CON_EXPOSICION: ' || SQLERRM);
END TRG_EVITAR_CIERRE_CON_EXPOSICION;
/

--- TRG_MANEJAR_MANTENIMIENTOS_OBRAS: Automatiza la gestión del ciclo de vida de los 
--- mantenimientos. Al iniciar una nueva tarea, cierra automáticamente cualquier
--- mantenimiento anterior para la misma obra, asegurando una transición clara.
CREATE OR REPLACE TRIGGER TRG_MANEJAR_MANTENIMIENTOS_OBRAS
FOR INSERT ON MANTENIMIENTOS_OBRAS_REALIZADOS
COMPOUND TRIGGER
    TYPE t_mant_rec IS RECORD (
        id_catalogo   MANTENIMIENTOS_OBRAS_REALIZADOS.id_catalogo%TYPE,
        id_obra       MANTENIMIENTOS_OBRAS_REALIZADOS.id_obra%TYPE,
        id_empleado   MANTENIMIENTOS_OBRAS_REALIZADOS.id_empleado%TYPE,
        fecha_inicio  MANTENIMIENTOS_OBRAS_REALIZADOS.fecha_inicio%TYPE,
        row_id        UROWID
    );
    TYPE t_mant_table IS TABLE OF t_mant_rec INDEX BY PLS_INTEGER;
    g_new_mantenimientos t_mant_table;

    AFTER EACH ROW IS
    BEGIN
        g_new_mantenimientos(g_new_mantenimientos.COUNT + 1).id_catalogo := :NEW.id_catalogo;
        g_new_mantenimientos(g_new_mantenimientos.COUNT).id_obra := :NEW.id_obra;
        g_new_mantenimientos(g_new_mantenimientos.COUNT).id_empleado := :NEW.id_empleado;
        g_new_mantenimientos(g_new_mantenimientos.COUNT).fecha_inicio := :NEW.fecha_inicio;
        g_new_mantenimientos(g_new_mantenimientos.COUNT).row_id := :NEW.ROWID;
    END AFTER EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        IF g_new_mantenimientos.COUNT > 0 THEN
            FOR i IN 1..g_new_mantenimientos.COUNT LOOP
                DECLARE
                    v_mant_abiertos NUMBER := 0;
                    v_empleado_anterior NUMBER;
                    v_fecha_anterior DATE;
                BEGIN
                    SELECT COUNT(*), MAX(id_empleado), MAX(fecha_inicio)
                    INTO v_mant_abiertos, v_empleado_anterior, v_fecha_anterior
                    FROM MANTENIMIENTOS_OBRAS_REALIZADOS
                    WHERE id_catalogo = g_new_mantenimientos(i).id_catalogo AND id_obra = g_new_mantenimientos(i).id_obra
                      AND fecha_fin IS NULL AND ROWID != g_new_mantenimientos(i).row_id;

                    IF v_mant_abiertos > 0 THEN
                        UPDATE MANTENIMIENTOS_OBRAS_REALIZADOS
                        SET fecha_fin = g_new_mantenimientos(i).fecha_inicio,
                            observaciones = COALESCE(observaciones || '; ', '') || 'Cerrado automáticamente por nuevo mantenimiento.'
                        WHERE id_catalogo = g_new_mantenimientos(i).id_catalogo AND id_obra = g_new_mantenimientos(i).id_obra
                          AND fecha_fin IS NULL AND ROWID != g_new_mantenimientos(i).row_id;
                    END IF;
                END;
            END LOOP;
        END IF;
        g_new_mantenimientos.DELETE;
    EXCEPTION
        WHEN OTHERS THEN
            g_new_mantenimientos.DELETE;
            RAISE_APPLICATION_ERROR(-20060, 'Error en TRG_MANEJAR_MANTENIMIENTOS_OBRAS: ' || SQLERRM);
    END AFTER STATEMENT;
END TRG_MANEJAR_MANTENIMIENTOS_OBRAS;
/

--- TRG_AUTOMATIZAR_CIERRES_TEMPORALES: Mantiene la consistencia de los cierres de salas.
--- Al programar un nuevo cierre, finaliza automáticamente cualquier cierre anterior
--- que estuviera abierto para la misma sala.
CREATE OR REPLACE TRIGGER TRG_AUTOMATIZAR_CIERRES_TEMPORALES
BEFORE INSERT ON CIERRES_TEMPORALES
FOR EACH ROW
DECLARE
    v_cierres_abiertos NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_cierres_abiertos
    FROM CIERRES_TEMPORales
    WHERE id_sala = :NEW.id_sala AND id_est = :NEW.id_est AND id_museo = :NEW.id_museo
      AND fecha_fin IS NULL;

    IF v_cierres_abiertos > 0 THEN
        UPDATE CIERRES_TEMPORALES
        SET fecha_fin = :NEW.fecha_inicio - 1
        WHERE id_sala = :NEW.id_sala AND id_est = :NEW.id_est AND id_museo = :NEW.id_museo
          AND fecha_fin IS NULL;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20061, 'Error en automatización de cierres temporales: ' || SQLERRM);
END TRG_AUTOMATIZAR_CIERRES_TEMPORALES;
/

--- TRG_GESTIONAR_HISTORIAL_PRECIOS: Asegura la integridad del historial de precios de tickets.
--- Al insertar una nueva tarifa, cierra el período de la tarifa anterior para el
--- mismo tipo de ticket y museo, evitando solapamientos.
CREATE OR REPLACE TRIGGER TRG_GESTIONAR_HISTORIAL_PRECIOS
BEFORE INSERT ON TIPO_TICKETS
FOR EACH ROW
DECLARE
    v_precios_abiertos NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_precios_abiertos
    FROM TIPO_TICKETS
    WHERE id_museo = :NEW.id_museo AND tipo = :NEW.tipo AND fecha_fin IS NULL;

    IF v_precios_abiertos > 0 THEN
        UPDATE TIPO_TICKETS
        SET fecha_fin = :NEW.fecha_inicio - 1
        WHERE id_museo = :NEW.id_museo AND tipo = :NEW.tipo AND fecha_fin IS NULL;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20064, 'Error en automatización de historial de precios: ' || SQLERRM);
END TRG_GESTIONAR_HISTORIAL_PRECIOS;
/

-- TRIGGER: TRG_VALIDAR_LUGAR_PADRE
-- Valida que el lugar padre corresponda siempre a un pais

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


-- TRIGGER: TRG_VALIDAR_EMPLEADO_INACTIVO
-- Valida que el empleado a insertar tenga su historico cerrado
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

-- =============================================================================
-- SECCIÓN 6: CONSULTAS SQL PARA REPORTES
-- =============================================================================

COMMIT;
-- DROP TABLE LUGARES;

CREATE TABLE LUGARES(
    id_lugar NUMBER DEFAULT seq_lugar.NEXTVAL PRIMARY KEY,
    id_lugar_padre NUMBER, --FK
    nombre VARCHAR2(100) NOT NULL,
    tipo VARCHAR2(10) NOT NULL,
    continente VARCHAR2(15),
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
    id_idioma NUMBER DEFAULT seq_idioma PRIMARY KEY,
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

CREATE TABLE ARTISTAS(
    id_artista NUMBER DEFAULT seq_artista.NEXTVAL PRIMARY KEY,
    id_lugar NUMBER NOT NULL, --FK
    primer_nombre VARCHAR2(30),
    segundo_nombre VARCHAR2(30),
    primer_apellido VARCHAR2(30),
    segundo_apellido VARCHAR2(30),
    fecha_nacimiento DATE,
    fecha_difuncion DATE,
    apodo VARCHAR2(50),
    resumen_caracteristicas VARCHAR2(300) NOT NULL,
    CONSTRAINT check_fechas CHECK(
        fecha_nacimiento IS NULL OR
        fecha_difuncion IS NULL OR
        fecha_difuncion >= fecha_nacimiento
    )
);

CREATE TABLE ARTISTAS_OBRAS(
    id_obra NUMBER NOT NULL, --PK FK
    id_artista NUMBER NOT NULL, --PK FK
    CONSTRAINT pk_artistas_obras PRIMARY KEY(id_obra, id_artista)
);

CREATE TABLE EMPLEADOS_PROFESIONALES(
    id_empleado NUMBER DEFAULT seq_empleado_profesional.NEXTVAL PRIMARY KEY,
    primer_nombre VARCHAR2(30) NOT NULL,
    segundo_nombre VARCHAR2(30),
    primer_apellido VARCHAR2(30) NOT NULL,
    segundo_apellido VARCHAR2(30),
    fecha_nacimiento DATE NOT NULL,
    doc_identidad NUMBER NOT NULL UNIQUE,
    contacto NUMBER NOT NULL
);

CREATE TABLE EMPLEADOS_IDIOMAS(
    id_empleado NUMBER NOT NULL, --PK FK
    id_idioma NUMBER NOT NULL, --PK FK
    CONSTRAINT pk_empleados_idiomas PRIMARY KEY(id_empleado, id_idioma)
);

CREATE TABLE FORMACIONES(
    id_formacion NUMBER DEFAULT seq_formacion.NEXTVAL NOT NULL, --PK
    id_empleado_prof NUMBER NOT NULL, --PK FK
    titulo VARCHAR2(50) NOT NULL,
    anio NUMBER NOT NULL,
    descripcion_espec VARCHAR2(300) NOT NULL,
    CONSTRAINT pk_formaciones PRIMARY KEY(id_especialidad, id_empleado_prof)
);

CREATE TABLE MUSEOS(
    id_museo NUMBER DEFAULT seq_museo.NEXTVAL PRIMARY KEY, 
    id_lugar NUMBER NOT NULL, --FK
    nombre VARCHAR2(100),
    fecha_fundacion DATE NOT NULL,
    mision VARCHAR2(300) NOT NULL
);

CREATE TABLE EST_FISICA(
    id_est NUMBER DEFAULT seq_est_fisica.NEXTVAL NOT NULL, --PK
    id_museo NUMBER NOT NULL, --PK FK
    id_est_padre NUMBER, --FK
    nombre VARCHAR2(100) NOT NULL,
    tipo VARCHAR2(12) NOT NULL,
    descripcion VARCHAR2(300),
    direccion_edificio VARCHAR2(300),
    CONSTRAINT check_tipo CHECK(tipo IN('EDIFICIO', 'PISO', 'AREA')),
    CONSTRAINT pk_est_fisica PRIMARY KEY(id_est, id_museo)
);

CREATE TABLE ASIGNACIONES_MES(
    mes_anio DATE NOT NULL, --PK
    id_est NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    id_vig_mant NUMBER NOT NULL, --PK FK
    turno VARCHAR2(15) NOT NULL,
    CONSTRAINT check_turno CHECK(turno IN('MATUTINO', 'VESPERTINO', 'NOCTURNO')),
    CONSTRAINT pk_asignaciones_mes PRIMARY KEY(mes_anio, id_est, id_museo, id_vig_mant)
);

CREATE TABLE SALAS_EXP(
    id_sala NUMBER DEFAULT seq_sala_exp.NEXTVAL NOT NULL, --PK
    id_est NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    nombre VARCHAR2(50),
    descripcion VARCHAR2(300),
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
    CONSTRAINT check_fechas CHECK(fecha_fin<=fecha_inicio),
    CONSTRAINT pk_expo_eventos PRIMARY KEY(id_expo, id_sala, id_est, id_museo)
);

CREATE TABLE CIERRES_TEMPORALES(
    fecha_inicio DATE NOT NULL, --PK
    id_sala NUMBER NOT NULL, --PK FK
    id_est NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    fecha_fin DATE,
    CONSTRAINT check_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
    CONSTRAINT pk_cierres_tem PRIMARY KEY(fecha_inicio, id_sala, id_est, id_museo)
);

CREATE TABLE EST_ORGANIZACIONAL(
    id_est_org NUMBER DEFAULT seq_est_organizacional.NEXTVAL NOT NULL, --PK
    id_museo NUMBER NOT NULL, --PK FK
    id_est_org_padre NUMBER, --FK
    nombre VARCHAR2(50) NOT NULL, 
    tipo VARCHAR2(20) NOT NULL,
    nivel NUMBER NOT NULL,
    descripcion VARCHAR2(300) NOT NULL,
    CONSTRAINT check_tipo CHECK(tipo IN('DIRECCION', 'DEPARTAMENTO', 'SECCION')),
    CONSTRAINT pk_est_organizacional PRIMARY KEY(id_est_org, id_museo, id_est_org_padre)
);

CREATE TABLE COLECCIONES_PERMANENTES(
    id_coleccion NUMBER DEFAULT seq_coleccion_permanente.NEXTVAL NOT NULL, --PK
    id_est_org NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    nombre VARCHAR2(200) NOT NULL,
    caracteristicas VARCHAR2(300) NOT NULL,
    palabra_clave VARCHAR2(20) NOT NULL,
    orden_recorrido NUMBER NOT NULL,
    CONSTRAINT pk_colecciones PRIMARY KEY(id_coleccion, id_est_org, id_museo)
);

CREATE TABLE SALAS_COLECCIONES(
    id_coleccion NUMBER NOT NULL, --PK FK
    id_est_org NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    id_sala NUMBER NOT NULL, --PK FK
    id_est_fisica NUMBER NOT NULL, --PK FK
    orden NUMBER NOT NULL,
    CONSTRAINT pk_salas_colecciones PRIMARY KEY(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica)
);

CREATE TABLE HIST_EMPLEADOS(
    fecha_inicio DATE NOT NULL, --PK
    id_est_org NUMBER NOT NULL, --PK FK
    id_museo NUMBER NOT NULL, --PK FK
    id_empleado_prof NUMBER NOT NULL, --PK FK
    fecha_fin DATE,
    cargo VARCHAR2(50) NOT NULL,
    CONSTRAINT check_fechas CHECK(fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
    CONSTRAINT check_cargo CHECK(cargo IN('RESTAURADOR', 'CURADOR', 'DIRECTOR', 'ADMINISTRATIVO')),
    CONSTRAINT pk_hist_empleados PRIMARY KEY(fecha_inicio, id_est_org, id_museo, id_empleado_prof)
);

CREATE TABLE HIST_OBRAS_MOV(
    id_catalogo_museo NUMBER DEFAULT seq_hist_obra_mov.NEXTVAL NOT NULL, --PK
    id_obra NUMBER NOT NULL, --PK FK
    id_coleccion NUMBER NOT NULL, --FK
    id_sala NUMBER NOT NULL, --FK
    id_empleado NUMBER NOT NULL, --FK
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE,
    tipo_adquisicion VARCHAR2(20) NOT NULL,
    destacada VARCHAR2(2) NOT NULL,
    orden_recorrido NUMBER,
    valor_monetario NUMBER(*, 4),
    CONSTRAINT check_fechas CHECK(fecha_salida IS NULL OR fecha_salida >= fecha_entrada),
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
    CONSTRAINT check_tipo_responsable CHECK(tipo_responsable IN('RESTAURADOR', 'CURADOR')),
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
    CONSTRAINT check_fecha CHECK(fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
    CONSTRAINT pk_mant_ralizado PRIMARY KEY(id_mant_realizado, id_mant, id_catalogo, id_obra, id_empleado)
);

CREATE TABLE HORARIOS(
    dia NUMBER NOT NULL, --PK
    id_museo NUMBER NOT NULL,  --PK FK
    hora_inicio DATE NOT NULL, 
    hora_cierre DATE NOT NULL, 
    CONSTRAINT check_dia CHECK(dia>=1 AND dia<=7),
    CONSTRAINT check_horas_validas CHECK (
        TO_CHAR(hora_apertura, 'HH24:MI:SS') < TO_CHAR(hora_cierre, 'HH24:MI:SS')
    ),
    CONSTRAINT pk_horarios PRIMARY KEY(dia, id_museo)
);

CREATE TABLE TICKETS(
    id_num_ticket NUMBER DEFAULT seq_ticket.NEXTVAL NOT NULL, --PK NO ESTOY SEGURO SI A ESTO SE LE APLICA SECUENCIA
    id_museo NUMBER NOT NULL, --PK FK
    fecha_hora_emision DATE NOT NULL,
    tipo VARCHAR2(15) NOT NULL,
    precio NUMBER (*, 4) NOT NULL,
    CONSTRAINT check_tipo CHECK(tipo IN('ESTUDIANTE', 'INFANTIL', 'ADULTO')),
    CONSTRAINT pk_ticket PRIMARY KEY(id_num_ticket, id_museo) 
);

CREATE TABLE HIST_MUSEOS(
    anio NUMBER(4) NOT NULL, --PK
    id_museo NUMBER NOT NULL, --PK FK
    hecho VARCHAR2(300) NOT NULL,
    CONSTRAINT pk_hist_museo PRIMARY KEY(anio, id_museo)
);

CREATE TABLE TIPO_TICKETS(
    fecha_inicio DATE NOT NULL, --PK
    id_museo NUMBER NOT NULL, --PK FK
    precio NUMBER(*, 2) NOT NULL,
    tipo VARCHAR2(20) NOT NULL,
    fecha_fin DATE,
    CONSTRAINT check_fechas CHECK(fecha_fin IS NULL OR fecha_fin>=fecha_inicio),
    CONSTRAINT check_tipo CHECK(tipo IN('ESTUDIANTE', 'INFANTIL', 'ADULTO')),
    CONSTRAINT pk_tipo_tickets PRIMARY KEY(fecha_inicio, id_museo)
);
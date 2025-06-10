

CREATE SEQUENCE seq_lugar
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_obra
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_idioma
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_empleado_vigilante_mant
    START WITH 1
    INCREMENT BY 1;    

CREATE SEQUENCE seq_artista
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_empleado_profesional
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_formacion
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_museo
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_est_fisica
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_sala_exp
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_exposicion_evento
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_est_organizacional
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_coleccion_permanente
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_hist_obra_mov
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_programa_mant
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_mant_obra_realizado
    START WITH 1
    INCREMENT BY 1;
CREATE SEQUENCE seq_ticket
   START WITH 1
   INCREMENT BY 1;


-- DROP TABLE TIPO_TICKETS;
-- DROP TABLE HIST_MUSEOS;
-- DROP TABLE TICKETS;
-- DROP TABLE HORARIOS;
-- DROP TABLE MANTENIMIENTOS_OBRAS_REALIZADOS;
-- DROP TABLE PROGRAMAS_MANT;
-- DROP TABLE HIST_OBRAS_MOV;
-- DROP TABLE HIST_EMPLEADOS;
-- DROP TABLE SALAS_COLECCIONES;
-- DROP TABLE COLECCIONES_PERMANENTES;
-- DROP TABLE EST_ORGANIZACIONAL;
-- DROP TABLE CIERRES_TEMPORALES;
-- DROP TABLE EXPOSICIONES_EVENTOS;
-- DROP TABLE SALAS_EXP;
-- DROP TABLE ASIGNACIONES_MES;
-- DROP TABLE EST_FISICA;
-- DROP TABLE MUSEOS;
-- DROP TABLE FORMACIONES;
-- DROP TABLE EMPLEADOS_IDIOMAS;
-- DROP TABLE EMPLEADOS_PROFESIONALES;
-- DROP TABLE ARTISTAS_OBRAS;
-- DROP TABLE ARTISTAS;
-- DROP TABLE EMPLEADOS_VIGILANTE_MANT;
-- DROP TABLE IDIOMAS;
-- DROP TABLE OBRAS;
-- DROP TABLE LUGARES;




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
    SELECT id_museo INTO v_museo_id FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle';

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
    SELECT id_museo INTO v_museo_id FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig';

    -- Llamar al procedimiento para registrar un nuevo Restaurador
    SP_REGISTRAR_NUEVO_EMPLEADO(
        p_doc_identidad      => 30000001,
        p_primer_nombre      => 'Clara',
        p_primer_apellido    => 'Schulz',
        p_fecha_nacimiento   => TO_DATE('1990-08-15', 'YYYY-MM-DD'),
        p_contacto           => 491798765432,
        p_id_museo           => v_museo_id,
        p_nombre_unidad_org  => 'Departamento de Curaduría y Colecciones MdbK',
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
    SELECT id_expo, id_museo 
    INTO v_id_exposicion, v_id_museo_expo
    FROM EXPOSICIONES_EVENTOS
    WHERE nombre LIKE 'Impresionismo en Transición%' AND ROWNUM = 1;

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

BEGIN
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
        p_antiguedad_promedio_anios := 0;
        p_tasa_rotacion_alta_pct := 0;
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
        p_antiguedad_promedio_anios := -1;
        p_tasa_rotacion_alta_pct := -1;
        p_visitas_ultimo_anio := -1;
        p_categoria_ranking := 'Error al calcular';
        RAISE;
END SP_CALCULAR_RANKING_MUSEO;
/

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
    SELECT id_museo INTO v_museo_id_test FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle';

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
END;
/
*/


-- -----------------------------------------------------------------------------
-- TRIGGER: TRG_TICKETS_BEFORE_INSERT (Versión Optimizada para Concurrencia)
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025 
-- Descripción: TRIGGER MEJORADO que combina la funcionalidad de generación de ID
-- y asignación de precios automática con manejo avanzado de concurrencia.
-- 
-- Funcionalidades integradas:
-- - Generación secuencial de id_num_ticket por museo con retry logic
-- - Doble check para reducir race conditions en alta concurrencia
-- - Asignación automática de precios desde TIPO_TICKETS
-- - Manejo robusto de errores y validaciones
-- - Optimización de rendimiento con ROWNUM limitado
-- - Máximo 3 intentos para generación de ID único
-- -----------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRG_TICKETS_BEFORE_INSERT
BEFORE INSERT ON TICKETS
FOR EACH ROW
DECLARE
    v_new_ticket_id     NUMBER;
    v_precio_correcto   TIPO_TICKETS.precio%TYPE;
    v_attempt           NUMBER := 0;
    v_max_attempts      CONSTANT NUMBER := 3;
    v_id_exists         NUMBER;
BEGIN
    -- PASO 1: Buscar y asignar precio correcto automáticamente (primero para fallar rápido)
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

    -- PASO 2: Generar ID de ticket con retry logic y doble check
    -- Esta funcionalidad optimiza la generación secuencial y reduce race conditions
    IF :NEW.id_num_ticket IS NULL THEN
        WHILE v_attempt < v_max_attempts LOOP
            v_attempt := v_attempt + 1;
            
            -- Generar ID con ROWNUM para reducir window de race condition
            SELECT NVL(MAX(id_num_ticket), 0) + 1
            INTO v_new_ticket_id
            FROM TICKETS
            WHERE id_museo = :NEW.id_museo
            AND ROWNUM <= 1000; -- Limitar scan para mejorar rendimiento
    
            -- Doble check: Verificar si el ID ya existe (reducir race condition)
            BEGIN
                SELECT 1 
                INTO v_id_exists
                FROM TICKETS
                WHERE id_museo = :NEW.id_museo 
                  AND id_num_ticket = v_new_ticket_id
                  AND ROWNUM = 1;
                
                -- Si llega aquí, el ID ya existe, incrementar y retry
                v_new_ticket_id := v_new_ticket_id + v_attempt;
                
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    -- ID no existe, es seguro usarlo
                    :NEW.id_num_ticket := v_new_ticket_id;
                    EXIT; -- Salir del loop exitosamente
            END;
            
            -- Si llegamos al máximo de intentos, lanzar error
            IF v_attempt >= v_max_attempts THEN
                RAISE_APPLICATION_ERROR(-20025, 
                    'Error: No se pudo generar un ID único de ticket tras ' || 
                    v_max_attempts || ' intentos para el museo ID ' || :NEW.id_museo);
            END IF;
        END LOOP;
    END IF;

EXCEPTION
    -- Captura de cualquier error inesperado
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20020, 'Error inesperado en trigger de tickets: ' || SQLERRM);

END TRG_TICKETS_BEFORE_INSERT;
/


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



--EJEMPLOS DE USO PARA DEFENSA BD 1

----------REGISTRAR UN EMPLEADO QUE NO EXISTA EN LA BASE DE DATOS Y ASIGNARLO A UN MUSEO-----------
/*
	En este bloque de ejemplo, insertamos los datos de un empleado donde corresponden, y se le asigna un cargo y departamento
	para que al ser ingresado a la base de datos, a su vez se le asigne un cargo y un departamento de una vez.

*/
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


----------VENDER O GENERAR UN TICKET EN UN MUSEO----------
/*
	En este bloque de ejemplo, indica el museo y el tipo de ticket,
	para que se genere automaticamente un ticket
*/
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
        RAISE; -- Re-lanzar para que la aplicación cliente pueda manejarlo
END;
/
----------REGISTRAR UNA NUEVA COLECCION A UN MUSEO----------
/*
	En este pequeño bloque de ejemplo, se insertan los datos necesarios para ingresar una coleccion al museo,
	el orden de recorrido de las otras colecciones se actualizara automaticamente.
*/

EXEC SP_INSERTAR_COLECCION('Musée du Petit Palais', 'Servicio de Exposiciones y Gestión de Colecciones', 'Coleccion Post-Moderna', 'Arte de la era digital y de la información', 'Digital', 3);



----------MODIFICAR EL ORDEN DE RECORRIDO DE UNA COLECCION----------

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
    nombre = 'Mundo Clásico';
    
    SP_MODIFICAR_ORDEN_COLECCION(v_id_coleccion, 3);
    
END;
/

----------ELIMINAR UNA COLECCION DE UN MUSEO----------
DECLARE
    v_id_museo NUMBER;
    v_id_coleccion NUMBER;
    v_id_org NUMBER;
BEGIN

    EXEC SP_INSERTAR_COLECCION('Musée du Petit Palais', 'Servicio de Exposiciones y Gestión de Colecciones', 'Coleccion Post-Moderna', 
        'Arte de la era digital y de la información', 'Digital', 3);

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
    nombre = 'Coleccion Post-Moderna'; -- O una coleccion nueva creada, para no tener que cambiar muchas cosas
    
    SP_ELIMINAR_COLECCION(v_id_coleccion);
    
END;
/

----------MOVER UNA OBRA YA REGISTRADA DENTRO DE UN MUSEO O DE UN MUSEO A OTRO----------
----------ESTE EJEMPLO SIRVE PARA MOVER UNA OBRA A OTRA SALA DENTRO DEL MISMO MUSEO----------
/*
	Este bloque de ejemplo, uno ingresa los datos de su obra y de la sala a donde se quiere mover
	esa obra.
*/
DECLARE
    v_id_museo NUMBER;
    v_id_obra NUMBER;
    v_id_sala NUMBER;
BEGIN
    
    SELECT id_museo INTO v_id_museo
    FROM MUSEOS
    WHERE nombre= 'Musée du Petit Palais';
    
    
    SELECT id_obra INTO v_id_obra
    FROM OBRAS
    WHERE nombre = 'Ugolino' AND
    tipo_obra = 'ESCULTURA';
    
    SELECT id_sala INTO v_id_sala
    FROM SALAS_EXP
    WHERE id_museo = v_id_museo AND
    nombre = 'GALERIE TUCK';

    SP_MOVER_OBRA(
        n_id_obra               => v_id_obra,           -- Reemplaza con el ID de tu obra
        p_id_sala_destino       => v_id_sala,     	-- ID de la nueva sala
        p_id_empleado_destino   => NULL,                 -- Usará el empleado actual
        p_tipo_adq_destino      => NULL,                 -- Usará el tipo de adquisición actual
        p_destacada_destino     => NULL,                 -- Usará el estado destacada actual (SI o NO)
        p_orden_recorrido_destino => NULL,               -- Se calculará automáticamente si es necesario
        p_valor_monetario_destino => NULL                -- Usará el valor monetario actual
    );

    COMMIT;
END;
/


-------------MOVER OBRA A OTRO MUSEO-----------------
/*
	Se utiliza para mover una obra del Petit Palais al museo Hamburger Kunsthalle
*/
DECLARE
    -- IDs de ejemplo para la obra y sus ubicaciones (ajusta si es necesario)
    v_id_obra_test              OBRAS.id_obra%TYPE := 60;

    -- Datos para el museo de destino
    v_id_museo_destino          MUSEOS.id_museo%TYPE := 8;
    v_id_est_org_destino        EST_ORGANIZACIONAL.id_est_org%TYPE := 61;
    v_id_coleccion_destino      COLECCIONES_PERMANENTES.id_coleccion%TYPE := 33;
    v_id_sala_destino           SALAS_EXP.id_sala%TYPE := 52;
    v_id_empleado_destino       EMPLEADOS_PROFESIONALES.id_empleado%TYPE := 70;
BEGIN

    -- Ejecución del procedimiento para mover la obra al nuevo museo
    SP_MOVER_OBRA(
        n_id_obra             => v_id_obra_test,
        p_id_museo_destino    => v_id_museo_destino,
        p_id_coleccion_destino => v_id_coleccion_destino,
        p_id_sala_destino     => v_id_sala_destino,
        p_id_empleado_destino => v_id_empleado_destino,
        p_tipo_adq_destino    => 'DONADA',
        p_destacada_destino   => 'NO',
        p_orden_recorrido_destino => NULL, -- Se calculará automáticamente
        p_valor_monetario_destino => 60000
    );

    COMMIT;
END;
/

----------MOVER UNA OBRA NO REGISTRADA TODAVIA EN LA MASE DE DATOS------------
----------PRIMERO SE INSERTA LA OBRA EN LA BASE DE DATOS, LUEGO SE LLAMA EL PROCEDIMIENTO ------------
DECLARE
    v_id_museo      NUMBER;
    v_id_obra       NUMBER;
    v_id_sala       NUMBER;
    v_id_empleado   NUMBER;
    v_id_coleccion  NUMBER; -- Variable para almacenar el ID de la colección
BEGIN
    -- Habilitar la salida para ver los mensajes
    DBMS_OUTPUT.PUT_LINE('Iniciando el bloque de uso...');

    INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
    VALUES (
        'El Regreso del Segador',
        TO_DATE('1886-01-01', 'YYYY-MM-DD'),
        'PINTURA',
        '81 x 114 cm',
        'Óleo sobre lienzo. Laeghaire utilizó una paleta de colores terrosos y vibrantes, aplicando la pintura con pinceladas sueltas para capturar la luz y la atmósfera rural irlandesa.',
        'Pintura de género del Realismo.'
    )
    RETURNING id_obra INTO v_id_obra; -- Obtener el ID de la obra recién insertada

    DBMS_OUTPUT.PUT_LINE('Obra "El Regreso del Segador" insertada con ID: ' || v_id_obra);

    -- Obtener IDs de referencia
    BEGIN -- Manejo de excepción para SELECT de Museo
        SELECT id_museo INTO v_id_museo
        FROM MUSEOS
        WHERE nombre= 'Musée du Petit Palais';
        DBMS_OUTPUT.PUT_LINE('ID de Museo "Musée du Petit Palais": ' || v_id_museo);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20010, 'Error: Museo "Musée du Petit Palais" no encontrado. Verifica tus datos.');
    END;
    
    BEGIN -- Manejo de excepción para SELECT de Empleado
        SELECT id_empleado INTO v_id_empleado
        FROM EMPLEADOS_PROFESIONALES
        WHERE doc_identidad = 2013; -- Asegúrate de que este empleado exista
        DBMS_OUTPUT.PUT_LINE('ID de Empleado con Doc_identidad 2013: ' || v_id_empleado);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20011, 'Error: Empleado con Doc_identidad 2013 no encontrado. Verifica tus datos.');
    END;
    
    BEGIN -- Manejo de excepción para SELECT de Sala
        SELECT id_sala INTO v_id_sala
        FROM SALAS_EXP
        WHERE id_museo = v_id_museo AND
        nombre = 'GALERIE TUCK'; -- Asegúrate de que esta sala exista en el museo
        DBMS_OUTPUT.PUT_LINE('ID de Sala "GALERIE TUCK": ' || v_id_sala);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20012, 'Error: Sala "GALERIE TUCK" no encontrada en el museo especificado. Verifica tus datos.');
    END;

    BEGIN -- Manejo de excepción para SELECT de Colección
        -- Necesitas obtener un ID de colección que corresponda al museo de destino.
        SELECT id_coleccion INTO v_id_coleccion
        FROM COLECCIONES_PERMANENTES
        WHERE id_museo = v_id_museo -- Asegúrate de que la colección pertenezca al museo
        AND nombre = 'Siglo XVIII'; -- Reemplaza con un nombre de colección real
        DBMS_OUTPUT.PUT_LINE('ID de Colección "Colección de Pintura Europea": ' || v_id_coleccion);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20013, 'Error: Colección "Colección de Pintura Europea" no encontrada en el museo especificado. Verifica tus datos.');
    END;

    DBMS_OUTPUT.PUT_LINE('Llamando a SP_MOVER_OBRA para la obra ' || v_id_obra || '...');
    SP_MOVER_OBRA(
        n_id_obra                 => v_id_obra,
        p_id_museo_destino        => v_id_museo,             -- Necesario si la obra no tiene histórico
        p_id_coleccion_destino    => v_id_coleccion,         -- Parámetro de colección añadido
        p_id_sala_destino         => v_id_sala,
        p_id_empleado_destino     => v_id_empleado,
        p_tipo_adq_destino        => 'DONADA',  -- Tipo de adquisición adecuado para un primer registro
        p_destacada_destino       => 'NO',
        p_orden_recorrido_destino => NULL,
        p_valor_monetario_destino => 50000.00 -- Un valor inicial para la obra
    );
    DBMS_OUTPUT.PUT_LINE('SP_MOVER_OBRA ejecutado con éxito.');

    COMMIT; -- Confirma los cambios
    DBMS_OUTPUT.PUT_LINE('Transacción confirmada.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error en el bloque de uso: ' || SQLERRM);
        ROLLBACK; -- Deshace todos los cambios si hay un error
END;
/

-----------MOVER EMPLEADO PROFESIONAL EXISTENTE EN LA BD QUE TIENE UN HISTORICO ABIERTO-----------
/*
	Sirve para reasignarle un puesto de trabajo a un empleado, ya sea moverlo de departamento o  cargo.
	Si se quiere mover de un museo a otro, se tiene que colocar el departamento el museo en especifico.
*/
DECLARE
    
    v_id_empleado_a_mover EMPLEADOS_PROFESIONALES.id_empleado%TYPE := '33'; 
    
    v_nuevo_id_museo      MUSEOS.id_museo%TYPE              := '6';
    v_nueva_est_org       EST_ORGANIZACIONAL.id_est_org%TYPE := '35';
    v_nuevo_cargo         HIST_EMPLEADOS.cargo%TYPE         := 'RESTAURADOR';
BEGIN
    SP_MOVER_EMPLEADO_ACTIVO(
        n_id_empleado => v_id_empleado_a_mover,
        n_id_museo    => v_nuevo_id_museo,
        n_id_est_org  => v_nueva_est_org,
        n_cargo       => v_nuevo_cargo
    );
    COMMIT;
END;
/

------------MOVER UN EMPLEADO PROFESIONAL EXISTENTE EN LA BD QUE NO TIENE UN HISTORICO ABIERTO------------------
/*
 Si existe el empleado, se comenta el insert y se le asigna un id de un empleado que exista a v_id_empleado_inactivo
 En caso de no existir, se deja el insert que agregaria un nuevo empleado y lo moveria a su nuevo puesto de trabajo
*/
DECLARE
    v_id_empleado_inactivo EMPLEADOS_PROFESIONALES.id_empleado%TYPE;

    v_nuevo_id_museo      MUSEOS.id_museo%TYPE              := 6;       
    v_nueva_est_org       EST_ORGANIZACIONAL.id_est_org%TYPE := 35;         
    v_nuevo_cargo         HIST_EMPLEADOS.cargo%TYPE         := 'RESTAURADOR';    
BEGIN

    INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
	(123789654, 'Stalper', 'Frencie', TO_DATE('1975-03-14', 'YYYY-MM-DD'), 589652365, NULL, NULL) RETURNING id_empleado INTO v_id_empleado_inactivo;

    SP_MOVER_EMPLEADO_INACTIVO(
        n_id_empleado => v_id_empleado_inactivo,
        n_id_museo    => v_nuevo_id_museo,
        n_id_est_org  => v_nueva_est_org,
        n_cargo       => v_nuevo_cargo
    );
    COMMIT;
END;
/


---------------------REGISTRAR EL MANTENIMIENTO DE UNA OBRA---------------------------
---------------------- LA OBRA TIENE QUE TENER HISTORICO ABIERTO ---------------
---------------------EN ESTE CASO POR MOTIVOS DE PRUEBA, SE ASEGURA QUE LA OBRA TIENE UN SOLO PROGRAMA_MANT-----------------------------
DECLARE
    v_id_obra NUMBER;
    v_id_empleado NUMBER;
    v_id_catalogo NUMBER;
    v_id_mant NUMBER;
BEGIN

    SELECT id_obra INTO v_id_obra
    FROM OBRAS
    WHERE nombre = 'Ugolino';
    
    SELECT id_catalogo_museo INTO v_id_catalogo
    FROM HIST_OBRAS_MOV
    WHERE id_obra = v_id_obra AND
    fecha_salida IS NULL;
    
    SELECT id_mant INTO v_id_mant
    FROM PROGRAMAS_MANT
    WHERE id_obra = v_id_obra AND
    id_catalogo = v_id_catalogo;

    SELECT id_empleado INTO v_id_empleado
    FROM EMPLEADOS_PROFESIONALES
    WHERE doc_identidad = 2020;

    SP_REGISTRAR_MANTENIMIENTO_OBRA(v_id_mant, v_id_empleado, 'Recibio golpes en el proceso');
END;
/

-----------ASIGNARLE UN TURNO Y EST A UN VIGILANTE------------
/*
	En este caso, por motivos de prueba se inserta un vigilante en caso de no tener uno disponible
	Si el vigilante ya existe, se comenta el insert y se le asigna un id en v_id_vigilante_existente
*/
DECLARE
    v_id_vigilante_existente EMPLEADOS_VIGILANTE_MANT.id_vig_mant%TYPE; 

    v_id_est_existente       ASIGNACIONES_MES.id_est%TYPE       := 38; -- REEMPLAZA con un ID_EST existente

    v_turno_asignado         ASIGNACIONES_MES.turno%TYPE        := 'NOCTURNO'; -- O 'MATUTINO' O 'VESPERTINO'
BEGIN

    INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
	('Roberto', 'Mich', 856256423, 'VIGILANTE') RETURNING id_vig_mant INTO v_id_vigilante_existente;

    SP_REGISTRAR_VIGILANTE_MANT(
        n_id_vig_mant => v_id_vigilante_existente,
        n_id_est      => v_id_est_existente,
        n_turno       => v_turno_asignado
    );
    COMMIT;
END;
/



-----------------CERRAR UNA SALA TEMPORALMENTE-----------
/*
	Cabe resaltar, solo se puede cerrar una sala si no
	existe ninguna exposicion en la misma.
*/
DECLARE
    v_id_sala_galerie_tuck SALAS_EXP.id_sala%TYPE;
BEGIN
    SELECT id_sala INTO v_id_sala_galerie_tuck
    FROM SALAS_EXP
    WHERE nombre = 'GALERIE TUCK' AND ROWNUM = 1;

    SP_REGISTRAR_CIERRE_TEMPORAL(
        n_id_sala => v_id_sala_galerie_tuck,
        n_fecha_fin => TO_DATE('2025-07-07', 'YYYY-MM-DD')
    );

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK; 
END;
/



-- -----------------------------------------------------------------------------
-- Script de Población para la Base de Datos de Museos
-- Versión Actualizada con subconsultas, ajustes de cantidad de registros y detalle restaurado.
-- -----------------------------------------------------------------------------
-- Este script contiene los comandos INSERT para poblar las tablas
-- del proyecto de Sistemas de Bases de Datos.
-- -----------------------------------------------------------------------------

SET DEFINE OFF;

-- -----------------------------------------------------------------------------
-- Tabla: LUGARES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into LUGARES table...

-- País Base
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Venezuela', 'PAIS', NULL, 'AMERICA');

-- Ciudades Alemanas (pertenecen a Alemania)
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Caracas', 'CIUDAD', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela' AND tipo = 'PAIS'), NULL);

-- Países Adicionales para Artistas
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Francia', 'PAIS', NULL, 'EUROPA');

PROMPT Data inserted into LUGARES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: OBRAS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into OBRAS table...

-- PINTURAS 
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Miranda en La Carraca', TO_DATE('1896-01-01', 'YYYY-MM-DD'), 'PINTURA', '196.6 cm x 245.5 cm', 'Óleo sobre tela.', 'Pintura histórica venezolana. Representación de Francisco de Miranda en prisión.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Autorretrato con sombrero rojo', TO_DATE('1887-01-01', 'YYYY-MM-DD'), 'PINTURA', '60.5 cm x 50 cm', 'Óleo sobre tela.', 'Realismo académico venezolano.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Maja - Mujer acostada', TO_DATE('1937-01-01', 'YYYY-MM-DD'), 'PINTURA', 'Dimensión no especificada', 'Óleo sobre tela.', 'Expresión pictórica de Armando Reverón con influencia impresionista.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Fisicromía nº 222', TO_DATE('1966-01-01', 'YYYY-MM-DD'), 'PINTURA', 'Dimensión no especificada', 'Técnica cinética.', 'Arte cinético venezolano.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Paisaje tropical con casas rurales y palmeras', TO_DATE('1853-01-01', 'YYYY-MM-DD'), 'PINTURA', '24.8 cm x 32.7 cm', 'Óleo sobre tela adherida a cartón.', 'Romanticismo venezolano.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Picador y toro', TO_DATE('1949-01-01', 'YYYY-MM-DD'), 'PINTURA', '36 cm x 26.8 cm', 'Aguatinta estampada sobre papel Arches.', 'Expresión gráfica española.');
PROMPT Data inserted into OBRAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: IDIOMAS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into IDIOMAS table...

INSERT INTO IDIOMAS (nombre) VALUES ('Alemán');
INSERT INTO IDIOMAS (nombre) VALUES ('Inglés');
INSERT INTO IDIOMAS (nombre) VALUES ('Francés');
INSERT INTO IDIOMAS (nombre) VALUES ('Español');
INSERT INTO IDIOMAS (nombre) VALUES ('Italiano');
INSERT INTO IDIOMAS (nombre) VALUES ('Neerlandés');
INSERT INTO IDIOMAS (nombre) VALUES ('Ruso');
INSERT INTO IDIOMAS (nombre) VALUES ('Japonés');
INSERT INTO IDIOMAS (nombre) VALUES ('Chino Mandarín');
INSERT INTO IDIOMAS (nombre) VALUES ('Portugués'); 

PROMPT Data inserted into IDIOMAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EMPLEADOS_VIGILANTE_MANT
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EMPLEADOS_VIGILANTE_MANT table...

-- Empleados para Museo de Bellas Artes
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Mario', 'Perez', 10567990, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Marlene', 'Gonzalez', 7670456, 'MANTENIMIENTO');
-- Empleados para Galeria de Arte Nacional
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Esteban', 'Martinez', 8478934, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Julio', 'Rodriguez', 15678905, 'MANTENIMIENTO');

PROMPT Data inserted into EMPLEADOS_VIGILANTE_MANT table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EMPLEADOS_PROFESIONALES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EMPLEADOS_PROFESIONALES table...

INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(9155789, 'José', 'Pérez', TO_DATE('1970-05-12', 'YYYY-MM-DD'), 584121234567, 'Antonio', NULL); -- Director Museo de Arte Caracas
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(8345878, 'María', 'González', TO_DATE('1965-11-20', 'YYYY-MM-DD'), 584241234567, NULL, 'Ramírez'); -- Directora Galería Nacional
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(15310561, 'Carlos', 'Rodríguez', TO_DATE('1982-02-28', 'YYYY-MM-DD'), 584141234567, 'Eduardo', NULL); -- Curador Museo de Arte Caracas
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(11230566, 'Isabela', 'Martínez', TO_DATE('1978-09-03', 'YYYY-MM-DD'), 584141234587, 'Sofía', 'Fernández'); -- Curadora Galería Nacional


PROMPT Data inserted into EMPLEADOS_PROFESIONALES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: ARTISTAS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into ARTISTAS table...

INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor venezolano del siglo XIX, reconocido por sus obras históricas y alegóricas.', 'Arturo', 'Michelena', TO_DATE('1863-06-16', 'YYYY-MM-DD'), TO_DATE('1898-07-29', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor venezolano del siglo XIX, destacado por su realismo académico y su enfoque en la figura humana.', 'Cristóbal', 'Rojas', TO_DATE('1858-12-15', 'YYYY-MM-DD'), TO_DATE('1890-11-08', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor venezolano, pionero del arte moderno en el país, conocido por su exploración de la luz y la textura.', 'Armando', 'Reverón', TO_DATE('1889-05-10', 'YYYY-MM-DD'), TO_DATE('1954-10-18', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Artista venezolano, figura clave del arte cinético, reconocido por sus obras de color y movimiento.', 'Carlos', 'Cruz-Diez', TO_DATE('1923-08-17', 'YYYY-MM-DD'), TO_DATE('2019-07-27', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor impresionista franco-venezolano, conocido por sus paisajes y escenas rurales.', 'Camille', 'Pissarro', TO_DATE('1830-07-10', 'YYYY-MM-DD'), TO_DATE('1903-11-13', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor y escultor español, maestro del grabado y la pintura expresiva.', 'Pablo', 'Picasso', TO_DATE('1881-10-25', 'YYYY-MM-DD'), TO_DATE('1973-04-08', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'España'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor venezolano, reconocido por su estilo expresionista y su enfoque en la identidad nacional.', 'Héctor', 'Poleo', TO_DATE('1914-07-20', 'YYYY-MM-DD'), TO_DATE('1989-02-16', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Escultor y artista cinético venezolano, creador de estructuras dinámicas y vibrantes.', 'Jesús', 'Soto', TO_DATE('1923-06-05', 'YYYY-MM-DD'), TO_DATE('2005-01-14', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Artista venezolana de origen alemán, pionera en la abstracción geométrica y el arte cinético.', 'Gertrud', 'Goldschmidt', TO_DATE('1912-08-01', 'YYYY-MM-DD'), TO_DATE('1994-09-17', 'YYYY-MM-DD'), 'Gego', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor venezolano, destacado por su enfoque en la pintura histórica y alegórica.', 'Lorenzo', 'González', TO_DATE('1914-01-01', 'YYYY-MM-DD'), TO_DATE('1998-01-01', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela'));

PROMPT Data inserted into ARTISTAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: ARTISTAS_OBRAS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into ARTISTAS_OBRAS table...

INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Miranda en La Carraca'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Arturo' AND primer_apellido = 'Michelena'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Autorretrato con sombrero rojo'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Cristóbal' AND primer_apellido = 'Rojas'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Maja - Mujer acostada'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Armando' AND primer_apellido = 'Reverón'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Fisicromía nº 222'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Carlos' AND primer_apellido = 'Cruz-Diez'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Paisaje tropical con casas rurales y palmeras'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Camille' AND primer_apellido = 'Pissarro'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Picador y toro'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Pablo' AND primer_apellido = 'Picasso'));

PROMPT Data inserted into ARTISTAS_OBRAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EMPLEADOS_IDIOMAS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EMPLEADOS_IDIOMAS table...

-- Empleado Profesional: Dr. Stefan Baumann (doc_identidad: 9155789)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 9155789), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Español'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 9155789), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
-- Empleado Profesional: Prof. Eva Keller (doc_identidad: 8345878)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 8345878), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Español'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 8345878), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
-- Empleado Profesional: Markus Schneider (doc_identidad: 15310561)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 15310561), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Español'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 15310561), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Italiano'));
-- Empleado Profesional: Isabelle Vogel (doc_identidad: 11230566)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 11230566), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Español'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 11230566), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 11230566), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Italiano'));

PROMPT Data inserted into EMPLEADOS_IDIOMAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: FORMACIONES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into FORMACIONES table...

-- Formaciones para Empleado: José Pérez (doc_identidad: 9155789)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 9155789), 'Doctorado en Historia del Arte', 2005, 'Tesis sobre el arte colonial venezolano, Universidad Central de Venezuela.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 9155789), 'Máster en Museología', 2001, 'Especialización en Curaduría de Arte Latinoamericano, Universidad Simón Bolívar.');
-- Formaciones para Empleado: María González (doc_identidad: 8345878)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 8345878), 'Cátedra en Conservación de Arte', 2010, 'Investigación en técnicas de restauración de patrimonio venezolano, Academia de Bellas Artes de Caracas.');
-- Formaciones para Empleado: Carlos Rodríguez (doc_identidad: 15310561)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 15310561), 'Máster en Gestión Cultural', 2012, 'Proyectos culturales y administración de museos, Universidad Católica Andrés Bello.');
-- Formaciones para Empleado: Isabela Martínez (doc_identidad: 11230566)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 11230566), 'Doctorado en Arte Contemporáneo', 2008, 'Estudio sobre arte post-minimalista en Venezuela, Universidad de los Andes.');


PROMPT Data inserted into FORMACIONES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: MUSEOS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into MUSEOS table...

-- Museo de Bellas Artes de Caracas
INSERT INTO MUSEOS (id_lugar, nombre, fecha_fundacion, mision) VALUES 
((SELECT id_lugar FROM LUGARES WHERE nombre = 'Caracas'), 'Museo de Bellas Artes', TO_DATE('1917-02-15', 'YYYY-MM-DD'), 'Promover, conservar y exhibir obras de arte venezolano e internacional, fomentando el conocimiento y disfrute del patrimonio cultural.');
-- Galería Nacional de Arte en Caracas
INSERT INTO MUSEOS (id_lugar, nombre, fecha_fundacion, mision) VALUES 
((SELECT id_lugar FROM LUGARES WHERE nombre = 'Caracas'), 'Galería Nacional de Arte', TO_DATE('1976-07-03', 'YYYY-MM-DD'), 'Preservar y difundir la producción artística nacional, estableciendo un espacio de diálogo y apreciación cultural en Venezuela.');
PROMPT Data inserted into MUSEOS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EST_FISICA (Estructura Física de los Museos)
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EST_FISICA table (Restored Detail-- Edificios principales
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Edificio GAN', 'EDIFICIO', 'Edificio moderno con tres volúmenes principales, diseñado para exhibiciones de gran escala.', 'Avenida México, Caracas, Venezuela', NULL);
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Edificio Neoclásico MBA', 'EDIFICIO', 'Edificio de estilo neoclásico con patio central y columnatas.', 'Plaza de los Museos, Caracas, Venezuela', NULL);
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Edificio Brutalista MBA', 'EDIFICIO', 'Edificio moderno de concreto y vidrio, con múltiples niveles de exhibición.', 'Plaza de los Museos, Caracas, Venezuela', NULL);

-- Pisos de la GAN
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Nivel 1 GAN', 'PISO', 'Primer nivel con salas de exposición de arte venezolano del siglo XIX.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Edificio GAN'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Nivel 2 GAN', 'PISO', 'Segundo nivel con exposiciones de arte contemporáneo y vanguardias venezolanas.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Edificio GAN'));

-- Pisos del MBA
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Planta Baja MBA', 'PISO', 'Planta baja con acceso principal, foyer y tienda del museo.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Edificio Neoclásico MBA'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Primer Piso MBA', 'PISO', 'Primer piso con salas de arte egipcio y cerámica china.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Edificio Neoclásico MBA'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Segundo Piso MBA', 'PISO', 'Segundo piso con colecciones de arte cubista y latinoamericano.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Edificio Brutalista MBA'));

-- Áreas específicas de la GAN
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Centro de Información CINAP', 'AREA', 'Centro de documentación de artes plásticas.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Nivel 1 GAN'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Centro de Restauración CENCREP', 'AREA', 'Laboratorio de conservación y restauración de obras.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Nivel 2 GAN'));

-- Áreas específicas del MBA
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Jardín de Esculturas MBA', 'AREA', 'Espacio al aire libre con esculturas de diversos artistas.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja MBA'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Sala Cinemateca Nacional', 'AREA', 'Sala de proyección cinematográfica dentro del museo.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Primer Piso MBA'));

PROMPT Data inserted into EST_FISICA table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: ASIGNACIONES_MES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into ASIGNACIONES_MES table...

-- Asignaciones para el Museo de Bellas Artes de Caracas
INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-01', 'YYYY-MM-DD'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 10567990), 'MATUTINO');

INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-07-01', 'YYYY-MM-DD'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Primer Piso MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 7670456), 'MATUTINO');

-- Asignaciones para la Galería Nacional de Arte
INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-01', 'YYYY-MM-DD'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Nivel 2 GAN' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 8478934), 'VESPERTINO');

INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-07-01', 'YYYY-MM-DD'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Centro de Restauración CENCREP' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 15678905), 'NOCTURNO');
PROMPT Data inserted into ASIGNACIONES_MES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: SALAS_EXP
-- -----------------------------------------------------------------------------
PROMPT Inserting data into SALAS_EXP table...

-- Salas para la Galería Nacional de Arte (GAN)
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Nivel 1 GAN' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 'Sala de Arte Venezolano Siglo XIX', 'Exposición permanente con obras de Michelena, Rojas y Herrera Toro.');

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Nivel 2 GAN' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 'Sala de Vanguardias Venezolanas', 'Exposición de arte moderno y contemporáneo venezolano.');

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Centro de Información CINAP' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 'Sala de Documentación CINAP', 'Espacio dedicado a la consulta de archivos y documentación de artes plásticas.');

-- Salas para el Museo de Bellas Artes (MBA)
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Primer Piso MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Sala de Arte Egipcio', 'Colección permanente con piezas adquiridas del Museo Metropolitano de Nueva York.');

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Segundo Piso MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Sala de Arte Cubista', 'Exposición con obras de Picasso, Braque y Juan Gris.');

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Jardín de Esculturas MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Jardín de Esculturas', 'Espacio al aire libre con esculturas de artistas venezolanos e internacionales.');

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Sala Cinemateca Nacional' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Sala Cinemateca Nacional', 'Espacio para proyección de cine y eventos audiovisuales.');

PROMPT Data inserted into SALAS_EXP table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EXPOSICIONES_EVENTOS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EXPOSICIONES_EVENTOS table...
-- Exposiciones/Eventos para la Galería Nacional de Arte (GAN)
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala de Arte Venezolano Siglo XIX' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Nivel 1 GAN' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 'Venezuela Es Arte', TO_DATE('2025-02-01', 'YYYY-MM-DD'), TO_DATE('2025-06-30', 'YYYY-MM-DD'), 0.00, NULL, NULL);

INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala de Vanguardias Venezolanas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Nivel 2 GAN' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 'Espiritualidad y Surrealismo - Alexis De La Sierra', TO_DATE('2025-03-15', 'YYYY-MM-DD'), TO_DATE('2025-07-15', 'YYYY-MM-DD'), 0.00, NULL, NULL);

INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala de Documentación CINAP' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Centro de Información CINAP' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 'Autógrafos de la Guerra - Gennady Dobrov', TO_DATE('2025-04-01', 'YYYY-MM-DD'), TO_DATE('2025-08-01', 'YYYY-MM-DD'), 0.00, NULL, NULL);

-- Exposiciones/Eventos para el Museo de Bellas Artes (MBA)
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala de Arte Egipcio' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Primer Piso MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Egipto Eterno: Tesoros del Nilo', TO_DATE('2025-05-10', 'YYYY-MM-DD'), TO_DATE('2025-09-10', 'YYYY-MM-DD'), 5.00, NULL, NULL);

INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala de Arte Cubista' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Segundo Piso MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Picasso y el Cubismo: Una Revolución Visual', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-10-01', 'YYYY-MM-DD'), 8.00, NULL, NULL);

INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Jardín de Esculturas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Jardín de Esculturas MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Escultura Venezolana: Tradición y Vanguardia', TO_DATE('2025-07-15', 'YYYY-MM-DD'), TO_DATE('2025-11-15', 'YYYY-MM-DD'), 0.00, NULL, NULL);

PROMPT Data inserted into EXPOSICIONES_EVENTOS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: CIERRES_TEMPORALES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into CIERRES_TEMPORALES table...

-- Cierre para la Galería Nacional de Arte (GAN), Sala de Vanguardias Venezolanas (montaje nueva exposición)
-- Razón: Programado después del fin de la exposición "Espiritualidad y Surrealismo" que termina el 15-07-2025
INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES 
(TO_DATE('2025-07-16', 'YYYY-MM-DD'), 
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala de Vanguardias Venezolanas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Nivel 2 GAN' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 TO_DATE('2025-07-31', 'YYYY-MM-DD'));

-- Cierre para el Museo de Bellas Artes (MBA), Sala de Arte Egipcio (mantenimiento)
-- Razón: Programado después del fin de la exposición "Egipto Eterno" que termina el 10-09-2025
INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES 
(TO_DATE('2025-09-11', 'YYYY-MM-DD'), 
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala de Arte Egipcio' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Primer Piso MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 TO_DATE('2025-09-20', 'YYYY-MM-DD'));

-- Cierre para el Museo de Bellas Artes (MBA), Jardín de Esculturas (reacondicionamiento)
-- Razón: Programado después del fin de la exposición "Escultura Venezolana" que termina el 15-11-2025
INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES 
(TO_DATE('2025-11-16', 'YYYY-MM-DD'), 
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Jardín de Esculturas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Jardín de Esculturas MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 TO_DATE('2025-11-30', 'YYYY-MM-DD'));
PROMPT Data inserted into CIERRES_TEMPORALES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EST_ORGANIZACIONAL
-- Descripción: Define la estructura jerárquica y de unidades organizativas de los museos.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EST_ORGANIZACIONAL table...

-- Estructura Organizacional para la Galería de Arte Nacional (GAN)
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Dirección General', 'DIRECCION', 1, 'Responsable de la gestión estratégica, financiera y operativa de la Galería de Arte Nacional.', NULL);
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Departamento de Curaduría y Colecciones', 'DEPARTAMENTO', 2, 'Gestión, estudio, conservación y desarrollo de las colecciones de arte venezolano.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General GAN' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería de Arte Nacional')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Departamento de Administración', 'DEPARTAMENTO', 2, 'Gestión de recursos financieros y administrativos.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General GAN' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería de Arte Nacional')));

-- Estructura Organizacional para el Museo de Bellas Artes (MBA)
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Dirección General', 'DIRECCION', 1, 'Liderazgo curatorial, desarrollo de exposiciones y estrategia artística del museo.', NULL);
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Curaduría de Arte Universal', 'DEPARTAMENTO', 2, 'Investigación y curaduría de las colecciones de arte europeo, latinoamericano y egipcio.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Departamento de Educación y Programas Públicos', 'DEPARTAMENTO', 2, 'Desarrollo e implementación de programas educativos y de divulgación para diversos públicos.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MBA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')));
PROMPT Data inserted into EST_ORGANIZACIONAL table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: COLECCIONES_PERMANENTES
-- Descripción: Define las colecciones permanentes de los museos, gestionadas por unidades organizativas.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into COLECCIONES_PERMANENTES table...

-- Colecciones para la Galería Nacional de Arte (GAN)
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES 
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Curaduría y Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 'Arte Venezolano Siglo XIX', 
 'Pinturas y esculturas de artistas venezolanos del siglo XIX, incluyendo Michelena, Rojas y Tovar y Tovar.', 
 'Realismo', 1);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES 
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Curaduría y Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 'Arte Moderno y Contemporáneo Venezolano', 
 'Obras de artistas venezolanos del siglo XX y XXI, incluyendo Reverón, Soto y Cruz-Diez.', 
 'Modernismo', 2);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES 
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Curaduría y Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 
 'Arte Popular Venezolano', 
 'Colección de arte popular y tradicional venezolano, con énfasis en expresiones indígenas y rurales.', 
 'Popular', 3);

-- Colecciones para el Museo de Bellas Artes (MBA)
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES 
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Curaduría de Arte Universal' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Colección de Arte Egipcio', 
 'Piezas adquiridas del Museo Metropolitano de Nueva York, incluyendo esculturas y relieves.', 
 'Egipto', 1);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES 
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Curaduría de Arte Universal' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Arte Cubista y Vanguardias', 
 'Obras de Picasso, Braque y Juan Gris, representando el desarrollo del cubismo.', 
 'Cubismo', 2);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES 
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Curaduría de Arte Universal' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 
 'Arte Latinoamericano del Siglo XX', 
 'Obras de artistas latinoamericanos como Botero, Lam y Matta.', 
 'Latinoamericano', 3);
PROMPT Data inserted into COLECCIONES_PERMANENTES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: SALAS_COLECCIONES
-- Descripción: Vincula colecciones permanentes con las salas de exposición donde se muestran.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into SALAS_COLECCIONES table...
-- Salas y colecciones para la Galería Nacional de Arte (GAN)
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES 
((SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Venezolano Siglo XIX' AND m.nombre = 'Galería Nacional de Arte'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones' AND m.nombre = 'Galería Nacional de Arte'),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'),
 (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Venezolano Siglo XIX' AND ef.nombre = 'Nivel 1 GAN' AND m.nombre = 'Galería Nacional de Arte'),
 (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Nivel 1 GAN' AND m.nombre = 'Galería Nacional de Arte'),
 1);

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES 
((SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Moderno y Contemporáneo Venezolano' AND m.nombre = 'Galería Nacional de Arte'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones' AND m.nombre = 'Galería Nacional de Arte'),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'),
 (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Vanguardias Venezolanas' AND ef.nombre = 'Nivel 2 GAN' AND m.nombre = 'Galería Nacional de Arte'),
 (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Nivel 2 GAN' AND m.nombre = 'Galería Nacional de Arte'),
 2);

-- Salas y colecciones para el Museo de Bellas Artes (MBA)
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES 
((SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Egipcio' AND m.nombre = 'Museo de Bellas Artes'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Curaduría de Arte Universal' AND m.nombre = 'Museo de Bellas Artes'),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'),
 (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Egipcio' AND ef.nombre = 'Primer Piso MBA' AND m.nombre = 'Museo de Bellas Artes'),
 (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primer Piso MBA' AND m.nombre = 'Museo de Bellas Artes'),
 1);

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES 
((SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Cubista y Vanguardias' AND m.nombre = 'Museo de Bellas Artes'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Curaduría de Arte Universal' AND m.nombre = 'Museo de Bellas Artes'),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'),
 (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Cubista' AND ef.nombre = 'Segundo Piso MBA' AND m.nombre = 'Museo de Bellas Artes'),
 (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segundo Piso MBA' AND m.nombre = 'Museo de Bellas Artes'),
 2);
PROMPT Data inserted into SALAS_COLECCIONES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: HIST_EMPLEADOS
-- Descripción: Registra el historial de cargos de los empleados profesionales en las unidades organizativas.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into HIST_EMPLEADOS table...

-- Movimientos de obras en la Galería Nacional de Arte
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Miranda en La Carraca'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Venezolano Siglo XIX' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Venezolano Siglo XIX' AND ef.nombre = 'Nivel 1 GAN' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 11230566), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Galería Nacional de Arte'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Nivel 1 GAN' AND m.nombre = 'Galería Nacional de Arte'), 
    TO_DATE('1896-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 1, 1500000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Autorretrato con sombrero rojo'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Venezolano Siglo XIX' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Venezolano Siglo XIX' AND ef.nombre = 'Nivel 1 GAN' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 11230566), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Galería Nacional de Arte'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Nivel 1 GAN' AND m.nombre = 'Galería Nacional de Arte'), 
    TO_DATE('1887-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 2, 1200000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Maja - Mujer acostada'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Moderno y Contemporáneo Venezolano' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Vanguardias Venezolanas' AND ef.nombre = 'Nivel 2 GAN' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 11230566), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Galería Nacional de Arte'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Nivel 2 GAN' AND m.nombre = 'Galería Nacional de Arte'), 
    TO_DATE('1937-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 3, 2500000.00);
    
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Fisicromía nº 222'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Moderno y Contemporáneo Venezolano' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Vanguardias Venezolanas' AND ef.nombre = 'Nivel 2 GAN' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 11230566), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones' AND m.nombre = 'Galería Nacional de Arte'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Galería Nacional de Arte'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Nivel 2 GAN' AND m.nombre = 'Galería Nacional de Arte'), 
    TO_DATE('1966-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 4, 3200000.00);

-- Movimientos de obras en el Museo de Bellas Artes
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Paisaje tropical con casas rurales y palmeras'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Latinoamericano del Siglo XX' AND m.nombre = 'Museo de Bellas Artes'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Egipcio' AND ef.nombre = 'Primer Piso MBA' AND m.nombre = 'Museo de Bellas Artes'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 15310561), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Curaduría de Arte Universal' AND m.nombre = 'Museo de Bellas Artes'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Bellas Artes'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primer Piso MBA' AND m.nombre = 'Museo de Bellas Artes'), 
    TO_DATE('1853-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 5, 500000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Picador y toro'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Cubista y Vanguardias' AND m.nombre = 'Museo de Bellas Artes'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Cubista' AND ef.nombre = 'Segundo Piso MBA' AND m.nombre = 'Museo de Bellas Artes'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 15310561), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Curaduría de Arte Universal' AND m.nombre = 'Museo de Bellas Artes'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Bellas Artes'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segundo Piso MBA' AND m.nombre = 'Museo de Bellas Artes'), 
    TO_DATE('1949-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 6, 1250000.00);
 
PROMPT Data inserted into HIST_OBRAS_MOV table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: PROGRAMAS_MANT
-- Descripción: Define los programas de mantenimiento preventivo para las obras.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into PROGRAMAS_MANT table...
-- Programas de mantenimiento para la Galería Nacional de Arte
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES 
((SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Miranda en La Carraca' AND m.nombre = 'Galería Nacional de Arte' AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Miranda en La Carraca'), 
 'Revisión del estado de conservación y condiciones ambientales de la pintura.', 
 'Semestral', 
 'CURADOR');

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES 
((SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Autorretrato con sombrero rojo' AND m.nombre = 'Galería Nacional de Arte' AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Autorretrato con sombrero rojo'), 
 'Control de iluminación y humedad relativa para preservar la pintura sobre lienzo.', 
 'Trimestral', 
 'CURADOR');

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES 
((SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Maja - Mujer acostada' AND m.nombre = 'Galería Nacional de Arte' AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Maja - Mujer acostada'), 
 'Limpieza superficial del lienzo y control de microclima en la sala.', 
 'Anual', 
 'RESTAURADOR');

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES 
((SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Fisicromía nº 222' AND m.nombre = 'Galería Nacional de Arte' AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Fisicromía nº 222'), 
 'Monitoreo del color y estabilidad de los materiales en condiciones de exhibición.', 
 'Semestral', 
 'RESTAURADOR');

-- Programas de mantenimiento para el Museo de Bellas Artes
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES 
((SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Paisaje tropical con casas rurales y palmeras' AND m.nombre = 'Museo de Bellas Artes' AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Paisaje tropical con casas rurales y palmeras'), 
 'Inspección anual para evaluación de los materiales y nivel de deterioro.', 
 'Anual', 
 'RESTAURADOR');

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES 
((SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Picador y toro' AND m.nombre = 'Museo de Bellas Artes' AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Picador y toro'), 
 'Control periódico de iluminación y humedad para preservar los pigmentos originales.', 
 'Trimestral', 
 'CURADOR');
PROMPT Data inserted into PROGRAMAS_MANT table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: MANTENIMIENTOS_OBRAS_REALIZADOS
-- Descripción: Registra los mantenimientos efectivamente realizados sobre las obras.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into MANTENIMIENTOS_OBRAS_REALIZADOS table...
-- Mantenimiento realizado en la Galería Nacional de Arte
-- Nota: Incluimos todas las columnas explícitamente, id_mant_realizado se genera automáticamente
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant_realizado, id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES 
(seq_mant_obra_realizado.NEXTVAL,
 (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Miranda en La Carraca' AND pm.actividad LIKE 'Revisión del estado%' AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom WHERE hom.id_obra = o.id_obra AND hom.id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte') AND ROWNUM = 1)), 
 (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom WHERE hom.id_obra = (SELECT id_obra FROM OBRAS WHERE nombre = 'Miranda en La Carraca') AND hom.id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte') AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Miranda en La Carraca'), 
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 11230566), 
 TO_DATE('2025-02-10', 'YYYY-MM-DD'), 
 TO_DATE('2025-02-11', 'YYYY-MM-DD'), 
 'Revisión semestral completada. Condiciones ambientales óptimas.');

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant_realizado, id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES 
(seq_mant_obra_realizado.NEXTVAL,
 (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Fisicromía nº 222' AND pm.actividad LIKE 'Monitoreo del color%' AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom WHERE hom.id_obra = o.id_obra AND hom.id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte') AND ROWNUM = 1)), 
 (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom WHERE hom.id_obra = (SELECT id_obra FROM OBRAS WHERE nombre = 'Fisicromía nº 222') AND hom.id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte') AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Fisicromía nº 222'), 
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 11230566), 
 TO_DATE('2025-03-05', 'YYYY-MM-DD'), 
 TO_DATE('2025-03-06', 'YYYY-MM-DD'), 
 'Monitoreo semestral realizado. Colores vibrantes y sin alteraciones.');

-- Mantenimiento realizado en el Museo de Bellas Artes
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant_realizado, id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES 
(seq_mant_obra_realizado.NEXTVAL,
 (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Paisaje tropical con casas rurales y palmeras' AND pm.actividad LIKE 'Inspección anual%' AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom WHERE hom.id_obra = o.id_obra AND hom.id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes') AND ROWNUM = 1)), 
 (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom WHERE hom.id_obra = (SELECT id_obra FROM OBRAS WHERE nombre = 'Paisaje tropical con casas rurales y palmeras') AND hom.id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes') AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Paisaje tropical con casas rurales y palmeras'), 
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 15310561), 
 TO_DATE('2025-04-15', 'YYYY-MM-DD'), 
 TO_DATE('2025-04-16', 'YYYY-MM-DD'), 
 'Inspección anual completada. Materiales en excelente estado.');

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant_realizado, id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES 
(seq_mant_obra_realizado.NEXTVAL,
 (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Picador y toro' AND pm.actividad LIKE 'Control periódico%' AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom WHERE hom.id_obra = o.id_obra AND hom.id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes') AND ROWNUM = 1)), 
 (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom WHERE hom.id_obra = (SELECT id_obra FROM OBRAS WHERE nombre = 'Picador y toro') AND hom.id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes') AND ROWNUM = 1), 
 (SELECT id_obra FROM OBRAS WHERE nombre = 'Picador y toro'), 
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 15310561), 
 TO_DATE('2025-05-10', 'YYYY-MM-DD'), 
 TO_DATE('2025-05-11', 'YYYY-MM-DD'), 
 'Control de iluminación y humedad realizado. Pigmentos en óptimas condiciones.');
PROMPT Data inserted into MANTENIMIENTOS_OBRAS_REALIZADOS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: HORARIOS
-- Descripción: Horarios de apertura de los museos por día de la semana.
-- Día: 1 (Lunes) a 7 (Domingo).
-- -----------------------------------------------------------------------------
PROMPT Inserting data into HORARIOS table...

-- Horarios para la Galería Nacional de Arte
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), TO_DATE('01-01-2000 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Martes
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), TO_DATE('01-01-2000 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Miércoles
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), TO_DATE('01-01-2000 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Jueves
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), TO_DATE('01-01-2000 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Viernes
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Sábado
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Domingo

-- Horarios para el Museo de Bellas Artes
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), TO_DATE('01-01-2000 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Martes
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), TO_DATE('01-01-2000 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Miércoles
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), TO_DATE('01-01-2000 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Jueves
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), TO_DATE('01-01-2000 09:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Viernes
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Sábado
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES 
(7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 17:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Domingo

PROMPT Data inserted into HORARIOS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: TIPO_TICKETS
-- Descripción: Define los tipos de tickets y sus precios históricos y actuales.
-- PK: (fecha_inicio, id_museo, tipo)
-- NOTA: Esta tabla debe poblarse ANTES que TICKETS para que el trigger funcione correctamente.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into TIPO_TICKETS table...

-- Tipos de Tickets para la Galería de Arte Nacional
-- Precios actuales (desde 01-ENE-2024)
-- Tipos de Tickets para la Galería Nacional de Arte
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 5.00, 'ADULTO', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 2.00, 'ESTUDIANTE', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 0.00, 'INFANTIL', NULL);

-- Tipos de Tickets para el Museo de Bellas Artes
-- Precios actuales (desde 01-ENE-2024)
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 6.00, 'ADULTO', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 3.00, 'ESTUDIANTE', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 0.00, 'INFANTIL', NULL);
PROMPT Data inserted into TIPO_TICKETS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: TICKETS
-- Descripción: Registra los tickets emitidos.
-- id_num_ticket se genera automáticamente por trigger.
-- precio se asigna automáticamente desde TIPO_TICKETS por trigger.
-- -----------------------------------------------------------------------------
PROMPT Data inserted into TICKETS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: HIST_MUSEOS
-- Descripción: Registra hechos históricos importantes de los museos.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into HIST_MUSEOS table...

-- Hechos para la Galería Nacional de Arte
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES 
(1974, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Creación de la Galería Nacional de Arte con el propósito de resaltar el arte venezolano en un espacio dedicado.');
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES 
(1976, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Inauguración oficial de la Galería Nacional de Arte en la antigua sede del Museo de Bellas Artes.');
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES 
(2009, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Galería Nacional de Arte'), 'Inauguración de la sede definitiva de la GAN en la avenida México, fortaleciendo el circuito cultural de Caracas.');

-- Hechos para el Museo de Bellas Artes
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES 
(1917, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Fundación del Museo de Bellas Artes, convirtiéndose en el primer museo de Venezuela.');
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES 
(1938, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Construcción del edificio del Museo de Bellas Artes por el arquitecto Carlos Raúl Villanueva.');
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES 
(1976, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Bellas Artes'), 'Expansión del museo con la inauguración de nuevas salas y la redefinición de su colección.');
PROMPT Data inserted into HIST_MUSEOS table.
PROMPT -----------------------------------------------------------------------------

-- COMMIT; -- Descomentar al final del script para guardar todos los cambios.
SET DEFINE ON;
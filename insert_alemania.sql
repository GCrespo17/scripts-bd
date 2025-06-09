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
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Alemania', 'PAIS', NULL, 'EUROPA');

-- Ciudades Alemanas (pertenecen a Alemania)
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Leipzig', 'CIUDAD', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania' AND tipo = 'PAIS'), NULL);
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Hamburgo', 'CIUDAD', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania' AND tipo = 'PAIS'), NULL);

-- Países Adicionales para Artistas
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Suiza', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Francia', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('España', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Estados Unidos', 'PAIS', NULL, 'AMERICA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Noruega', 'PAIS', NULL, 'EUROPA');

PROMPT Data inserted into LUGARES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: OBRAS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into OBRAS table...

-- PINTURAS (12 Registros)
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Die Lebensstufen', TO_DATE('1835-01-01', 'YYYY-MM-DD'), 'PINTURA', '72.5 cm x 94 cm', 'Óleo sobre lienzo.', 'Romanticismo. Pintura alegórica que representa las etapas de la vida humana.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Der Schmetterlingsjäger', TO_DATE('1840-01-01', 'YYYY-MM-DD'), 'PINTURA', '114.8 cm x 87.6 cm', 'Óleo sobre lienzo.', 'Biedermeier. Escena de género que idealiza la conexión entre el hombre y la naturaleza.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Felsenlandschaft im Elbsandsteingebirge', TO_DATE('1823-01-01', 'YYYY-MM-DD'), 'PINTURA', '91.5 cm x 71 cm', 'Óleo sobre lienzo.', 'Romanticismo. Paisaje dramático y sublime que enfatiza la grandiosidad de la naturaleza.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Selbstporträt mit fiedelndem Tod', TO_DATE('1872-01-01', 'YYYY-MM-DD'), 'PINTURA', '75 cm x 61 cm', 'Óleo sobre lienzo.', 'Simbolismo. Autorretrato alegórico con una figura de la Muerte tocando el violín.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Metropolis', TO_DATE('1917-01-01', 'YYYY-MM-DD'), 'PINTURA', '150 cm x 300 cm', 'Óleo sobre tabla.', 'Expresionismo Alemán / Nueva Objetividad. Tríptico que captura el caos y la energía de la ciudad moderna.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Wanderer über dem Nebelmeer', TO_DATE('1818-01-01', 'YYYY-MM-DD'), 'PINTURA', '94.8 cm x 74.8 cm', 'Óleo sobre lienzo.', 'Romanticismo. Ícono del paisaje romántico, enfocado en la contemplación y lo sublime (Rückenfigur).');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Das Eismeer', TO_DATE('1824-01-01', 'YYYY-MM-DD'), 'PINTURA', '96.7 cm x 126.9 cm', 'Óleo sobre lienzo.', 'Romanticismo. Paisaje que representa un naufragio en un mar de hielo, simbolizando el poder destructivo de la naturaleza.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Nana, eine Studie', TO_DATE('1877-01-01', 'YYYY-MM-DD'), 'PINTURA', '46 cm x 38 cm', 'Óleo sobre lienzo.', 'Impresionismo. Retrato de una cocotte parisina, caracterizado por pinceladas sueltas y enfoque en la luz.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Die Absinthtrinkerin', TO_DATE('1901-01-01', 'YYYY-MM-DD'), 'PINTURA', '73 cm x 54 cm', 'Óleo sobre lienzo.', 'Periodo Azul. Retrato melancólico que refleja la soledad y la alienación social.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Selbstbildnis mit Modell', TO_DATE('1910-01-01', 'YYYY-MM-DD'), 'PINTURA', '150.4 cm x 100 cm', 'Óleo sobre lienzo.', 'Expresionismo Alemán (Die Brücke). Autorretrato del artista en su estudio con colores intensos y formas distorsionadas.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Mädchenkopf', TO_DATE('1918-01-01', 'YYYY-MM-DD'), 'PINTURA', '43 cm x 33 cm', 'Óleo sobre lienzo.', 'Expresionismo. Retrato de una joven con pinceladas audaces y un enfoque en la expresión emocional.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Arabische Stadt', TO_DATE('1928-01-01', 'YYYY-MM-DD'), 'PINTURA', '31.5 cm x 24 cm', 'Acuarela y tinta sobre papel.', 'Bauhaus. Composición abstracta con formas geométricas y líneas que evocan una arquitectura urbana.');

-- ESCULTURAS (12 Registros)
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Beethoven', TO_DATE('1902-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '310 cm de altura', 'Polícromo: mármol, yeso, bronce y piedras preciosas.', 'Secesión de Viena / Simbolismo. Monumento policromado que representa al compositor como una deidad olímpica.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Adam und Eva', TO_DATE('1897-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '205 cm de altura', 'Mármol blanco.', 'Simbolismo / Neoclasicismo. Representación de las figuras bíblicas con un tratamiento clásico y monumental.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Prometheus', TO_DATE('1886-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '155 cm de altura', 'Bronce fundido.', 'Simbolismo. Figura mitológica representada con tensión dramática y una superficie texturizada.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Kassandra', TO_DATE('1886-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '180 cm de altura', 'Mármol.', 'Neoclasicismo / Simbolismo. Figura trágica de la mitología griega, esculpida con gran expresividad y detalle.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Der Kuss', TO_DATE('1882-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '111.4 cm x 78.4 cm x 75.6 cm', 'Mármol.', 'Impresionismo en escultura. Representación naturalista y sensual de una pareja abrazada.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Der Denker', TO_DATE('1904-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '186 cm de altura (versión monumental)', 'Bronce fundido, pátina oscura.', 'Simbolismo / Realismo. Figura heroica masculina en profunda meditación, representa el poder del pensamiento.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('La Petite Danseuse de Quatorze Ans', TO_DATE('1881-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '99 cm de altura', 'Bronce fundido con pátina, corpiño de tul, lazo de seda.', 'Realismo / Impresionismo. Escultura revolucionaria por su realismo y el uso de materiales mixtos.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Hang-Up', TO_DATE('1966-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '182.9 cm x 213.4 cm x 124.5 cm', 'Acrílico sobre tela, madera y acero.', 'Minimalismo / Post-minimalismo. Obra que difumina los límites entre pintura y escultura.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Repetition Nineteen III', TO_DATE('1968-01-01', 'YYYY-MM-DD'), 'ESCULTURA', 'Aprox. 48-51 cm de altura cada unidad', 'Fibra de vidrio y resina de poliéster translúcida.', 'Post-minimalismo / Arte Procesual. Serie de formas cilíndricas translúcidas dispuestas en el suelo.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Ohne Titel (Wolken)', TO_DATE('1985-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '150 cm x 200 cm x 100 cm', 'Gasa, alambre, yeso pintado.', 'Arte Povera. Escultura suspendida que evoca la forma de nubes, utilizando materiales humildes.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Die große Sinnende', TO_DATE('1908-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '120 cm de altura', 'Bronce fundido.', 'Expresionismo. Figura femenina sentada, con formas simplificadas y una fuerte carga introspectiva.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('Kniende', TO_DATE('1913-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '70 cm de altura', 'Piedra caliza tallada directamente.', 'Expresionismo / Primitivismo. Figura arrodillada con formas angulosas y una expresión solemne.');

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

-- Empleados para MdbK Leipzig
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Hans', 'Müller', 10000001, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Anna', 'Schmidt', 10000002, 'MANTENIMIENTO');

-- Empleados para Hamburger Kunsthalle
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Stefan', 'Weber', 10000003, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Julia', 'Becker', 10000004, 'MANTENIMIENTO');

PROMPT Data inserted into EMPLEADOS_VIGILANTE_MANT table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EMPLEADOS_PROFESIONALES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EMPLEADOS_PROFESIONALES table...

-- EMPLEADOS REALES MdbK LEIPZIG
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000001, 'Dr. Stefan', 'Weppelmann', TO_DATE('1968-03-15', 'YYYY-MM-DD'), 4934121370460, NULL, NULL); -- Director MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000002, 'Dr. Jeannette', 'Stoschek', TO_DATE('1975-07-22', 'YYYY-MM-DD'), 4934121370461, NULL, NULL); -- Subdirectora MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000003, 'Sithara', 'Weeratunga', TO_DATE('1985-11-08', 'YYYY-MM-DD'), 4934121370462, NULL, NULL); -- Agente para la Diversidad MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000004, 'Olga', 'Vostretsova', TO_DATE('1982-04-18', 'YYYY-MM-DD'), 4934121370463, NULL, NULL); -- Agente para la Diversidad MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000005, 'Dr. Jan', 'Nicolaisen', TO_DATE('1973-09-12', 'YYYY-MM-DD'), 4934121370464, NULL, NULL); -- Jefe Pintura y Escultura MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000006, 'Dr. Jenny', 'Graser', TO_DATE('1981-01-25', 'YYYY-MM-DD'), 4934121370465, NULL, NULL); -- Curadora Pintura y Escultura S. XX/XXI MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000007, 'Dr. Philipp', 'Freytag', TO_DATE('1979-06-30', 'YYYY-MM-DD'), 4934121370466, NULL, NULL); -- Curador Fotografía y Artes Mediales MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000008, 'Julia', 'Beckmann', TO_DATE('1987-12-14', 'YYYY-MM-DD'), 4934121370467, NULL, NULL); -- Asistente de Curaduría MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000009, 'Anne', 'Richter', TO_DATE('1984-08-03', 'YYYY-MM-DD'), 4934121370468, NULL, NULL); -- Asistente de Curaduría MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000010, 'Dr. Ulrike', 'Saß', TO_DATE('1976-05-19', 'YYYY-MM-DD'), 4934121370469, NULL, NULL); -- Investigación de Procedencia MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000011, 'Lina', 'Frubrich', TO_DATE('1988-02-07', 'YYYY-MM-DD'), 4934121370470, NULL, NULL); -- Investigación de Procedencia MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000012, 'Susanne', 'Petri', TO_DATE('1983-11-11', 'YYYY-MM-DD'), 4934121370471, NULL, NULL); -- Asistente de Investigación MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000013, 'Linda', 'Wagner', TO_DATE('1980-09-26', 'YYYY-MM-DD'), 4934121370472, NULL, NULL); -- Registro y Gestión de Préstamos MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000014, 'Ulrike', 'Milde', TO_DATE('1977-03-04', 'YYYY-MM-DD'), 4934121370473, NULL, NULL); -- Registro y Gestión de Préstamos MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000015, 'Marko', 'Kloss', TO_DATE('1985-07-17', 'YYYY-MM-DD'), 4934121370474, NULL, NULL); -- Gestión de Colección Física MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000016, 'Uwe', 'Wagner', TO_DATE('1982-10-22', 'YYYY-MM-DD'), 4934121370475, NULL, NULL); -- Gestión de Colección Física MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000017, 'Theresa Anna', 'Bräunig', TO_DATE('1978-04-09', 'YYYY-MM-DD'), 4934121370476, NULL, NULL); -- Jefa Restauración MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000018, 'Sebastian', 'Stumpe', TO_DATE('1981-12-01', 'YYYY-MM-DD'), 4934121370477, NULL, NULL); -- Jefe Biblioteca y Archivo de Artistas MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000019, 'Carolin', 'Rothmund', TO_DATE('1979-06-15', 'YYYY-MM-DD'), 4934121370478, NULL, NULL); -- Jefa Educación Artística MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000020, 'Jörg', 'Dittmer', TO_DATE('1974-08-28', 'YYYY-MM-DD'), 4934121370479, NULL, NULL); -- Jefe Relaciones Públicas, Marketing y Eventos MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000021, 'Sonja Lucia', 'Gatterwe', TO_DATE('1986-02-13', 'YYYY-MM-DD'), 4934121370480, NULL, NULL); -- Prensa y Comunicación Online MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000022, 'Ulrike', 'Otto', TO_DATE('1983-05-20', 'YYYY-MM-DD'), 4934121370481, NULL, NULL); -- Prensa y Comunicación Online MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000023, 'Dirk', 'Kuntze', TO_DATE('1980-11-07', 'YYYY-MM-DD'), 4934121370482, NULL, NULL); -- Nuevos Medios MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000024, 'Katrin', 'Siegmeyer', TO_DATE('1977-09-02', 'YYYY-MM-DD'), 4934121370483, NULL, NULL); -- Jefa Recaudación de Fondos y Alquileres MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000025, 'Anne-Kathrin', 'Herrmann', TO_DATE('1975-01-16', 'YYYY-MM-DD'), 4934121370484, NULL, NULL); -- Jefa Administración MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000026, 'Janet', 'Schirmer', TO_DATE('1984-07-25', 'YYYY-MM-DD'), 4934121370485, NULL, NULL); -- Tienda del Museo MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000027, 'Tim', 'Sachse', TO_DATE('1989-04-12', 'YYYY-MM-DD'), 4934121370486, NULL, NULL); -- Tienda del Museo MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000028, 'Torsten', 'Cech', TO_DATE('1972-10-08', 'YYYY-MM-DD'), 4934121370487, NULL, NULL); -- Jefe Seguridad y Gestión de Instalaciones MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000029, 'Sven', 'Hottenrott', TO_DATE('1976-12-19', 'YYYY-MM-DD'), 4934121370488, NULL, NULL); -- Carpintero del Museo MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000030, 'Dennis', 'Kuhn', TO_DATE('1987-03-06', 'YYYY-MM-DD'), 4934121370489, NULL, NULL); -- Servicios de Edificio MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000031, 'Jens', 'Wuttke', TO_DATE('1985-08-14', 'YYYY-MM-DD'), 4934121370490, NULL, NULL); -- Servicios de Edificio MdbK

-- EMPLEADOS REALES HAMBURGER KUNSTHALLE
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000050, 'Prof. Dr. Alexander', 'Klar', TO_DATE('1965-05-18', 'YYYY-MM-DD'), 494028613200, NULL, NULL); -- Director Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000051, 'Dr. Helga', 'Huskamp', TO_DATE('1972-09-24', 'YYYY-MM-DD'), 494028613201, NULL, NULL); -- Managing Director Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000052, 'Dr. Andreas', 'Stolzenburg', TO_DATE('1968-11-12', 'YYYY-MM-DD'), 494028613202, NULL, NULL); -- Grabados y Dibujos Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000053, 'Dr. Sandra', 'Pisot', TO_DATE('1975-03-07', 'YYYY-MM-DD'), 494028613203, NULL, NULL); -- Antiguos Maestros Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000054, 'Dr. Markus', 'Bertsch', TO_DATE('1971-08-29', 'YYYY-MM-DD'), 494028613204, NULL, NULL); -- Siglo XIX Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000055, 'Toby', 'Kamps', TO_DATE('1969-01-15', 'YYYY-MM-DD'), 494028613205, NULL, NULL); -- Colección Modernista Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000056, 'Dr. Brigitte', 'Kölle', TO_DATE('1973-06-21', 'YYYY-MM-DD'), 494028613206, NULL, NULL); -- Arte Contemporáneo Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000057, 'Dr. Corinne', 'Diserens', TO_DATE('1967-04-10', 'YYYY-MM-DD'), 494028613207, NULL, NULL); -- Arte Contemporáneo Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000058, 'Dr. Annabelle', 'Görgen-Lammers', TO_DATE('1980-12-03', 'YYYY-MM-DD'), 494028613208, NULL, NULL); -- Esculturas y Numismática Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000059, 'Dr. Ute', 'Haug', TO_DATE('1974-07-16', 'YYYY-MM-DD'), 494028613209, NULL, NULL); -- Investigación de Procedencia Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000060, 'Dr. David', 'Klemm', TO_DATE('1982-02-28', 'YYYY-MM-DD'), 494028613210, NULL, NULL); -- Proyecto de Digitalización Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000061, 'Ursula', 'Trieloff', TO_DATE('1976-10-05', 'YYYY-MM-DD'), 494028613211, NULL, NULL); -- Oficina de Colecciones Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000062, 'Dr. Andrea', 'Weniger', TO_DATE('1970-05-22', 'YYYY-MM-DD'), 494028613212, NULL, NULL); -- Educación Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000063, 'Katharina Therese', 'Gietkowski', TO_DATE('1978-09-14', 'YYYY-MM-DD'), 494028613213, NULL, NULL); -- Biblioteca, Archivo y Documentación Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000064, 'Silvia', 'Castro', TO_DATE('1975-11-30', 'YYYY-MM-DD'), 494028613214, NULL, NULL); -- Jefa Conservación Antiguos Maestros Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000065, 'Sabine', 'Zorn', TO_DATE('1973-01-08', 'YYYY-MM-DD'), 494028613215, NULL, NULL); -- Jefa Conservación Papel y Fotografía Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000066, 'Meike', 'Wenck', TO_DATE('1979-04-25', 'YYYY-MM-DD'), 494028613216, NULL, NULL); -- Registro y Coordinación de Exposiciones Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000067, 'Jochen', 'Möhle', TO_DATE('1981-07-11', 'YYYY-MM-DD'), 494028613217, NULL, NULL); -- Manejo de Obras Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000068, 'Dr. Jan', 'Metzler', TO_DATE('1977-12-19', 'YYYY-MM-DD'), 494028613218, NULL, NULL); -- Marketing y Relaciones con el Cliente Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000069, 'Martina', 'Gschwilm', TO_DATE('1983-06-02', 'YYYY-MM-DD'), 494028613219, NULL, NULL); -- Comunicación Digital Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000070, 'Mira', 'Forte', TO_DATE('1985-03-17', 'YYYY-MM-DD'), 494028613220, NULL, NULL); -- Prensa y Relaciones Públicas Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000071, 'Gesa-Thorid', 'Huget', TO_DATE('1974-08-06', 'YYYY-MM-DD'), 494028613221, NULL, NULL); -- Patrocinios y Alianzas Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000072, 'Dr. Anna', 'Punke-Dresen', TO_DATE('1976-11-23', 'YYYY-MM-DD'), 494028613222, NULL, NULL); -- Patrocinios y Alianzas Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000073, 'Sina', 'Fuhrmann', TO_DATE('1988-01-09', 'YYYY-MM-DD'), 494028613223, NULL, NULL); -- Gestión de Eventos Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000074, 'Hassan', 'Daneschwar', TO_DATE('1972-09-15', 'YYYY-MM-DD'), 494028613224, NULL, NULL); -- Supervisión de Salas Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000075, 'Ralf', 'Suerbaum', TO_DATE('1970-04-20', 'YYYY-MM-DD'), 494028613225, NULL, NULL); -- Edificio y Tecnología Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000076, 'Marion', 'Asmus', TO_DATE('1968-12-07', 'YYYY-MM-DD'), 494028613226, NULL, NULL); -- Recursos Humanos Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000077, 'Kathrin', 'von Gönner', TO_DATE('1971-06-13', 'YYYY-MM-DD'), 494028613227, NULL, NULL); -- Contraloría y Finanzas Kunsthalle

PROMPT Data inserted into EMPLEADOS_PROFESIONALES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: ARTISTAS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into ARTISTAS table...

INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor paisajista alemán del Romanticismo, conocido por sus paisajes alegóricos y simbólicos.', 'Caspar David', 'Friedrich', TO_DATE('1774-09-05', 'YYYY-MM-DD'), TO_DATE('1840-05-07', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Destacado pintor alemán del período Biedermeier, famoso por sus escenas de género humorísticas.', 'Carl', 'Spitzweg', TO_DATE('1808-02-05', 'YYYY-MM-DD'), TO_DATE('1885-09-23', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor paisajista noruego, figura clave del Romanticismo.', 'Johan Christian', 'Dahl', TO_DATE('1788-02-24', 'YYYY-MM-DD'), TO_DATE('1857-10-14', 'YYYY-MM-DD'), 'Claus', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Noruega'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor simbolista suizo, obra llena de elementos mitológicos y paisajes oníricos.', 'Arnold', 'Böcklin', TO_DATE('1827-10-16', 'YYYY-MM-DD'), TO_DATE('1901-01-16', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Suiza'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Artista franco-español, pionero del Impresionismo y figura crucial en la transición al arte moderno.', 'Édouard', 'Manet', TO_DATE('1832-01-23', 'YYYY-MM-DD'), TO_DATE('1883-04-30', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Artista español, uno de los más influyentes del siglo XX. Co-fundador del Cubismo.', 'Pablo', 'Picasso', TO_DATE('1881-10-25', 'YYYY-MM-DD'), TO_DATE('1973-04-08', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'España'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor y grabador alemán, figura clave del Expresionismo (Die Brücke).', 'Ernst Ludwig', 'Kirchner', TO_DATE('1880-05-06', 'YYYY-MM-DD'), TO_DATE('1938-06-15', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor, escultor y grabador alemán, figura destacada del Simbolismo y el Art Nouveau.', 'Max', 'Klinger', TO_DATE('1857-02-18', 'YYYY-MM-DD'), TO_DATE('1920-07-05', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Escultor francés considerado el padre de la escultura moderna.', 'Auguste', 'Rodin', TO_DATE('1840-11-12', 'YYYY-MM-DD'), TO_DATE('1917-11-17', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Artista alemana-estadounidense conocida por su trabajo pionero en postminimalismo y arte procesual.', 'Eva', 'Hesse', TO_DATE('1936-01-11', 'YYYY-MM-DD'), TO_DATE('1970-05-29', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Estados Unidos'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
('Pintor suizo-alemán, figura fundamental del arte del siglo XX, transitó por Expresionismo y Abstracción.', 'Paul', 'Klee', TO_DATE('1879-12-18', 'YYYY-MM-DD'), TO_DATE('1940-06-29', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Suiza'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Escultor y grabador alemán, conocido por sus figuras expresionistas alargadas y melancólicas.', 'Wilhelm', 'Lehmbruck', TO_DATE('1881-01-04', 'YYYY-MM-DD'), TO_DATE('1919-03-25', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Artista alemán, figura prominente de la Nueva Objetividad y del Dadaísmo berlinés.', 'George', 'Grosz', TO_DATE('1893-07-26', 'YYYY-MM-DD'), TO_DATE('1959-07-06', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, primer_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES 
('Pintor y escultor francés, uno de los fundadores del Impresionismo, famoso por sus bailarinas.', 'Edgar', 'Degas', TO_DATE('1834-07-19', 'YYYY-MM-DD'), TO_DATE('1917-09-27', 'YYYY-MM-DD'), 'Hilaire-Germain-Edgar', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Francia'));

PROMPT Data inserted into ARTISTAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: ARTISTAS_OBRAS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into ARTISTAS_OBRAS table...

INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Die Lebensstufen'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Caspar David' AND primer_apellido = 'Friedrich'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Felsenlandschaft im Elbsandsteingebirge'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Caspar David' AND primer_apellido = 'Friedrich'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Wanderer über dem Nebelmeer'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Caspar David' AND primer_apellido = 'Friedrich'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Das Eismeer'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Caspar David' AND primer_apellido = 'Friedrich'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Der Schmetterlingsjäger'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Carl' AND primer_apellido = 'Spitzweg'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Selbstporträt mit fiedelndem Tod'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Arnold' AND primer_apellido = 'Böcklin'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Nana, eine Studie'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Édouard' AND primer_apellido = 'Manet'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Die Absinthtrinkerin'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Pablo' AND primer_apellido = 'Picasso'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Selbstbildnis mit Modell'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Ernst Ludwig' AND primer_apellido = 'Kirchner'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Mädchenkopf'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Ernst Ludwig' AND primer_apellido = 'Kirchner'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Beethoven'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Max' AND primer_apellido = 'Klinger'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Adam und Eva'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Max' AND primer_apellido = 'Klinger'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Prometheus'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Max' AND primer_apellido = 'Klinger'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Kassandra'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Max' AND primer_apellido = 'Klinger'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Der Kuss'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Auguste' AND primer_apellido = 'Rodin'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Der Denker'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Auguste' AND primer_apellido = 'Rodin'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Hang-Up'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Eva' AND primer_apellido = 'Hesse'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Repetition Nineteen III'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Eva' AND primer_apellido = 'Hesse'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Ohne Titel (Wolken)'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Eva' AND primer_apellido = 'Hesse'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Arabische Stadt'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Paul' AND primer_apellido = 'Klee'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Die große Sinnende'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Wilhelm' AND primer_apellido = 'Lehmbruck'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Kniende'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Wilhelm' AND primer_apellido = 'Lehmbruck'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Metropolis'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'George' AND primer_apellido = 'Grosz'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'La Petite Danseuse de Quatorze Ans'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Edgar' AND primer_apellido = 'Degas'));

PROMPT Data inserted into ARTISTAS_OBRAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EMPLEADOS_IDIOMAS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EMPLEADOS_IDIOMAS table...

-- Empleado Profesional: Dr. Stefan Weppelmann - Director (doc_identidad: 20000001)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Francés'));

-- Empleado Profesional: Dr. Jeannette Stoschek - Subdirectora (doc_identidad: 20000002)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Dr. Jan Nicolaisen - Jefe Pintura y Escultura (doc_identidad: 20000008)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000008), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000008), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Dr. Jenny Graser - Curadora (doc_identidad: 20000009)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000009), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000009), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Dr. Philipp Freytag - Curador (doc_identidad: 20000010)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000010), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000010), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Theresa Anna Bräunig - Jefa Restauración (doc_identidad: 20000020)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000020), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000020), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Carolin Rothmund - Jefa Educación (doc_identidad: 20000025)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000025), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000025), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleados para Hamburger Kunsthalle
-- Prof. Dr. Alexander Klar - Director (doc_identidad: 20000050)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Francés'));

-- Dr. Helga Huskamp - Managing Director (doc_identidad: 20000051)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000051), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000051), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Dr. Andreas Stolzenburg - Grabados y Dibujos (doc_identidad: 20000052)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000052), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000052), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Dr. Sandra Pisot - Antiguos Maestros (doc_identidad: 20000053)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000053), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000053), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000053), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Italiano'));

-- Dr. Markus Bertsch - Siglo XIX (doc_identidad: 20000054)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000054), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000054), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Toby Kamps - Colección Modernista (doc_identidad: 20000055)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000055), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000055), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));

-- Dr. Andrea Weniger - Educación (doc_identidad: 20000062)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000062), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000062), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

PROMPT Data inserted into EMPLEADOS_IDIOMAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: FORMACIONES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into FORMACIONES table...

-- Formaciones para Empleado: Dr. Stefan Weppelmann - Director (doc_identidad: 20000001)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), 'Doctorado en Historia del Arte', 1998, 'Especialización en arte italiano del Renacimiento, Universidad de Bonn.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), 'Máster en Historia del Arte', 1994, 'Arte del Renacimiento y Barroco, Universidad de Heidelberg.');

-- Formaciones para Empleado: Dr. Jeannette Stoschek - Subdirectora (doc_identidad: 20000002)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), 'Doctorado en Historia del Arte', 2003, 'Especialización en arte gráfico alemán del siglo XIX y XX.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), 'Máster en Museología', 1999, 'Gestión de colecciones y conservación preventiva.');

-- Formaciones para Empleado: Dr. Jan Nicolaisen - Jefe Pintura y Escultura (doc_identidad: 20000008)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000008), 'Doctorado en Historia del Arte', 2001, 'Pintura alemana del siglo XIX, Universidad de Leipzig.');

-- Formaciones para Empleado: Dr. Jenny Graser - Curadora (doc_identidad: 20000009)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000009), 'Doctorado en Historia del Arte', 2009, 'Arte del siglo XX y XXI, especialización en escultura contemporánea.');

-- Formaciones para Empleado: Dr. Philipp Freytag - Curador (doc_identidad: 20000010)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000010), 'Doctorado en Historia del Arte', 2010, 'Fotografía y nuevos medios en el arte contemporáneo.');

-- Formaciones para Empleado: Theresa Anna Bräunig - Jefa Restauración (doc_identidad: 20000020)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000020), 'Máster en Conservación-Restauración', 2005, 'Especialización en pintura sobre lienzo y tabla, Academia de Bellas Artes de Dresden.');

-- Formaciones para Empleado: Carolin Rothmund - Jefa Educación (doc_identidad: 20000025)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000025), 'Máster en Educación Artística', 2010, 'Pedagogía museística y mediación cultural, Universidad de Leipzig.');

-- Formaciones para Empleados Hamburger Kunsthalle
-- Prof. Dr. Alexander Klar - Director (doc_identidad: 20000050)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), 'Doctorado en Historia del Arte', 1995, 'Especialización en arte alemán del siglo XIX, Universidad de Heidelberg.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), 'Máster en Museología', 1991, 'Gestión y administración de museos, Universidad de Múnich.');

-- Dr. Helga Huskamp - Managing Director (doc_identidad: 20000051)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000051), 'Doctorado en Administración Pública', 2002, 'Especialización en gestión cultural y museística.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000051), 'MBA en Gestión Cultural', 1998, 'Administración de instituciones culturales.');

-- Dr. Andreas Stolzenburg - Grabados y Dibujos (doc_identidad: 20000052)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000052), 'Doctorado en Historia del Arte', 1996, 'Especialización en grabado alemán del siglo XVI-XVIII.');

-- Dr. Sandra Pisot - Antiguos Maestros (doc_identidad: 20000053)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000053), 'Doctorado en Historia del Arte', 2004, 'Pintura italiana del Renacimiento y Barroco.');

-- Dr. Markus Bertsch - Siglo XIX (doc_identidad: 20000054)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000054), 'Doctorado en Historia del Arte', 2006, 'Romanticismo alemán y pintura del siglo XIX.');

-- Toby Kamps - Colección Modernista (doc_identidad: 20000055)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000055), 'Máster en Arte Moderno', 1994, 'Arte estadounidense contemporáneo, Universidad de Nueva York.');

-- Dr. Andrea Weniger - Educación (doc_identidad: 20000062)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000062), 'Doctorado en Pedagogía del Arte', 2007, 'Educación artística y mediación cultural en museos.');

PROMPT Data inserted into FORMACIONES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: MUSEOS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into MUSEOS table...

-- Museum der bildenden Künste Leipzig
INSERT INTO MUSEOS (id_lugar, nombre, fecha_fundacion, mision) VALUES 
((SELECT id_lugar FROM LUGARES WHERE nombre = 'Leipzig'), 'Museum der bildenden Künste Leipzig', TO_DATE('1848-12-10', 'YYYY-MM-DD'), 'Coleccionar, conservar, investigar y exhibir obras de arte desde la Edad Media hasta la actualidad, con fines de estudio, educación y deleite para el público.');
-- Hamburger Kunsthalle
INSERT INTO MUSEOS (id_lugar, nombre, fecha_fundacion, mision) VALUES 
((SELECT id_lugar FROM LUGARES WHERE nombre = 'Hamburgo'), 'Hamburger Kunsthalle', TO_DATE('1869-08-15', 'YYYY-MM-DD'), 'Preservar y presentar más de 700 años de arte europeo, fomentando el diálogo entre el pasado y el presente para la inspiración, el aprendizaje y el disfrute de la sociedad.');

PROMPT Data inserted into MUSEOS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EST_FISICA (Estructura Física de los Museos)
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EST_FISICA table (Restored Detail)...

-- Estructura para Museum der bildenden Künste Leipzig (MdbK)
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'MdbK Hauptgebäude', 'EDIFICIO', 'Edificio principal y moderno del museo, forma cúbica de hormigón visto y vidrio.', 'Katharinenstraße 10, 04109 Leipzig', NULL); 
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Untergeschoss MdbK', 'PISO', 'Planta sótano con almacenes y talleres de restauración.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'MdbK Hauptgebäude' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Erdgeschoss (EG) MdbK', 'PISO', 'Planta baja con acceso principal, foyer, tienda, cafetería y salas para eventos.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'MdbK Hauptgebäude' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), '1. Obergeschoss (1.OG) MdbK', 'PISO', 'Primer piso dedicado a colecciones de Maestros Antiguos y exposiciones temporales.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'MdbK Hauptgebäude' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), '2. Obergeschoss (2.OG) MdbK', 'PISO', 'Segundo piso con colecciones de arte del siglo XIX y XX, y la colección Max Klinger.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'MdbK Hauptgebäude' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
-- Areas del Erdgeschoss MdbK
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Foyer & Kasse MdbK', 'AREA', 'Amplio vestíbulo principal con taquillas y punto de información central.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Erdgeschoss (EG) MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Museumsshop MdbK', 'AREA', 'Tienda del museo con catálogos, libros de arte, postales y recuerdos.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Erdgeschoss (EG) MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Cafeteria MdbK', 'AREA', 'Espacio de cafetería para visitantes.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Erdgeschoss (EG) MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
-- Areas del 1. Obergeschoss MdbK
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Galerías de Maestros Antiguos MdbK', 'AREA', 'Salas dedicadas a la pintura europea del s. XV al XVIII.', (SELECT id_est FROM EST_FISICA WHERE nombre = '1. Obergeschoss (1.OG) MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Area Exposiciones Temporales 1.OG MdbK', 'AREA', 'Espacio principal para exposiciones temporales en el primer piso.', (SELECT id_est FROM EST_FISICA WHERE nombre = '1. Obergeschoss (1.OG) MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
-- Areas del 2. Obergeschoss MdbK
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Galerías Arte Siglo XIX MdbK', 'AREA', 'Salas dedicadas al arte del siglo XIX, incluyendo el Romanticismo alemán.', (SELECT id_est FROM EST_FISICA WHERE nombre = '2. Obergeschoss (2.OG) MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sala Max Klinger MdbK', 'AREA', 'Espacio dedicado a la obra de Max Klinger.', (SELECT id_est FROM EST_FISICA WHERE nombre = '2. Obergeschoss (2.OG) MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

-- Estructura para Hamburger Kunsthalle
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Altbau Kunsthalle', 'EDIFICIO', 'Edificio histórico principal de ladrillo rojo, construido en 1869.', 'Glockengießerwall, 20095 Hamburg', NULL); 
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Galerie der Gegenwart', 'EDIFICIO', 'Edificio moderno de piedra caliza blanca para arte contemporáneo, inaugurado en 1997.', 'Glockengießerwall 5, 20095 Hamburg', NULL);
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Kuppelsaal', 'EDIFICIO', 'Edificio octogonal con cúpula que conecta el Altbau y la Galerie der Gegenwart.', 'Glockengießerwall, 20095 Hamburg', NULL);
-- Pisos del Altbau Kunsthalle
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Erdgeschoss Altbau KH', 'PISO', 'Planta baja del Altbau, alberga colecciones y el Hubertus-Wald-Forum.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Altbau Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), '1. Obergeschoss Altbau KH', 'PISO', 'Primer piso del Altbau, colecciones de arte del siglo XIX y biblioteca.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Altbau Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));
-- Areas del Erdgeschoss Altbau KH
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Hubertus-Wald-Forum KH', 'AREA', 'Gran sala para exposiciones especiales y eventos en el Altbau.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Erdgeschoss Altbau KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Kupferstichkabinett KH', 'AREA', 'Gabinete de grabados y dibujos, accesible para investigación.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Erdgeschoss Altbau KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));
-- Areas del 1. Obergeschoss Altbau KH
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Galerien 19. Jahrhundert KH', 'AREA', 'Salas dedicadas al arte del siglo XIX, incluyendo Románticos alemanes.', (SELECT id_est FROM EST_FISICA WHERE nombre = '1. Obergeschoss Altbau KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));
-- Pisos de la Galerie der Gegenwart
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Ebene 0 GdG KH', 'PISO', 'Nivel de acceso principal y exposiciones de la Galerie der Gegenwart.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galerie der Gegenwart' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));
-- Areas de la Ebene 0 GdG KH
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sammlung Zeitgenössische Kunst GdG KH', 'AREA', 'Exposición de la colección de arte contemporáneo (post 1960).', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Ebene 0 GdG KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, id_est_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Café Liebermann im GdG KH', 'AREA', 'Cafetería dentro de la Galerie der Gegenwart.', (SELECT id_est FROM EST_FISICA WHERE nombre = 'Ebene 0 GdG KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));


PROMPT Data inserted into EST_FISICA table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: ASIGNACIONES_MES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into ASIGNACIONES_MES table...

-- Asignaciones para MdbK Leipzig
INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-01', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Foyer & Kasse MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 10000001), 'MATUTINO');
INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-07-01', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galerías de Maestros Antiguos MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 10000002), 'MATUTINO');

-- Asignaciones para Hamburger Kunsthalle
INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-01', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Hubertus-Wald-Forum KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 10000003), 'VESPERTINO');
INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-07-01', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 10000004), 'NOCTURNO');

PROMPT Data inserted into ASIGNACIONES_MES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: SALAS_EXP
-- -----------------------------------------------------------------------------
PROMPT Inserting data into SALAS_EXP table...

-- Salas para MdbK Leipzig
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Galerías de Maestros Antiguos MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 
 'Sala Principal Maestros Antiguos', 'Colección permanente de pintura europea del s. XV al XVIII.');
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 
 'Sala Temporal A - 1.OG', 'Espacio para exposiciones temporales diversas.');
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Galerías Arte Siglo XIX MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 
 'Galería Romántica Alemana', 'Obras destacadas del Romanticismo alemán del siglo XIX.');

-- Salas para Hamburger Kunsthalle
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Hubertus-Wald-Forum KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 
 'Gran Salón Hubertus Wald', 'Principal espacio para exposiciones especiales y eventos.');
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Galerien 19. Jahrhundert KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 
 'Salas Caspar David Friedrich', 'Exhibición destacada de obras de C.D. Friedrich y contemporáneos.');
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 
 'Espacio Contemporáneo Nivel 0', 'Exhibición principal de la colección de arte posterior a 1960.');

PROMPT Data inserted into SALAS_EXP table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EXPOSICIONES_EVENTOS
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EXPOSICIONES_EVENTOS table...

-- Exposiciones/Eventos para MdbK Leipzig
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala Principal Maestros Antiguos' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galerías de Maestros Antiguos MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 'El Esplendor del Barroco Holandés', TO_DATE('2025-03-15', 'YYYY-MM-DD'), TO_DATE('2025-06-15', 'YYYY-MM-DD'), 12.00, NULL, NULL);
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala Temporal A - 1.OG' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 'Arte Abstracto de Leipzig: Nuevas Voces', TO_DATE('2025-07-01', 'YYYY-MM-DD'), TO_DATE('2025-09-30', 'YYYY-MM-DD'), 10.00, NULL, 'Hochschule für Grafik und Buchkunst Leipzig');

-- Exposiciones/Eventos para Hamburger Kunsthalle
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Gran Salón Hubertus Wald' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Hubertus-Wald-Forum KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 ' Vanguardias del Siglo XX: Una Retrospectiva', TO_DATE('2025-04-20', 'YYYY-MM-DD'), TO_DATE('2025-08-20', 'YYYY-MM-DD'), 18.00, NULL, NULL);
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Espacio Contemporáneo Nivel 0' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 'Instalaciones Inmersivas: Nuevos Medios', TO_DATE('2025-09-10', 'YYYY-MM-DD'), TO_DATE('2026-01-10', 'YYYY-MM-DD'), 15.00, NULL, NULL);

PROMPT Data inserted into EXPOSICIONES_EVENTOS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: CIERRES_TEMPORALES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into CIERRES_TEMPORALES table...

-- Cierre para MdbK Leipzig, Sala Temporal A - 1.OG (montaje nueva expo)
INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES
(TO_DATE('2025-06-20', 'YYYY-MM-DD'),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala Temporal A - 1.OG' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 TO_DATE('2025-06-30', 'YYYY-MM-DD'));

-- Cierre para Hamburger Kunsthalle, Gran Salón Hubertus Wald (mantenimiento)
INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES
(TO_DATE('2025-08-21', 'YYYY-MM-DD'),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Gran Salón Hubertus Wald' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Hubertus-Wald-Forum KH' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 TO_DATE('2025-08-25', 'YYYY-MM-DD'));

PROMPT Data inserted into CIERRES_TEMPORALES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: EST_ORGANIZACIONAL
-- Descripción: Define la estructura jerárquica y de unidades organizativas de los museos.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into EST_ORGANIZACIONAL table...

-- Estructura Organizacional para MdbK Leipzig (id_museo = 1)
-- NIVEL 1: DIRECCIÓN
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Dirección General MdbK', 'DIRECCION', 1, 'Unidad central que supervisa todas las demás áreas del museo. Jefatura: Dr. Stefan Weppelmann (Director), Dr. Jeannette Stoschek (Subdirectora).', NULL);

-- NIVEL 2: DEPARTAMENTOS
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'MdbK [in transit]', 'DEPARTAMENTO', 2, 'Programa especial bajo supervisión directa de la Dirección. Personal: Sithara Weeratunga, Olga Vostretsova (Agentes para la Diversidad).', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Colecciones MdbK', 'DEPARTAMENTO', 2, 'Gestión, estudio, conservación y desarrollo de las colecciones del museo. Jefatura: Dr. Jeannette Stoschek (Jefa de Colecciones y Colección Gráfica), Dr. Jan Nicolaisen (Jefe de Pintura y Escultura).', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Restauración MdbK', 'DEPARTAMENTO', 2, 'Conservación preventiva y curativa de las obras de arte. Jefatura: Theresa Anna Bräunig.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Biblioteca y Archivo de Artistas MdbK', 'DEPARTAMENTO', 2, 'Gestión de recursos bibliográficos y archivos documentales. Jefatura: Sebastian Stumpe.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Colecciones Externas MdbK', 'DEPARTAMENTO', 2, 'Gestión del Archivo EVELYN RICHTER & URSULA ARNOLD. Jefatura: Dr. Jeannette Stoschek.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Educación Artística MdbK', 'DEPARTAMENTO', 2, 'Programas educativos y de mediación cultural. Jefatura: Carolin Rothmund.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Relaciones Públicas, Marketing y Eventos MdbK', 'DEPARTAMENTO', 2, 'Comunicación externa, marketing y organización de eventos. Jefatura: Jörg Dittmer.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Recaudación de Fondos y Alquileres MdbK', 'DEPARTAMENTO', 2, 'Gestión de financiamiento externo y servicios de alquiler. Jefatura: Katrin Siegmeyer.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Administración MdbK', 'DEPARTAMENTO', 2, 'Gestión administrativa y financiera del museo. Jefatura: Anne-Kathrin Herrmann.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Seguridad y Gestión de Instalaciones MdbK', 'DEPARTAMENTO', 2, 'Seguridad del museo y mantenimiento de instalaciones. Jefatura: Torsten Cech.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

-- NIVEL 3: SECCIONES/UNIDADES dentro del Departamento de Colecciones
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Curaduría MdbK', 'SECCION', 3, 'Personal: Dr. Jenny Graser (Curadora Pintura y Escultura S. XX/XXI), Dr. Philipp Freytag (Curador Fotografía y Artes Mediales), Julia Beckmann, Anne Richter (Asistentes de Curaduría).', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Investigación de Procedencia MdbK', 'SECCION', 3, 'Personal: Dr. Ulrike Saß, Lina Frubrich.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Documentación y Digitalización MdbK', 'SECCION', 3, 'Personal: Susanne Petri (Asistente de Investigación).', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Registro y Gestión de Préstamos MdbK', 'SECCION', 3, 'Personal: Linda Wagner, Ulrike Milde.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Gestión de Colección Física MdbK', 'SECCION', 3, 'Personal: Marko Kloss, Uwe Wagner.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

-- NIVEL 3: SECCIONES/UNIDADES dentro del Departamento de Relaciones Públicas
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Prensa y Comunicación Online MdbK', 'SECCION', 3, 'Personal: Sonja Lucia Gatterwe, Ulrike Otto.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Relaciones Públicas, Marketing y Eventos MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Nuevos Medios MdbK', 'SECCION', 3, 'Personal: Dirk Kuntze.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Relaciones Públicas, Marketing y Eventos MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

-- NIVEL 3: SECCIONES/UNIDADES dentro del Departamento de Administración
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Tienda del Museo MdbK', 'SECCION', 3, 'Personal: Janet Schirmer, Tim Sachse.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Administración MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

-- NIVEL 3: SECCIONES/UNIDADES dentro del Departamento de Seguridad y Gestión de Instalaciones
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Mantenimiento de Instalaciones MdbK', 'SECCION', 3, 'Personal: Sven Hottenrott (Carpintero del Museo), Dennis Kuhn, Jens Wuttke (Servicios de Edificio).', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Seguridad y Gestión de Instalaciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

-- Estructura Organizacional para Hamburger Kunsthalle (id_museo = 2)
-- NIVEL 1: DIRECCIÓN (Management Board)
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Management Board Kunsthalle', 'DIRECCION', 1, 'Consejo de Dirección. Jefatura: Prof. Dr. Alexander Klar (Director), Dr. Helga Huskamp (Managing Director). Personal de Soporte a la Dirección: Asistentes de Dirección y del Consejo.', NULL);

-- NIVEL 2: DEPARTAMENTOS
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Colecciones y Exposiciones Kunsthalle', 'DEPARTAMENTO', 2, 'Departamento académico central organizado por áreas de colección. Jefes: Dr. Andreas Stolzenburg, Dr. Sandra Pisot, Dr. Markus Bertsch, Toby Kamps, Dr. Brigitte Kölle, Dr. Corinne Diserens, Dr. Annabelle Görgen-Lammers.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Educación Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Dr. Andrea Weniger.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Biblioteca, Archivo y Documentación Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Katharina Therese Gietkowski.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Conservación y Tecnología del Arte Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Silvia Castro (Conservación, Antiguos Maestros), Sabine Zorn (Conservación Papel y Fotografía). Especialidades: Antiguos Maestros, Siglo XIX, Arte Moderno.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Registro y Coordinación de Exposiciones Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Meike Wenck.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Marketing y Relaciones con el Cliente Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Dr. Jan Metzler.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Comunicación Digital Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Martina Gschwilm.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Prensa y Relaciones Públicas Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Mira Forte.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Patrocinios y Alianzas Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Gesa-Thorid Huget, Dr. Anna Punke-Dresen.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Gestión de Eventos y Coordinación de Programas Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Sina Fuhrmann.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Supervisión de Salas Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Hassan Daneschwar.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Edificio y Tecnología Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Ralf Suerbaum.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Recursos Humanos Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Marion Asmus.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Contraloría y Finanzas Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Kathrin von Gönner.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

-- NIVEL 3: SECCIONES
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de Investigación de Procedencia e Historia de la Colección Kunsthalle', 'SECCION', 3, 'Jefatura: Dr. Ute Haug.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de Proyecto de Digitalización Kunsthalle', 'SECCION', 3, 'Jefatura: Dr. David Klemm.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de Oficina de Colecciones Kunsthalle', 'SECCION', 3, 'Soporte administrativo. Jefatura: Ursula Trieloff.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de Registrars Kunsthalle', 'SECCION', 3, 'Personal especializado en registro de obras.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Registro y Coordinación de Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de Tecnología de Medios Kunsthalle', 'SECCION', 3, 'Soporte técnico audiovisual y multimedia.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Registro y Coordinación de Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de Manejo de Obras Kunsthalle', 'SECCION', 3, 'Jefatura: Jochen Möhle.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Registro y Coordinación de Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de TI y Administración de Sistemas Kunsthalle', 'SECCION', 3, 'Soporte técnico informático.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Edificio y Tecnología Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de Contabilidad Kunsthalle', 'SECCION', 3, 'Gestión contable específica.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Contraloría y Finanzas Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

PROMPT Data inserted into EST_ORGANIZACIONAL table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: COLECCIONES_PERMANENTES
-- Descripción: Define las colecciones permanentes de los museos, gestionadas por unidades organizativas.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into COLECCIONES_PERMANENTES table...

-- Colecciones para MdbK Leipzig
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 'Maestros Antiguos Europeos (MdbK)',
 'Pinturas y esculturas europeas del s. XV al XVIII, con énfasis en escuelas alemana, holandesa y flamenca.',
 'Renacimiento', 1);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 'Arte Alemán del Siglo XIX (MdbK)',
 'Obras del Romanticismo, Realismo e Impresionismo alemán, destacando C.D. Friedrich y M. Klinger.',
 'Romanticismo', 2);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 'Vanguardias del Siglo XX (MdbK)',
 'Selección de arte moderno alemán e internacional, incluyendo Expresionismo y Bauhaus.',
 'Vanguardia', 3);

-- Colecciones para Hamburger Kunsthalle
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 'Colección de Maestros Antiguos (Kunsthalle)',
 'Obras de maestros europeos desde el Medioevo hasta el s. XVIII (Rembrandt, Canaletto).',
 'Barroco', 1);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 'Arte del Siglo XIX (Kunsthalle)',
 'Pintura y escultura del s. XIX, con énfasis en Romanticismo alemán (C.D. Friedrich) e Impresionismo francés.',
 'Impresionismo', 2);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 'Galerie der Gegenwart (Colección Contemporánea)',
 'Obras de arte desde 1960 hasta la actualidad: Pop Art, Minimalismo, Arte Conceptual, videoarte.',
 'Contemporáneo', 3);

PROMPT Data inserted into COLECCIONES_PERMANENTES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: SALAS_COLECCIONES
-- Descripción: Vincula colecciones permanentes con las salas de exposición donde se muestran.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into SALAS_COLECCIONES table...

-- Vinculaciones para MdbK Leipzig
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Maestros Antiguos Europeos (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala Principal Maestros Antiguos' AND ef.nombre = 'Galerías de Maestros Antiguos MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías de Maestros Antiguos MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    1);

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    1);

-- Vinculaciones para Hamburger Kunsthalle
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Maestros Antiguos (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Gran Salón Hubertus Wald' AND ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    1);

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Salas Caspar David Friedrich' AND ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    1);

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Galerie der Gegenwart (Colección Contemporánea)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Espacio Contemporáneo Nivel 0' AND ef.nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND m.nombre = 'Hamburger Kunsthalle'),
    1);

PROMPT Data inserted into SALAS_COLECCIONES table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: HIST_EMPLEADOS
-- Descripción: Registra el historial de cargos de los empleados profesionales en las unidades organizativas.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into HIST_EMPLEADOS table...

-- Historial para MdbK Leipzig
-- Dr. Stefan Weppelmann - Director
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2021-01-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Dirección General MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000001),
 'DIRECTOR',
 NULL);

-- Dr. Jeannette Stoschek - Subdirectora y Jefa de Colecciones
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-06-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Dirección General MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000002),
 'ADMINISTRATIVO',
 TO_DATE('2018-12-31', 'YYYY-MM-DD'));

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-01-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000002),
 'CURADOR',
 NULL);

-- Dr. Jan Nicolaisen - Jefe de Pintura y Escultura
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-03-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000008),
 'CURADOR',
 NULL);

-- Dr. Jenny Graser - Curadora
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-09-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Sección de Curaduría MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000009),
 'CURADOR',
 NULL);

-- Dr. Philipp Freytag - Curador
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2020-02-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Sección de Curaduría MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000010),
 'CURADOR',
 NULL);

-- Theresa Anna Bräunig - Jefa de Restauración
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-08-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Restauración MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000020),
 'RESTAURADOR',
 NULL);

-- Carolin Rothmund - Jefa de Educación Artística
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2016-04-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Educación Artística MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000025),
 'ADMINISTRATIVO',
 NULL);

-- Historial para Hamburger Kunsthalle
-- Prof. Dr. Alexander Klar - Director
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-09-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Management Board Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000050),
 'DIRECTOR',
 NULL);

-- Dr. Helga Huskamp - Managing Director
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-04-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Management Board Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000051),
 'ADMINISTRATIVO',
 NULL);

-- Dr. Andreas Stolzenburg - Grabados y Dibujos
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2010-03-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000052),
 'CURADOR',
 NULL);

-- Dr. Sandra Pisot - Antiguos Maestros
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2012-09-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000053),
 'CURADOR',
 NULL);

-- Dr. Markus Bertsch - Siglo XIX
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2016-02-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000054),
 'CURADOR',
 NULL);

-- Toby Kamps - Colección Modernista
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-06-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000055),
 'CURADOR',
 NULL);

-- Dr. Brigitte Kölle - Arte Contemporáneo
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2011-11-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000056),
 'CURADOR',
 NULL);

-- Dr. Andrea Weniger - Educación
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2014-08-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Educación Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000062),
 'ADMINISTRATIVO',
 NULL);

PROMPT Data inserted into HIST_EMPLEADOS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: HIST_OBRAS_MOV
-- Descripción: Historial de movimiento y catalogación de obras en los museos.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into HIST_OBRAS_MOV table...

-- Movimientos para MdbK Leipzig
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Die Lebensstufen'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000003), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1840-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 1, 500000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Metropolis'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Vanguardias del Siglo XX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala Temporal A - 1.OG' AND ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000003), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1920-05-10', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 2, 1200000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Beethoven'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000003), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1902-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 10, 2500000.00);

-- Movimientos para Hamburger Kunsthalle
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Wanderer über dem Nebelmeer'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Salas Caspar David Friedrich' AND ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000054), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1970-03-10', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 1, 3000000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'La Petite Danseuse de Quatorze Ans'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Gran Salón Hubertus Wald' AND ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000053), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1955-11-20', 'YYYY-MM-DD'), 
    'DONADA POR MUSEO', 'SI', NULL, 5, 15000000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Hang-Up'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Galerie der Gegenwart (Colección Contemporánea)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Espacio Contemporáneo Nivel 0' AND ef.nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000056), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1975-09-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, 3, 800000.00);

PROMPT Data inserted into HIST_OBRAS_MOV table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: PROGRAMAS_MANT
-- Descripción: Define los programas de mantenimiento preventivo para las obras.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into PROGRAMAS_MANT table...

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Die Lebensstufen' AND m.nombre = 'Museum der bildenden Künste Leipzig' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Die Lebensstufen'),
    'Revisión de estado de conservación y condiciones ambientales de la pintura.',
    'Semestral',
    'CURADOR'
);

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Die Lebensstufen' AND m.nombre = 'Museum der bildenden Künste Leipzig' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Die Lebensstufen'),
    'Limpieza superficial de polvo y monitorización del barniz.',
    'Anual',
    'RESTAURADOR'
);

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Beethoven' AND m.nombre = 'Museum der bildenden Künste Leipzig' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Beethoven'),
    'Inspección detallada de materiales (mármol, bronce, piedras) y control de microclima.',
    'Anual',
    'RESTAURADOR'
);

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Wanderer über dem Nebelmeer' AND m.nombre = 'Hamburger Kunsthalle' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Wanderer über dem Nebelmeer'),
    'Control de condiciones de iluminación y humedad relativa para pintura sobre lienzo.',
    'Trimestral',
    'CURADOR'
);

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'La Petite Danseuse de Quatorze Ans' AND m.nombre = 'Hamburger Kunsthalle' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'La Petite Danseuse de Quatorze Ans'),
    'Verificación de estabilidad de materiales mixtos (bronce, tul, seda) y limpieza delicada.',
    'Semestral',
    'RESTAURADOR'
);

PROMPT Data inserted into PROGRAMAS_MANT table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: MANTENIMIENTOS_OBRAS_REALIZADOS
-- Descripción: Registra los mantenimientos efectivamente realizados sobre las obras.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into MANTENIMIENTOS_OBRAS_REALIZADOS table...

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Die Lebensstufen' AND pm.actividad LIKE 'Limpieza superficial%' AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museum der bildenden Künste Leipzig' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Die Lebensstufen' AND m.nombre = 'Museum der bildenden Künste Leipzig' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Die Lebensstufen'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000003), 
    TO_DATE('2025-01-15', 'YYYY-MM-DD'),
    TO_DATE('2025-01-16', 'YYYY-MM-DD'),
    'Limpieza superficial completada. Barniz estable.'
);

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Beethoven' AND pm.actividad LIKE 'Inspección detallada%' AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museum der bildenden Künste Leipzig' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Beethoven' AND m.nombre = 'Museum der bildenden Künste Leipzig' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Beethoven'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000003), 
    TO_DATE('2025-03-10', 'YYYY-MM-DD'),
    TO_DATE('2025-03-10', 'YYYY-MM-DD'),
    'Inspección anual realizada. Sin cambios significativos. Microclima estable.'
);

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Wanderer über dem Nebelmeer' AND pm.actividad LIKE 'Control de condiciones%' AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Hamburger Kunsthalle' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Wanderer über dem Nebelmeer' AND m.nombre = 'Hamburger Kunsthalle' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Wanderer über dem Nebelmeer'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000004), 
    TO_DATE('2025-04-01', 'YYYY-MM-DD'),
    NULL,
    'Revisión trimestral de luxómetro y termohigrómetro. Valores dentro de los rangos permitidos.'
);

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'La Petite Danseuse de Quatorze Ans' AND pm.actividad LIKE 'Verificación de estabilidad%' AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Hamburger Kunsthalle' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'La Petite Danseuse de Quatorze Ans' AND m.nombre = 'Hamburger Kunsthalle' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'La Petite Danseuse de Quatorze Ans'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000002), 
    TO_DATE('2025-05-20', 'YYYY-MM-DD'),
    TO_DATE('2025-05-21', 'YYYY-MM-DD'),
    'Verificación semestral de materiales. Tutú y lazo en buen estado. Leve limpieza de polvo en base.'
);

PROMPT Data inserted into MANTENIMIENTOS_OBRAS_REALIZADOS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: HORARIOS
-- Descripción: Horarios de apertura de los museos por día de la semana.
-- Día: 1 (Lunes) a 7 (Domingo).
-- -----------------------------------------------------------------------------
PROMPT Inserting data into HORARIOS table...

-- Horarios para MdbK Leipzig
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Martes
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 20:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Miércoles
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Jueves
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Viernes
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Sábado
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Domingo

-- Horarios para Hamburger Kunsthalle
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Martes
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Miércoles
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 21:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Jueves
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Viernes
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Sábado
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre) VALUES (7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), TO_DATE('01-01-2000 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), TO_DATE('01-01-2000 18:00:00', 'DD-MM-YYYY HH24:MI:SS')); -- Domingo

PROMPT Data inserted into HORARIOS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: TIPO_TICKETS
-- Descripción: Define los tipos de tickets y sus precios históricos y actuales.
-- PK: (fecha_inicio, id_museo, tipo)
-- NOTA: Esta tabla debe poblarse ANTES que TICKETS para que el trigger funcione correctamente.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into TIPO_TICKETS table...

-- Tipos de Tickets para MdbK Leipzig
-- Precios antiguos (hasta 31-DIC-2023)
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2023-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 10.00, 'ADULTO', TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2023-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 6.00, 'ESTUDIANTE', TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2023-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 0.00, 'INFANTIL', TO_DATE('2023-12-31', 'YYYY-MM-DD'));

-- Precios actuales (desde 01-ENE-2024)
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 12.00, 'ADULTO', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 7.00, 'ESTUDIANTE', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 0.00, 'INFANTIL', NULL);

-- Tipos de Tickets para Hamburger Kunsthalle
-- Precios actuales (desde 01-ENE-2024)
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 16.00, 'ADULTO', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 8.00, 'ESTUDIANTE', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 0.00, 'INFANTIL', NULL);

PROMPT Data inserted into TIPO_TICKETS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: TICKETS
-- Descripción: Registra los tickets emitidos.
-- id_num_ticket se genera automáticamente por trigger.
-- precio se asigna automáticamente desde TIPO_TICKETS por trigger.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into TICKETS table...

-- Tickets para MdbK Leipzig
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    NULL,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    TO_DATE('2025-06-04 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    'ADULTO',
    12.00
);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    NULL,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    TO_DATE('2025-06-04 10:32:15', 'YYYY-MM-DD HH24:MI:SS'),
    'ESTUDIANTE',
    7.00
);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    NULL,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    TO_DATE('2025-06-05 14:05:30', 'YYYY-MM-DD HH24:MI:SS'),
    'INFANTIL',
    0.00
);

-- Tickets para Hamburger Kunsthalle
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    NULL,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    TO_DATE('2025-06-04 11:15:45', 'YYYY-MM-DD HH24:MI:SS'),
    'ADULTO',
    16.00
);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    NULL,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    TO_DATE('2025-06-04 11:17:00', 'YYYY-MM-DD HH24:MI:SS'),
    'ADULTO',
    16.00
);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    NULL,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    TO_DATE('2025-06-05 16:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    'ESTUDIANTE',
    8.00
);

PROMPT Data inserted into TICKETS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: HIST_MUSEOS
-- Descripción: Registra hechos históricos importantes de los museos.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into HIST_MUSEOS table...

-- Hechos para MdbK Leipzig
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES (
    1848, 
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 
    'Apertura del "Städtische Museum" (Museo Municipal), precursor directo del MdbK, el 10 de diciembre.'
);
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES (
    1943, 
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 
    'Destrucción del edificio del museo en Augustusplatz durante un bombardeo en la Segunda Guerra Mundial.'
);
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES (
    2004, 
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 
    'Inauguración del nuevo y actual edificio del museo en Katharinenstraße, diseñado por Hufnagel Pütz Rafaelian.'
);

-- Hechos para Hamburger Kunsthalle
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES (
    1869, 
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 
    'Inauguración del edificio principal (Altbau), diseñado por Georg Theodor Schirrmacher y Hermann von der Hude.'
);
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES (
    1919, 
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 
    'Ampliación con la construcción de la "Kuppelsaal" (Sala de la Cúpula) por Fritz Schumacher.'
);
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho) VALUES (
    1997, 
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 
    'Apertura de la "Galerie der Gegenwart", diseñada por Oswald Mathias Ungers, para el arte contemporáneo.'
);

PROMPT Data inserted into HIST_MUSEOS table.
PROMPT -----------------------------------------------------------------------------

-- COMMIT; -- Descomentar al final del script para guardar todos los cambios.
SET DEFINE ON;

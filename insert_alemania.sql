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

INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000001, 'Dr. Stefan', 'Baumann', TO_DATE('1970-05-12', 'YYYY-MM-DD'), 491701234567, 'Karl', NULL); -- Director MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000002, 'Prof. Eva', 'Keller', TO_DATE('1965-11-20', 'YYYY-MM-DD'), 491712345678, NULL, 'Weiss'); -- Directora Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000003, 'Markus', 'Schneider', TO_DATE('1982-02-28', 'YYYY-MM-DD'), 491723456789, 'Jürgen', NULL); -- Curador MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000004, 'Isabelle', 'Vogel', TO_DATE('1978-09-03', 'YYYY-MM-DD'), 491734567890, 'Marie', 'Lang'); -- Curadora Kunsthalle

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

-- Empleado Profesional: Dr. Stefan Baumann (doc_identidad: 20000001)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
-- Empleado Profesional: Prof. Eva Keller (doc_identidad: 20000002)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Francés'));
-- Empleado Profesional: Markus Schneider (doc_identidad: 20000003)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000003), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000003), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
-- Empleado Profesional: Isabelle Vogel (doc_identidad: 20000004)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000004), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000004), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000004), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Francés'));

PROMPT Data inserted into EMPLEADOS_IDIOMAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: FORMACIONES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into FORMACIONES table...

-- Formaciones para Empleado: Dr. Stefan Baumann (doc_identidad: 20000001)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), 'Doctorado en Historia del Arte', 2005, 'Tesis sobre el Romanticismo Alemán, Universidad de Heidelberg.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), 'Máster en Museología', 2001, 'Especialización en Curaduría de Arte Moderno, U. Libre de Berlín.');
-- Formaciones para Empleado: Prof. Eva Keller (doc_identidad: 20000002)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), 'Cátedra en Conservación de Arte', 2010, 'Investigación en técnicas de restauración, Acad. Bellas Artes Múnich.');
-- Formaciones para Empleado: Markus Schneider (doc_identidad: 20000003)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000003), 'Máster en Gestión Cultural', 2012, 'Proyectos culturales y administración de museos, U. de Leipzig.');
-- Formaciones para Empleado: Isabelle Vogel (doc_identidad: 20000004)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000004), 'Doctorado en Arte Contemporáneo', 2008, 'Estudio sobre arte post-minimalista, U. de Hamburgo.');

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
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Dirección General MdbK', 'DIRECCION', 1, 'Responsable máximo de la gestión estratégica, financiera y operativa del museo.', NULL);

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Curaduría y Colecciones MdbK', 'DEPARTAMENTO', 2, 'Gestión, estudio, conservación y desarrollo de las colecciones del museo.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Administración MdbK', 'DEPARTAMENTO', 2, 'Gestión de recursos financieros y administrativos.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

-- Estructura Organizacional para Hamburger Kunsthalle (id_museo = 2)
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Dirección Artística Kunsthalle', 'DIRECCION', 1, 'Liderazgo curatorial, desarrollo de exposiciones y estrategia artística de la institución.', NULL);

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Curaduría de Arte Antiguo Kunsthalle', 'DEPARTAMENTO', 2, 'Investigación y curaduría de las colecciones de arte hasta el siglo XVIII.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección Artística Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Educación y Programas Públicos Kunsthalle', 'DEPARTAMENTO', 2, 'Desarrollo e implementación de programas educativos y de divulgación para diversos públicos.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección Artística Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

PROMPT Data inserted into EST_ORGANIZACIONAL table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: COLECCIONES_PERMANENTES
-- Descripción: Define las colecciones permanentes de los museos, gestionadas por unidades organizativas.
-- -----------------------------------------------------------------------------
PROMPT Inserting data into COLECCIONES_PERMANENTES table...

-- Colecciones para MdbK Leipzig
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Curaduría y Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 'Maestros Antiguos Europeos (MdbK)',
 'Pinturas y esculturas europeas del s. XV al XVIII, con énfasis en escuelas alemana, holandesa y flamenca.',
 'Renacimiento', 1);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Curaduría y Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 'Arte Alemán del Siglo XIX (MdbK)',
 'Obras del Romanticismo, Realismo e Impresionismo alemán, destacando C.D. Friedrich y M. Klinger.',
 'Romanticismo', 2);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Curaduría y Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 'Vanguardias del Siglo XX (MdbK)',
 'Selección de arte moderno alemán e internacional, incluyendo Expresionismo y Bauhaus.',
 'Vanguardia', 3);

-- Colecciones para Hamburger Kunsthalle
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Curaduría de Arte Antiguo Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 'Colección de Maestros Antiguos (Kunsthalle)',
 'Obras de maestros europeos desde el Medioevo hasta el s. XVIII (Rembrandt, Canaletto).',
 'Barroco', 1);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección Artística Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 'Arte del Siglo XIX (Kunsthalle)',
 'Pintura y escultura del s. XIX, con énfasis en Romanticismo alemán (C.D. Friedrich) e Impresionismo francés.',
 'Impresionismo', 2);

INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección Artística Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
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
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala Principal Maestros Antiguos' AND ef.nombre = 'Galerías de Maestros Antiguos MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías de Maestros Antiguos MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    1);

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'),
    1);

-- Vinculaciones para Hamburger Kunsthalle
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Maestros Antiguos (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Curaduría de Arte Antiguo Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Gran Salón Hubertus Wald' AND ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    1);

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Dirección Artística Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Salas Caspar David Friedrich' AND ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    1);

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Galerie der Gegenwart (Colección Contemporánea)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Dirección Artística Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
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
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-01-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Dirección General MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000001),
 'DIRECTOR',
 NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-01-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000001),
 'CURADOR',
 TO_DATE('2017-12-31', 'YYYY-MM-DD'));

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2020-06-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones MdbK' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000003),
 'CURADOR',
 NULL);

-- Historial para Hamburger Kunsthalle
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-03-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Dirección Artística Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000002),
 'DIRECTOR',
 NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2021-01-15', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Educación y Programas Públicos Kunsthalle' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000004),
 'CURADOR', 
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
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1840-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 1, 500000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Metropolis'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Vanguardias del Siglo XX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala Temporal A - 1.OG' AND ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000003), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1920-05-10', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 2, 1200000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Beethoven'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000003), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1902-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 10, 2500000.00);

-- Movimientos para Hamburger Kunsthalle
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Wanderer über dem Nebelmeer'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Salas Caspar David Friedrich' AND ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000004), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Dirección Artística Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1970-03-10', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 1, 3000000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'La Petite Danseuse de Quatorze Ans'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Gran Salón Hubertus Wald' AND ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000004), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Dirección Artística Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1955-11-20', 'YYYY-MM-DD'), 
    'DONADA POR MUSEO', 'SI', NULL, 5, 15000000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Hang-Up'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Galerie der Gegenwart (Colección Contemporánea)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Espacio Contemporáneo Nivel 0' AND ef.nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000004), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Dirección Artística Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
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
INSERT INTO TICKETS (id_museo, fecha_hora_emision, tipo, precio) VALUES (
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    TO_DATE('2025-06-04 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    'ADULTO',
    12.00
);
INSERT INTO TICKETS (id_museo, fecha_hora_emision, tipo, precio) VALUES (
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    TO_DATE('2025-06-04 10:32:15', 'YYYY-MM-DD HH24:MI:SS'),
    'ESTUDIANTE',
    7.00
);
INSERT INTO TICKETS (id_museo, fecha_hora_emision, tipo, precio) VALUES (
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    TO_DATE('2025-06-05 14:05:30', 'YYYY-MM-DD HH24:MI:SS'),
    'INFANTIL',
    0.00
);

-- Tickets para Hamburger Kunsthalle
INSERT INTO TICKETS (id_museo, fecha_hora_emision, tipo, precio) VALUES (
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    TO_DATE('2025-06-04 11:15:45', 'YYYY-MM-DD HH24:MI:SS'),
    'ADULTO',
    16.00
);
INSERT INTO TICKETS (id_museo, fecha_hora_emision, tipo, precio) VALUES (
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    TO_DATE('2025-06-04 11:17:00', 'YYYY-MM-DD HH24:MI:SS'),
    'ADULTO',
    16.00
);
INSERT INTO TICKETS (id_museo, fecha_hora_emision, tipo, precio) VALUES (
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

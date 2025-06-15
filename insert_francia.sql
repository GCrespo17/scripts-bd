-------------------------------------------------------------------------------------
-- INSERTS PARA MUSEOS: Museé Jacquemart André Y Museé du Petit Palais
-------------------------------------------------------------------------------------

-- ---------------------------------------------------------------
-- Tabla: LUGARES
-- ---------------------------------------------------------------

INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Francia', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Paris', 'CIUDAD', (SELECT id_lugar FROM LUGARES WHERE nombre='Francia' AND tipo='PAIS'), NULL);
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Países Bajos', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Italia', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Grecia', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Alemania', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Bélgica', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Estados Unidos', 'PAIS', NULL, 'AMERICA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Noruega', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Suiza', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('España', 'PAIS', NULL, 'EUROPA');



-- ---------------------------------------------------------------
-- Tabla: OBRAS
-- ---------------------------------------------------------------

-- OBRAS MUSEO JACQUEMARTE ANDRE (16)
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Portrait of Comte Antoine Français de Nantes', TO_DATE('1811-01-01', 'YYYY-MM-DD'), 'PINTURA',  '114cm x 75cm', 'Óleo sobre tabla de madera', 'Neoclasicismo francés. Pertenece al género del retrato, mostrando la semejanza y el estatus del personaje a través de su vestimenta oficial y la composición.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Ruined Gallery', TO_DATE('1785-01-01', 'YYYY-MM-DD'), 'PINTURA', '139cm x 93cm', 'Óleo sobre lienzo. Emplea pinceladas que capturan la luz y el ambiente, creando texturas detalladas. La técnica busca realismo', 'Romanticismo y Neoclasicismo. Es un paisaje que combina la representación de ruinas clásicas, evocando la nostalgia y la grandeza pasada, con elementos de la naturaleza, un género común en el siglo XVIII');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Virgin and Child on a Throne', TO_DATE('1510-01-01', 'YYYY-MM-DD'), 'PINTURA', '131cm x 103cm', 'Óleo sobre tabla de madera. Destaca por su meticuloso detalle en figuras y ropajes. La técnica de temple permitía colores vibrantes y una superficie lisa, característica del arte renacentista italiano', 'Es una obra del Renacimiento italiano (siglo XV), un tema religioso del género devocional. Representa la iconografía tradicional de la Virgen con el Niño entronizados, buscando la idealización y la armonía');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('The New Model', TO_DATE('1770-01-01', 'YYYY-MM-DD'), 'PINTURA', '50cm x 63cm', 'Óleo sobre tabla de madera. La obra muestra un manejo magistral del color y la luz, con pinceladas sueltas y vibrantes que construyen la forma y el volumen, típicas del impresionismo o post-impresionismo', 'Es una obra que transita entre el Impresionismo y el Post-impresionismo. Pertenece al género del retrato o figura, capturando un momento íntimo y la espontaneidad de la pose');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Imaginary Portico', TO_DATE('1760-01-01', 'YYYY-MM-DD'), 'PINTURA', '53cm x 39cm', 'Tinta aguada sobre papel. La técnica se enfoca en la representación detallada de la arquitectura y el manejo de la perspectiva para crear profundidad, con un uso distintivo de la luz y la sombra para definir volúmenes y texturas', 'Es una obra del Neoclasicismo o Romanticismo temprano. Pertenece al género de paisaje arquitectónico o capricho, mostrando una composición imaginaria de ruinas clásicas, evocando la grandeza antigua');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('La fuite en Egypte', TO_DATE('1510-01-01', 'YYYY-MM-DD'), 'PINTURA', '151cm x 89cm', 'Óleo sobre lienzo. Representa la huida a Egipto, mostrando a María de pie con el niño. La técnica resalta la escena bíblica.', 'Renacimiento. Es una pintura religiosa que aborda un episodio bíblico con un estilo que se enfoca en la narrativa y la composición, característico del Renacimiento italiano.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Les Pèlerins d''Emmaüs', TO_DATE('1628-01-01', 'YYYY-MM-DD'), 'PINTURA', '39cm x 42cm', 'Óleo sobre panel de madera. Destaca por el uso del claroscuro y el contra-luz para revelar la naturaleza divina de Cristo, creando un efecto dramático y misterioso.', 'Barroco holandés. Pintura religiosa que aborda el tema de la aparición de Cristo en Emaús, con una composición simple pero profunda, característica del estilo de Rembrandt.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Les Attributs des Sciences et des Arts', TO_DATE('1731-01-01', 'YYYY-MM-DD'), 'PINTURA', '140cm x 220cm', 'Óleo sobre lienzo. Composición con objetos que simbolizan las ciencias (mapas, libros) y las artes (busto, paleta), con un manejo de la luz y la textura que da vida a los objetos.', 'Rococó. Bodegón o naturaleza muerta con elementos alegóricos. Chardin, conocido por su maestría en la representación de objetos cotidianos, crea una atmósfera que celebra el conocimiento y la creatividad.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Saint Georges terrassant le dragon', TO_DATE('1430-01-01', 'YYYY-MM-DD'), 'PINTURA', '131cm x 103cm', 'Pintura al temple sobre panel de madera. Obra icónica que combina elementos tradicionales con una innovadora aplicación de la perspectiva, dividiendo el paisaje en dos con diferentes puntos de fuga.', 'Renacimiento temprano. Tema religioso que representa a San Jorge matando al dragón, donde Uccello explora la dualidad entre la tradición gótica y las nuevas ideas de la perspectiva renacentista.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Ecce Homo', TO_DATE('1500-01-01', 'YYYY-MM-DD'), 'PINTURA', '54cm x 42cm', 'Temple y oro sobre lienzo tendido sobre panel. Destaca por su encuadre cercano y la intensidad dramática, con un dibujo de los rostros que llega a la caricatura para expresar la rabia y el deseo de matar.', 'Renacimiento. Pintura religiosa. Mantegna aborda el tema del Cristo sufriente con una originalidad y una fuerza emocional que lo distinguen. La obra explora la intensidad psicológica de los personajes.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Portrait d''homme', TO_DATE('1620-01-01', 'YYYY-MM-DD'), 'PINTURA', '117cm x 98cm', 'Óleo sobre lienzo. La composición presenta una columna y una cortina roja que, junto con el hábito negro del hombre, contrastan con el fondo, mostrando la influencia de Tiziano y el estilo barroco flamenco del artista.', 'Barroco flamenco. Es un retrato que combina la tradición flamenca con influencias italianas. La obra destaca por la maestría de Van Dyck en la representación de la nobleza y la psicología del retratado, un género en el que fue un experto.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Portrait de Françoise-Renée de Carbonnel de Canisy, marquise d''Antin', TO_DATE('1738-01-01', 'YYYY-MM-DD'), 'PINTURA', '118cm x 97cm', 'Óleo sobre lienzo. Representa a la marquesa al pie de un roble. Nattier juega con los efectos de las telas y sedas, y un paisaje preciso de fondo con el cielo reflejado en el río, mostrando su habilidad en la composición y el uso del color.', 'Rococó. Es un retrato de corte que combina majestad con la gracia y ligereza propias del Rococó. Nattier fue apreciado por su capacidad para infundir suavidad y elegancia en el género, siendo un favorito de la realeza y la nobleza.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Buste de Grégoire XV', TO_DATE('1622-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '78cm x 66cm', 'Bronce. Impresiona por la calidad de sus acabados. El escultor utilizó el taladro para crear luz, sombra y profundidad. Este busto de bronce es una réplica del original en mármol.', 'Barroco italiano. Retrato de la figura papal, mostrando la dignidad y la resolución. Bernini, considerado el mayor artista de su tiempo, captura la expresividad y el movimiento característicos del Barroco.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Le Martyre de Saint Sébastien', TO_DATE('1460-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '26cm x 24cm', 'Bronce. Pequeño bajorrelieve que destaca por su excepcional trabajo en la perspectiva y su atmósfera dramática, rememorando el estilo de los bajorrelieves antiguos.', 'Renacimiento italiano. Obra religiosa que retrata el martirio de San Sebastián con un realismo y emotividad propios del Renacimiento, mostrando la maestría de Donatello en la representación del cuerpo humano.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Buste de l''architecte Jacques V Gabriel', TO_DATE('1711-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '88cm x 65cm', 'Marbre. Antoine Coysevox, maestro en la escultura francesa, insufla alma y vida a sus modelos. Trabajo virtuoso en la perruque que aporta carácter y autoridad al busto.', 'Escultura francesa. Retrato psicológico de finales del reinado de Luis XIV, mostrando la maestría del artista en capturar la esencia de sus sujetos.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Buste d''Antoine-Louis François Le Fèvre de Caumartin', TO_DATE('1779-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '57cm x 54cm', 'Marbre. Jean-Antoine Houdon trata el rostro con un realismo notable, priorizando la semejanza. La boca abierta y la sonrisa confieren un carácter afable al personaje.', 'Escultura francesa del siglo XVIII. Un retrato que ejemplifica la habilidad de Houdon para fusionar la simplicidad con la elegancia aristocrática del período.');
--MUSEO PETIT PALAIS (12)
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Ugolino', TO_DATE('1872-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '195cm altura x 150cm ancho x 110cm largo', 'Mármol. La técnica escultórica destaca por el detalle anatómico y la expresión dramática, creando un fuerte sentido de movimiento y sufrimiento. La superficie pulida contrasta con las arrugas y el dolor de las figuras', 'Es una obra del Romanticismo francés, específicamente una escultura del género de la figura histórica/mitológica. Representa el tormento y la desesperación de Ugolino, un tema oscuro y emotivo.');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Ephebe from the Fins d''Annecy', TO_DATE('-0030-01-01', 'SYYYY-MM-DD'), 'ESCULTURA', '62cm altura', 'Bronce. La escultura muestra un pulido detallado y una atención a la anatomía idealizada. La técnica busca la fluidez de las formas y la elegancia clásica, típica de las réplicas o interpretaciones de la estatuaria antigua', 'Es una obra de estilo Greco-Romano o Neoclásico, perteneciente al género de la figura mitológica o idealizada. Representa un joven atlético, simbolizando la belleza y la perfección física de la Antigüedad');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('White ground hydria', TO_DATE('-0525-01-01', 'SYYYY-MM-DD'), 'ESCULTURA', '24,3cm x 18cm', 'Cerámica de figuras rojas con fondo blanco. Destaca la técnica de fondo blanco sobre la que se pintan figuras con gran detalle lineal, a menudo con pigmentos adicionales, creando un efecto más delicado y pictórico', 'Es un ejemplo de arte griego clásico, específicamente de la cerámica ática (siglo V a.C.). Pertenece al género de la cerámica utilitaria y narrativa, con representaciones de escenas mitológicas o de la vida cotidiana');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Knight, Death and the Devil (Bartsch 98)', TO_DATE('1513-01-01', 'YYYY-MM-DD'), 'PINTURA', '24,6cm x 19cm', 'Grabado calcográfico (buril). La técnica destaca por su precisión extrema en líneas y detalles, creando texturas, volumen y profundidad complejos. El contraste blanco y negro es fundamental para la atmósfera', 'Es una obra cumbre del Renacimiento alemán (Norte). Pertenece al género de la alegoría o grabado moralizante, representando la virtud y la fe frente a las tentaciones y peligros de la vida');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Le Nouvelin de Vénerie', TO_DATE('1387-01-01', 'YYYY-MM-DD'), 'PINTURA', '32,5cm altura x 25cm ancho x 4,5cm largo', 'Óleo sobre lienzo. La técnica se caracteriza por un dibujo preciso y un color vibrante. Los detalles de la ropa y el paisaje se representan con cuidado, mostrando una ejecución académica y narrativa', 'Es una obra del siglo XIX, probablemente Academicismo o Romanticismo. Pertenece al género de la pintura de historia o escena de género, representando una escena narrativa de caza o de la vida cortesana');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('The Carcass or On the Sabbath Road', TO_DATE('1527-01-01', 'YYYY-MM-DD'), 'PINTURA', '30cm x 54,5cm', 'Grabado calcográfico (aguafuerte). La técnica utiliza líneas incisas en metal para crear texturas sombrías y un alto contraste. Destaca por su crudeza y expresividad en el trazo, reflejando una visión oscura', 'Es una obra del Romanticismo español, específicamente de la serie "Los Caprichos". Pertenece al género de la sátira social y política y la crítica alegórica, con una representación fantasmagórica y grotesca');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('A Jaunt by Carriage', TO_DATE('1750-01-01', 'YYYY-MM-DD'), 'PINTURA', '50,5cm x 63cm', 'Óleo sobre lienzo. La técnica se caracteriza por un manejo vibrante de la luz y el color, con pinceladas que capturan la atmósfera y el movimiento. Refleja la experimentación con la luz y la atmósfera', 'Es una obra del Impresionismo o Post-impresionismo. Pertenece al género de la escena de género o vida moderna, representando un momento cotidiano y de ocio de la sociedad parisina del siglo XIX');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Jérôme de La Lande', TO_DATE('1769-01-01', 'YYYY-MM-DD'), 'PINTURA', '72cm x 59,5cm', 'Óleo sobre lienzo. La técnica se caracteriza por un dibujo preciso y un modelado suave de las formas, con especial atención a la captura de la expresión facial y la personalidad del retratado', 'Es una obra del Neoclasicismo o transición al Romanticismo. Pertenece al género del retrato, mostrando una figura intelectual con dignidad y seriedad, un género común en la época de la Ilustración');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('A Parisian Woman', TO_DATE('1876-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '147cm altura x 55cm ancho x 62cm largo', 'Óleo sobre lienzo. La técnica se enfoca en capturar la elegancia de la figura, con pinceladas que definen los detalles del vestuario y el rostro, y un manejo de la luz para realzar las texturas', 'Es una obra del siglo XIX, probablemente Academicismo o Realismo/Naturalismo. Pertenece al género del retrato o escena de género, representando la moda y la figura femenina parisina de la época');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Combat of the Giaour and the Pasha', TO_DATE('1835-01-01', 'YYYY-MM-DD'), 'PINTURA', '73cm x 61cm', 'Óleo sobre lienzo. La técnica se caracteriza por un dinamismo vibrante, pinceladas enérgicas y un uso intenso del color para transmitir emoción y movimiento en la escena de combate', 'Es una obra cumbre del Romanticismo francés. Pertenece al género de la pintura de historia o escena orientalista, representando un enfrentamiento dramático y exótico inspirado en la literatura');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Dante', TO_DATE('1879-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '195cm altura x 60cm ancho x 60cm largo', 'Óleo sobre lienzo. La técnica se caracteriza por un dibujo preciso y un modelado expresivo del rostro, con pinceladas que construyen la forma y la intensidad psicológica del personaje', 'Es una obra del Romanticismo francés, un retrato o figura alegórica. Representa al célebre poeta Dante Alighieri, evocando su genio y su tormento, típico de la fascinación romántica por las figuras históricas');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES
    ('Cascade Pendant', TO_DATE('1900-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '12cm x 5cm', 'Oro, esmalte, diamantes, perlas. La técnica combina la orfebrería detallada, el esmaltado para colores vibrantes y la engarce de gemas para crear un efecto lujoso y fluido, característico del Art Nouveau', 'Es una joya del Art Nouveau. Pertenece al género de la joyería decorativa y simbólica, inspirada en formas orgánicas y motivos naturales, buscando la elegancia y la fluidez propias de este movimiento');


-- ---------------------------------------------------------------
-- Tabla: IDIOMAS
-- ---------------------------------------------------------------
INSERT INTO IDIOMAS (nombre) VALUES ('Coreano');
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


-- ---------------------------------------------------------------
-- Tabla: EMPLEADOS
-- ---------------------------------------------------------------

-- EMPLEADOS PARA JACQUEMARTE-ANDRE
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Jean', 'Dubois', 1001, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Marie', 'Lefevre', 1002, 'MANTENIMIENTO');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Pierre', 'Bernard', 1003, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Sophie', 'Thomas', 1004, 'MANTENIMIENTO');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Michel', 'Petit', 1005, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Nathalie', 'Robert', 1006, 'MANTENIMIENTO');
--EMPLEADOS PARA PETIT PALAIS
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Christophe', 'Richard', 1007, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Isabelle', 'Durand', 1008, 'MANTENIMIENTO');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Marc', 'Leroy', 1009, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Valerie', 'Moreau', 1010, 'MANTENIMIENTO');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Antoine', 'Martin', 1011, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT(nombre, apellido, doc_identidad, tipo_responsable) VALUES
    ('Émilie', 'Garnier', 1012, 'MANTENIMIENTO');

-- ---------------------------------------------------------------
-- Tabla: EMPLEADOS PROFESIONALES
-- ---------------------------------------------------------------
-- MUSEO JACQUEMARTE-ANDRE
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2001, 'Sophie', 'Dubois', TO_DATE('1985-03-15', 'YYYY-MM-DD'), '0612345678', 'Claire', NULL); --Curador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2002, 'Lucas', 'Martin', TO_DATE('1990-07-22', 'YYYY-MM-DD'), '0798765432', NULL, 'Garcia'); --Curador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2003, 'Chloé', 'Bernard', TO_DATE('1982-11-01', 'YYYY-MM-DD'), '0145678901', 'Anne', NULL); --Restaurador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2004, 'Antoine', 'Petit', TO_DATE('1978-01-28', 'YYYY-MM-DD'), '0623456789', NULL, NULL); -- Administrativo
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2005, 'Manon', 'Durand', TO_DATE('1993-05-10', 'YYYY-MM-DD'), '0787654321', 'Marie', 'Lefevre'); --Curador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2006, 'Arthur', 'Leroy', TO_DATE('1980-09-03', 'YYYY-MM-DD'), '0234567890', NULL, 'Moreau'); --Restaurador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2007, 'Emma', 'Roux', TO_DATE('1995-02-18', 'YYYY-MM-DD'), '0634567890', 'Louise', NULL); --Restaurador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2008, 'Gabriel', 'Thomas', TO_DATE('1988-06-25', 'YYYY-MM-DD'), '0765432109', NULL, NULL); --Administrativo
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2009, 'Juliette', 'Garcia', TO_DATE('1991-12-05', 'YYYY-MM-DD'), '0312345678', 'Amélie', 'Dupont'); --Administrativo
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2010, 'Louis', 'Moreau', TO_DATE('1975-04-12', 'YYYY-MM-DD'), '0678901234', NULL, 'Laurent'); --Director
-- MUSEO PETIT PAIAL
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2011, 'Léa', 'Laurent', TO_DATE('1994-08-08', 'YYYY-MM-DD'), '0710987654', 'Charlotte', NULL); --Administrativo
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2012, 'Paul', 'Simon', TO_DATE('1983-10-20', 'YYYY-MM-DD'), '0456789012', NULL, NULL); --Curador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2013, 'Alice', 'Michel', TO_DATE('1992-01-30', 'YYYY-MM-DD'), '0645678901', 'Justine', 'Blanc'); --Curador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2014, 'Hugo', 'Dupont', TO_DATE('1987-07-07', 'YYYY-MM-DD'), '0734567890', NULL, 'Dubois'); --Restaurador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2015, 'Margaux', 'Robin', TO_DATE('1996-04-21', 'YYYY-MM-DD'), '0512345678', 'Marie', NULL); --Restaurador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2016, 'Nathan', 'Bertrand', TO_DATE('1989-11-11', 'YYYY-MM-DD'), '0656789012', NULL, NULL); --Administrativo
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2017, 'Lise', 'Roussel', TO_DATE('1998-03-01', 'YYYY-MM-DD'), '0743210987', 'Jeanne', 'Martin'); --Administrativo
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2018, 'Tom', 'Lefevre', TO_DATE('1981-09-19', 'YYYY-MM-DD'), '0123456789', NULL, 'Petit'); --Director
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2019, 'Clara', 'Fournier', TO_DATE('1990-06-06', 'YYYY-MM-DD'), '0678901234', 'Louise', NULL); --Curador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES
    (2020, 'Alexandre', 'Vincent', TO_DATE('1984-02-14', 'YYYY-MM-DD'), '0754321098', NULL, 'Dubois'); --Curador


-- ---------------------------------------------------------------
-- Tabla: ARTISTAS
-- ---------------------------------------------------------------
-- ARTISTAS PARA LAS OBRAS DE PETIT PALAI
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo dramático y vibrante, fusionando realismo y expresividad barroca. Captura movimiento y emoción con vitalidad, creando figuras humanas dinámicas y pasionales. Clave en la transición del Romanticismo al Realismo escultórico, con obras llenas de alma.', 'Jean', 'Baptiste', 'Carpeaux', NULL, TO_DATE('1827-05-11', 'YYYY-MM-DD'), TO_DATE('1875-10-12', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo Art Nouveau y Art Decó distintivo. Se caracterizaba por usar motivos naturales, esmaltes vítreos translúcidos e incrustaciones de marfil o nácar. Experimentaba con líneas asimétricas fluidas y, más tarde, con la geometría audaz y el contraste de colores de Art Decó.', 'Georges', NULL, 'Fouquet', NULL, TO_DATE('1862-01-01', 'YYYY-MM-DD'), TO_DATE('1957-12-31', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo realista con tendencia al academicismo. Se caracterizaba por retratos emotivos y monumentos públicos, usando bronce y mármol. Su habilidad destacaba en capturar la psicología del sujeto y el dramatismo narrativo.', 'Jean', 'Paul', 'Aubé', NULL, TO_DATE('1837-07-03', 'YYYY-MM-DD'), TO_DATE('1916-12-23', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba colores vibrantes y pinceladas sueltas para expresar emoción y dinamismo. Se caracterizaba por temas exóticos, históricos y literarios, con un fuerte sentido del movimiento y el drama. Sus obras, llenas de pasión y energía, son clave del Romanticismo francés.', 'Eugène', NULL, 'Delacroix', NULL, TO_DATE('1798-04-26', 'YYYY-MM-DD'), TO_DATE('1863-08-13', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo escultórico academicista con énfasis en el realismo y la composición narrativa. Sus obras se caracterizan por la elegancia de las formas, la fluidez del drapeado y la expresión de emociones contenidas, a menudo en temas históricos o alegóricos. Utilizaba mármol y bronce.', 'Émile', NULL, 'Chatrousse', NULL, TO_DATE('1829-07-26', 'YYYY-MM-DD'), TO_DATE('1883-02-16', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba una pincelada suelta y vivaz, con una paleta de colores luminosos y suaves. Sus obras se caracterizan por la ligereza, la gracia y una atmósfera de sensualidad y alegría. Exploró temas galantes, retratos íntimos y escenas de género con gran fluidez y movimiento.', 'Jean', 'Honoré', 'Fragonard', NULL, TO_DATE('1732-04-05', 'YYYY-MM-DD'), TO_DATE('1806-08-22', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo paisajístico flamenco caracterizado por escenas rurales, vistas de aldeas y figuras pequeñas. Destacaba por sus composiciones detalladas y la representación de la vida cotidiana en la naturaleza.', 'Théobald', NULL, 'Michau', NULL, TO_DATE('1676-01-01', 'YYYY-MM-DD'), TO_DATE('1765-10-18', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Bélgica'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Grabador italiano del Renacimiento. Se caracterizaba por reproducir y reinterpretar obras de maestros como Rafael, difundiendo el estilo renacentista. Aplicaba técnicas de grabado detalladas para lograr claridad y volumen en sus estampas.', 'Marc', 'Antoine', 'Raimondi', NULL, TO_DATE('1480-01-01', 'YYYY-MM-DD'), TO_DATE('1534-01-01', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Italia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo realista y detallado, con un enfoque en la expresión individual. Se caracterizaba por el uso de la luz y la sombra para crear volumen y profundidad, a menudo en retratos y escenas costumbristas.', 'Louis', NULL, 'de Gouvy', NULL, TO_DATE('1780-01-01', 'YYYY-MM-DD'), TO_DATE('1838-01-01', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Grabador, pintor y teórico del Renacimiento alemán. Aplicaba un detallismo minucioso, dominio de la perspectiva y el volumen. Sus obras se caracterizan por la maestría en el grabado (xilografía y calcografía) y la profunda exploración de temas religiosos y mitológicos.', 'Albrecht', NULL, 'Dürer', NULL, TO_DATE('1471-05-21', 'YYYY-MM-DD'), TO_DATE('1528-04-06', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Alemania'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Pintor de vasos griego antiguo, pionero de la técnica de "fondo blanco" (white-ground). Aplicaba figuras en contorno sobre un fondo blanco con detalles polícromos. Sus obras se caracterizan por la elegancia lineal y la representación de escenas mitológicas o de la vida cotidiana.', 'Psiax', NULL, NULL, NULL, TO_DATE('-0525-01-01', 'SYYYY-MM-DD'), TO_DATE('-0505-01-01', 'SYYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Grecia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Escultor griego clásico. Aplicaba el canon de proporciones ideal y la búsqueda de la perfección humana (Kanon). Sus obras se caracterizan por la contraposición (contrapposto) y la armonía, creando figuras atléticas y equilibradas, representativas del ideal clásico.', 'Polykleitos', NULL, NULL, NULL, TO_DATE('-0480-01-01', 'SYYYY-MM-DD'), TO_DATE('-0420-01-01', 'SYYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Grecia'));
-- ARTISTAS PARA LAS OBRAS DE JACQUEMARTE-ANDRE
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo neoclásico, priorizando la claridad lineal, la composición escultural y el dramatismo moralizante. Sus obras se caracterizan por la frialdad heroica, la luz intensa y la precisión anatómica, a menudo en temas históricos y mitológicos.', 'Jacques', 'Louis', 'David', NULL, TO_DATE('1748-08-30', 'YYYY-MM-DD'), TO_DATE('1825-12-29', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo paisajístico pintoresco, destacando ruinas clásicas y jardines imaginarios. Sus obras se caracterizan por la atmósfera romántica, el uso de la luz para crear profundidad y la incorporación de figuras animadas.', 'Hubert', NULL, 'Robert', NULL, TO_DATE('1733-05-22', 'YYYY-MM-DD'), TO_DATE('1808-04-15', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba colores ricos y vibrantes, con énfasis en la luz y la atmósfera. Sus obras se caracterizan por la devoción religiosa, los retratos expresivos y los paisajes detallados que influyeron en la escuela veneciana de pintura.', 'Giovanni', NULL, 'Bellini', NULL, TO_DATE('1430-01-01', 'YYYY-MM-DD'), TO_DATE('1516-11-26', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Italia'));
-- INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    -- ('Aplicaba una pincelada suelta y vivaz, con una paleta de colores luminosos y suaves. Sus obras se caracterizan por la ligereza, la gracia y una atmósfera de sensualidad y alegría. Exploró temas galantes, retratos íntimos y escenas de género con gran fluidez y movimiento.', 'Jean-Honoré', NULL, 'Fragonard', NULL, TO_DATE('1732-04-05', 'YYYY-MM-DD'), TO_DATE('1806-08-22', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia')); --SE REPITE
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba una técnica de pincelada rápida y vibrante para capturar la atmósfera veneciana. Sus obras, principalmente vedute (vistas de ciudades), se caracterizan por la luz etérea, la vivacidad de las figuras y la maestría en la representación arquitectónica.', 'Francesco', NULL, 'Guardi', NULL, TO_DATE('1712-10-05', 'YYYY-MM-DD'), TO_DATE('1793-01-01', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Italia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba líneas elegantes y fluidas con una gracia etérea y colores pastel vibrantes. Sus obras se caracterizan por la delicadeza de las figuras, el simbolismo poético y la belleza idealizada, a menudo en temas mitológicos y religiosos.', 'Sandro', NULL, 'Botticelli', NULL, TO_DATE('1445-03-01', 'YYYY-MM-DD'), TO_DATE('1510-05-17', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Italia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un dominio magistral del claroscuro, la luz y la sombra para crear profundidad y emoción. Sus obras se caracterizan por la introspección psicológica en retratos, la narrativa dramática en escenas bíblicas y la humanidad profunda de sus personajes.', 'Rembrandt', 'Harmenszoon ', 'van Rijn', NULL, TO_DATE('1606-07-15', 'YYYY-MM-DD'), TO_DATE('1669-10-04', 'YYYY-MM-DD'), 'Rembrandt', (SELECT id_lugar FROM LUGARES WHERE nombre='Países Bajos'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba una técnica de pincelada sensible y una paleta de colores sobria para representar escenas de la vida cotidiana. Sus obras se caracterizan por la intimidad, la quietud y la dignidad de los objetos y las figuras, a menudo en bodegones y escenas de género.', 'Jean', 'Siméon', 'Chardin', NULL, TO_DATE('1699-11-02', 'YYYY-MM-DD'), TO_DATE('1779-12-06', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba una rigurosa perspectiva lineal y un interés por la representación espacial. Sus obras se caracterizan por figuras geométricas, composiciones complejas y una paleta de colores brillantes, a menudo en temas de batalla y mitología.', 'Paolo', NULL, 'Uccello', NULL, TO_DATE('1397-06-15', 'YYYY-MM-DD'), TO_DATE('1475-12-10', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Italia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba una perspectiva audaz, un modelado escultórico y un detallismo preciso en sus figuras. Sus obras se caracterizan por el rigor clásico, la intensidad dramática y la representación monumental, a menudo en temas religiosos y mitológicos.', 'Andrea', NULL, 'Mantegna', NULL, TO_DATE('1431-01-01', 'YYYY-MM-DD'), TO_DATE('1506-09-13', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Italia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba una pincelada enérgica y un fuerte sentido del realismo en sus retratos. Sus obras se caracterizan por la expresión viva de los personajes, la espontaneidad y un uso magistral de la luz y la sombra para resaltar texturas y emociones.', 'Frans', NULL, 'Hals', NULL, TO_DATE('1582-01-01', 'YYYY-MM-DD'), TO_DATE('1666-08-26', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Países Bajos'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo rococó refinado y elegante, centrado en retratos de la aristocracia. Sus obras se caracterizan por colores pastel, la gracia de las poses, la representación de texturas lujosas y la idealización de la belleza femenina.', 'Jean', 'Marc', 'Nattier', NULL, TO_DATE('1685-03-17', 'YYYY-MM-DD'), TO_DATE('1766-11-07', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo barroco exuberante, lleno de dramatismo, emoción y dinamismo. Sus obras se caracterizan por composiciones teatrales, figuras en movimiento y el uso magistral del mármol para crear efectos de textura y luz.', 'Gian', 'Lorenzo', 'Bernini', NULL, TO_DATE('1598-12-07', 'YYYY-MM-DD'), TO_DATE('1680-11-28', 'YYYY-MM-DD'), 'Le Bernin', (SELECT id_lugar FROM LUGARES WHERE nombre='Italia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo realista y emotivo, con un profundo estudio de la anatomía y la expresión humana. Sus obras se caracterizan por la innovación en la perspectiva, el dramatismo narrativo y la ruptura con las convenciones góticas.', 'Donato', NULL, 'di Niccolò', 'di Betto Bardi', TO_DATE('1386-01-01', 'YYYY-MM-DD'), TO_DATE('1466-12-13', 'YYYY-MM-DD'), 'Donatello', (SELECT id_lugar FROM LUGARES WHERE nombre='Italia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo escultórico neoclásico con un realismo sorprendente. Sus obras se caracterizan por la captura de la personalidad y la viveza en retratos, la precisión anatómica y la expresividad, utilizando principalmente mármol y terracota.', 'Jean', 'Antoine', 'Houdon', NULL, TO_DATE('1741-03-20', 'YYYY-MM-DD'), TO_DATE('1828-07-15', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar) VALUES
    ('Aplicaba un estilo barroco y clásico francés, destacando por su dinamismo y el tratamiento detallado de los drapeados. Sus obras se caracterizan por el movimiento, la vitalidad de las expresiones y la maestría en el modelado del mármol.', 'Antoine', NULL, 'Coysevox', NULL, TO_DATE('1640-09-29', 'YYYY-MM-DD'), TO_DATE('1720-01-10', 'YYYY-MM-DD'), NULL, (SELECT id_lugar FROM LUGARES WHERE nombre='Francia'));





-- ---------------------------------------------------------------
-- Tabla: ARTISTAS_OBRAS
-- ---------------------------------------------------------------
-- INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES((SELECT id_obra FROM OBRAS WHERE nombre='nombre de la obra'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'artista de la obra' AND primer_apellido = 'apellido del artista'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Portrait of Comte Antoine Français de Nantes'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jacques' AND primer_apellido = 'David'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Ruined Gallery'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Hubert' AND primer_apellido = 'Robert'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Virgin and Child on a Throne'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Giovanni' AND primer_apellido = 'Bellini'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='The New Model'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jean' AND primer_apellido = 'Fragonard'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Imaginary Portico'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Francesco' AND primer_apellido = 'Guardi'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='La fuite en Egypte'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Sandro' AND primer_apellido = 'Botticelli'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Les Pèlerins d''Emmaüs'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Rembrandt' AND primer_apellido = 'van Rijn'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Les Attributs des Sciences et des Arts'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jean' AND primer_apellido = 'Chardin'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Saint Georges terrassant le dragon'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Paolo' AND primer_apellido = 'Uccello'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Ecce Homo'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Andrea' AND primer_apellido = 'Mantegna'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Portrait d''homme'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Frans' AND primer_apellido = 'Hals'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Portrait de Françoise-Renée de Carbonnel de Canisy, marquise d''Antin'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jean' AND primer_apellido = 'Nattier'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Buste de Grégoire XV'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Gian' AND primer_apellido = 'Bernini'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Le Martyre de Saint Sébastien'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Donato' AND primer_apellido = 'di Niccolò' AND segundo_apellido = 'di Betto Bardi'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Buste de l''architecte Jacques V Gabriel'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Antoine' AND primer_apellido = 'Coysevox'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Buste d''Antoine-Louis François Le Fèvre de Caumartin'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jean' AND primer_apellido = 'Houdon'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Ugolino'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jean' AND primer_apellido = 'Carpeaux'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Ephebe from the Fins d''Annecy'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Polykleitos'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='White ground hydria'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Psiax')); 
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Knight, Death and the Devil (Bartsch 98)'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Albrecht' AND primer_apellido = 'Dürer')); 
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Le Nouvelin de Vénerie'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Louis' AND primer_apellido = 'de Gouvy')); 
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='The Carcass or On the Sabbath Road'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Marc' AND primer_apellido = 'Raimondi'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='A Jaunt by Carriage'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Théobald' AND primer_apellido = 'Michau')); 
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Jérôme de La Lande'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jean' AND primer_apellido = 'Fragonard'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='A Parisian Woman'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Émile' AND primer_apellido = 'Chatrousse'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Combat of the Giaour and the Pasha'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Eugène' AND primer_apellido = 'Delacroix')); 
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Dante'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jean' AND primer_apellido = 'Aubé'));
INSERT INTO ARTISTAS_OBRAS(id_obra, id_artista) VALUES
    ((SELECT id_obra FROM OBRAS WHERE nombre='Cascade Pendant'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Georges' AND primer_apellido = 'Fouquet'));


-- ---------------------------------------------------------------
-- Tabla: EMPLEADOS_IDIOMAS
-- ---------------------------------------------------------------
-- CURADORES
-- EMPLEADOS_PROFESIONALES
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Español'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Italiano'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2012), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2012), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2013), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2013), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2019), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2019), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Español'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2020), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2020), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Italiano'));
-- RESTAURADORES
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2003), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2003), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2006), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2006), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2007), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2007), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Español'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2014), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2014), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Italiano'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2015), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2015), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Inglés'));
-- ADMINISTRATIVOS
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2004), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2008), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2009), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2011), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2016), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2017), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
-- DIRECTORES
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2010), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2018), (SELECT id_idioma FROM IDIOMAS WHERE nombre='Francés'));

-- ---------------------------------------------------------------
-- Tabla: FORMACIONES
-- ---------------------------------------------------------------
--MUSEO JACQUEMART ADNRE
-- CURADORES
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), 'Máster en Curaduría de Arte Moderno', 2010, 'Posgrado en arte francés XIX-XX, teoría curatorial, gestión de colecciones y museología. Prepara para curador principal, con estudios de caso de colecciones francesas.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), 'Certificado Gestión Exposiciones Internacionales', 2015, 'Curso avanzado en planificación, logística y ejecución de exposiciones temporales globales, incluyendo préstamos, seguros y protocolos de seguridad en transporte y montaje.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002), 'Doctorado en Arte Medieval y Renacentista', 2013, 'Investigación doctoral sobre iconografía, técnicas y contextos del arte gótico y renacentista francés y europeo. Proporciona conocimiento para autenticación y contextualización de obras históricas.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002), 'Diplôme en Mediación Cultural y Museografía', 2017, 'Formación práctica en desarrollo de estrategias de mediación cultural, programas educativos y materiales didácticos para la interpretación del arte en museos históricos y modernos.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005), 'Licenciatura en Historia del Arte y Crítica', 2017, 'Estudios de grado en vanguardias artísticas del siglo XX-XXI: Cubismo, Surrealismo, Abstracción. Prepara para curaduría de colecciones y exposiciones contemporáneas.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005), 'Máster en Curaduría Digital y Patrimonio', 2020, 'Posgrado en aplicación de tecnologías digitales (RV, RA, 3D) para exposiciones virtuales, digitalización de colecciones y experiencias interactivas en museos.');
-- RESTAURADORES
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2003), 'Máster en Conservación y Restauración', 2008, 'Formación superior en conservación-restauración de pintura de caballete, incluyendo análisis, intervención y ética. Habilita para colecciones nacionales.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2003), 'Certificado Análisis Científico de Arte', 2012, 'Curso de especialización en uso de técnicas de laboratorio (microscopía, espectroscopía, cromatografía) para identificar materiales, degradación y guiar intervenciones en obras de arte.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2006), 'Máster en Conservación de Escultura', 2007, 'Posgrado enfocado en restauración de escultura en piedra, bronce y madera. Incluye consolidación, limpieza y reintegración. (160 chars)');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2006), 'Certificado Gestión Riesgos y Conservación', 2011, 'Curso sobre implementación de planes de gestión de riesgos (incendios, inundaciones, plagas) y estrategias de conservación preventiva para colecciones museísticas.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2007), 'Máster en Restauración Obras Gráficas', 2018, 'Especialización en restauración de papel, grabados y manuscritos. Aborda limpieza, desacidificación, reparación y montaje para preservar arte en papel.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2007), 'Diplôme Control Climático Museos', 2021, 'Formación en climatología y control ambiental para asegurar temperatura, humedad y luz óptimas en salas de exhibición y depósitos de colecciones artísticas.');
-- ADMINISTRACION
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2004), 'Licenciatura en Gestión Cultural y Adm. Pública', 2006, 'Grado en administración de instituciones culturales: finanzas públicas, presupuestos, contabilidad y gestión de RRHH en el sector público.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2008), 'Máster Administración Instituciones Culturales', 2012, 'Posgrado en dirección estratégica, planificación financiera, gestión de proyectos y fundraising para museos y organizaciones culturales.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2009), 'Máster en Derecho del Arte y Prop. Intelectual', 2015, 'Especialización jurídica en legislación de obras de arte, derechos de autor, autenticidad, patrimonio y aspectos contractuales del mercado del arte, para asesoramiento legal museístico.');
-- DIRECTORES
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2010), 'MBA en Gestión de Instituciones Culturales', 2005, 'Programa ejecutivo para directores de museos: liderazgo estratégico, sostenibilidad financiera, desarrollo de colecciones, diplomacia cultural y gestión de proyectos institucionales.');
-- MUSEO PETIT PALAIS
-- ADMINISTRACION
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2011), 'Certificado CMS y Digitalización', 2017, 'Formación en implementación y gestión de software para catalogación y digitalización de colecciones, optimizando acceso y conservación de información patrimonial.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2016), 'Diplôme Marketing Digital Cultural', 2013, 'Especialización en marketing digital y comunicación para museos: redes sociales, email marketing, SEO y creación de contenido para atraer audiencias.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2017), 'Certificado Protocolo y RR.PP. Culturales', 2020, 'Curso en organización de eventos de alto nivel, gestión de relaciones con patrocinadores/medios y aplicación de protocolo internacional en instituciones culturales.');
-- CURADORES
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2012), 'Doctorado Historia del Arte S.XVIII Francés', 2008, 'Investigación académica profunda sobre el arte Rococó y Neoclásico en Francia, incluyendo la vida y obra de artistas clave, la evolución estilística y el contexto filosófico y social de la época.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2012), 'Máster Museología y Estudios Curatorialies', 2013, 'Posgrado enfocado en metodologías de investigación aplicadas a la museología, la conceptualización de exposiciones, la historia de las colecciones y la crítica curatorial contemporánea.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2013), 'Máster Artes Decorativas y Diseño Histórico', 2016, 'Especialización en historia, técnicas y estilos de artes decorativas francesas (mobiliario, cerámica, textiles) desde Renacimiento al Art Nouveau. Relevante para curaduría.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2013), 'Diplôme Tasación y Mercado del Arte', 2019, 'Formación en valoración de obras, funcionamiento del mercado del arte, subastas, galerías y aspectos legales/éticos de adquisición/disposición de piezas.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2019), 'Máster Gestión Colecciones y Exposiciones', 2014, 'Posgrado en desarrollo, conservación, interpretación y exhibición de colecciones; incluye gestión de riesgos, préstamos y ética del coleccionismo museístico.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2019), 'Certificado Comisariado de Exposiciones', 2018, 'Taller práctico sobre conceptualización y producción de exposiciones que integran diversas disciplinas (arte, ciencia, sociedad) para experiencias innovadoras.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2020), 'Licenciatura Hist. Arte y Civiliz. Francesa', 2010, 'Estudios sobre arte y cultura francesa del siglo XVIII, incluyendo el contexto social, filosófico y político de la Ilustración y su impacto en expresiones artísticas.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2020), 'Máster en Museología y Patrimonio', 2016, 'Posgrado en curaduría transcultural, gestión de colecciones diversas y promoción de diálogo inclusivo entre narrativas culturales en museos globales.');
-- RESTAURADORES
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2014), 'Máster Restauración Muebles y Madera', 2012, 'Especialización en restauración de mobiliario histórico, marquetería, dorados y lacados. Incluye diagnóstico, consolidación, reintegración estética y técnicas tradicionales.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2014), 'Certificado Restauración Metales Históricos', 2016, 'Curso práctico en restauración de objetos de metal (plata, bronce, oro), incluyendo limpieza, estabilización de corrosión, soldadura y protección superficial para piezas artísticas/arqueológicas.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2015), 'Máster Restauración Textiles Históricos', 2018, 'Formación avanzada en restauración de tapices, vestuario y textiles patrimoniales. Incluye limpieza, consolidación, teñido y montaje para exhibición/almacenamiento a largo plazo.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2015), 'Curso Diagnóstico Imagen Conservación Arte', 2021, 'Uso de imagen no invasiva (rayos X, IR, UV, tomografía) para análisis de estructura interna, capas pictóricas, restauraciones previas y autenticidad, crucial para diagnóstico preciso.');
-- DIRECTORES
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES
    ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2018), 'Doctorado Gobernanza y Políticas Culturales', 2010, 'Investigación doctoral sobre políticas culturales, gobernanza de grandes museos, sostenibilidad financiera y papel de los museos en diplomacia cultural y desarrollo.');
-- ---------------------------------------------------------------
-- Tabla: MUSEOS
-- ---------------------------------------------------------------
INSERT INTO MUSEOS(id_lugar, nombre, fecha_fundacion, mision) VALUES
    ((SELECT id_lugar FROM LUGARES WHERE nombre='Francia'), 'Musée Jacquemart André', TO_DATE('1913-01-01', 'YYYY-MM-DD'), 'Preservar y exhibir la vasta y exquisita colección de arte que fue reunida por Édouard André y su esposa Nélie Jacquemart durante sus vidas');
INSERT INTO MUSEOS(id_lugar, nombre, fecha_fundacion, mision) VALUES
    ((SELECT id_lugar FROM LUGARES WHERE nombre='Francia'), 'Musée du Petit Palais', TO_DATE('1902-01-01', 'YYYY-MM-DD'), 'Preservar, exhibir y hacer accesible al público una vasta colección de arte desde la Antigüedad hasta el siglo XIX. También busca educar e inspirar a través de exposiciones temporales y actividades culturales en su icónico edificio');

-- ---------------------------------------------------------------
-- Tabla: EST_FISICA
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée Jacquemart André'), 'Hôtel Jacquemart André', 'EDIFICIO', 'Suntuosa mansión privada parisina del S. XIX. Diseñada por Édouard André para exhibir su vasta colección de arte. Interiores lujosos y disposición original ofrecen una experiencia inmersiva en la vida aristocrática y el arte de sus fundadores.', '158 Boulevard Haussmann, 75008 París, Francia', NULL);

INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée Jacquemart André'), 'Rez de chaussée', 'PISO', 'Explora el Gran Salón, el Salón de Música y el Comedor, repletos de arte del siglo XVIII francés, obras flamencas y holandesas, y esculturas, manteniendo el lujo original de la mansión.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre= 'Hôtel Jacquemart André' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')));

INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée Jacquemart André'), 'Premier Étage', 'PISO', 'Conocido como el Museo Italiano, este piso sumerge en el arte del Renacimiento italiano. Exhibe la impresionante colección de Nélie Jacquemart y Édouard André, con obras de Botticelli y Mantegna, en un ambiente que evoca una galería de arte privada.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre= 'Hôtel Jacquemart André' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')));

INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée Jacquemart André'), 'Les Grands Salons', 'AREA', 'Salones grandiosos de la planta baja (Gran Salón, Salón de Música, Comedor) para recepciones. Exhiben arte flamenco, holandés y francés del siglo XVIII, reflejando el lujo y la vida social de la mansión.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre= 'Rez de chaussée' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')));

INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée Jacquemart André'), 'Les Salons Privés', 'AREA', 'Espacios relajados y de uso diario de los propietarios, menos formales que los salones de estado. Incluyen bibliotecas, salones pequeños o boudoirs para actividades íntimas o reuniones cercanas. Exhiben colecciones personales o curiosidades.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre= 'Rez de chaussée' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')));

INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée Jacquemart André'), 'Le Jardin d''Hiver et L''Escalier', 'AREA', 'El impresionante Jardín de Invierno y la majestuosa Escalera de Honor son elementos arquitectónicos clave. Conectan espacios y exhiben esculturas, añadiendo un toque de serenidad y grandeza a la experiencia.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre= 'Rez de chaussée' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')));

INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée Jacquemart André'), 'Le Musée Italien', 'AREA', 'Alberga la excepcional colección de arte del Renacimiento italiano de los fundadores. Descubre obras maestras de Botticelli, Mantegna y otros, en un ambiente de galería privada.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre= 'Premier Étage' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')));

INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée Jacquemart André'), 'Les Appartements Privés', 'AREA', 'Aposentos íntimos de la pareja: dormitorios, vestidores y baños privados. Estas áreas, muy personales, son clave para comprender la vida doméstica de los Jacquemart-André, aunque no siempre estén abiertas al público.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre= 'Premier Étage' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')));


-- MUSEO PETIT PALAIS
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée du Petit Palais'), 'Petit Palais', 'EDIFICIO', 'Construido para la Exposición Universal de 1900. Alberga el Museo de Bellas Artes de París. Su arquitectura grandiosa, cúpula y jardín semicircular son arte en sí. Colecciones permanentes desde la Antigüedad hasta principios del siglo XX, incluyendo pinturas y esculturas.', 'Avenue Winston Churchill, 75008 París, Francia', NULL);
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée du Petit Palais'), 'Rez de chaussée', 'PISO', 'Explora colecciones de arte antiguo, medieval y del siglo XIX (Belle Époque). Incluye esculturas, pinturas y objetos de arte que narran la historia artística hasta principios del siglo XX, destacando la evolución del arte francés.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre= 'Petit Palais' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')));
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre)VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée du Petit Palais'), 'Premier Étage', 'PISO', 'Rica colección de arte de los siglos XVII y XVIII, con énfasis en pintura y artes decorativas francesas. Exhibe piezas de artistas como Fragonard y Chardin, mostrando el esplendor de la época, junto con arte del Renacimiento y obras modernas.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre= 'Petit Palais' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')));
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée du Petit Palais'), 'Façade', 'AREA', 'La imponente fachada exterior del Petit Palais, una obra maestra de la arquitectura de la Belle Époque.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre = 'Rez de chaussée' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')));
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée du Petit Palais'), 'Dôme', 'AREA', 'La magnífica cúpula que corona el edificio, característica prominente visible desde el interior y exterior.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre = 'Premier Étage' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')));
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée du Petit Palais'), 'Galeries', 'AREA', 'Término general para las amplias áreas de exposición del museo donde se distribuyen las colecciones permanentes y las salas específicas.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre = 'Premier Étage' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))); 
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée du Petit Palais'), 'Jardin', 'AREA', 'El hermoso jardín interior semicircular del museo, un oasis de verdor y calma, ideal para el esparcimiento.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre = 'Rez de chaussée' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')));
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée du Petit Palais'), 'Café', 'AREA', 'Un espacio para el descanso y la restauración, ubicado en el Jardín Interior. Ofrece la oportunidad de disfrutar de una bebida o comida.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre = 'Rez de chaussée' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')));
INSERT INTO EST_FISICA(id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES
    ((SELECT id_museo FROM MUSEOS WHERE nombre='Musée du Petit Palais'), 'Auditorium', 'AREA', 'Una sala dedicada a conferencias, proyecciones, conciertos y eventos culturales. Es un espacio clave para las actividades educativas del museo.', NULL, (SELECT id_est FROM EST_FISICA WHERE nombre = 'Premier Étage' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')));

-- ---------------------------------------------------------------
-- Tabla: ASIGNACIONES_MES
-- ---------------------------------------------------------------

--MUSEO JACQUEMART ANDRE
-- VIGILANTES
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1001),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1001),
        'VESPERTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1003),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Le Jardin d''Hiver et L''Escalier' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1003),
        'VESPERTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Les Appartements Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1005),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1005),
        'NOCTURNO'
    );

-- MANTENIMIENTO
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1002),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Le Jardin d''Hiver et L''Escalier' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1002),
        'VESPERTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1004),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1004),
        'VESPERTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Les Appartements Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1006),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1006),
        'NOCTURNO'
    );


-- MUSEO PETIT PALAIS(Empleados 1007-1012)
--VIGILANTES
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Façade' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1007),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1007),
        'VESPERTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Jardin' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1009),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Café' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1009),
        'VESPERTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Auditorium' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1011),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Dôme' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1011),
        'VESPERTINO'
    );

-- MANTENIMIENTO de Petit Palais
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Façade' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1008),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Jardin' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1008),
        'VESPERTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1010),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Café' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1010),
        'VESPERTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Auditorium' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1012),
        'MATUTINO'
    );
INSERT INTO ASIGNACIONES_MES(mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES
    (
        TO_DATE('2024-06-01', 'YYYY-MM-DD'),
        (SELECT id_est FROM EST_FISICA WHERE nombre='Dôme' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 1012),
        'VESPERTINO'
    );


-- ---------------------------------------------------------------
-- Tabla: ASIGNACIONES_MES
-- ---------------------------------------------------------------

-- SALAS PARA EL JACQUEMART ANDRE
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Le Salon Des Peintures', 'La Galería de Cuadros es una antecámara luminosa que conecta al Gran Salón. Guía a los visitantes hacia los Apartamentos de Estado, exhibiendo alternadamente obras decorativas, mitológicas, bodegones, paisajes y retratos, tal como lo idearon los André.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Le Grand Salon', 'Antiguo salón de baile principal. Esta sala majestuosa ahora exhibe importantes obras de arte, incluyendo pinturas de maestros flamencos y holandeses.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Le Salon de Musique', 'Originalmente un espacio para conciertos. Hoy exhibe colecciones de arte francés del siglo XVIII y una destacada selección de esculturas.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'La Salle à Manger', 'El comedor formal de la mansión. Actualmente presenta exquisitas piezas de la colección de artes decorativas y mobiliario de la época.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Jardin d''Hiver et L''Escalier' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Le Jardin d''Hiver', 'Un magnífico invernadero de cristal con plantas exóticas y esculturas. Ofrecía un espacio refrescante para el descanso de los invitados, diseñado para el entretenimiento y la exhibición de antigüedades.'
    );

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Jardin d''Hiver et L''Escalier' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'L''Escalier', 'La monumental escalera de la mansión, una maravilla arquitectónica al final de los apartamentos. Destaca por su diseño ligero, materiales nobles y espejos que amplifican sus curvas.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Jardin d''Hiver et L''Escalier' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Le Fresque de Tiepolo', 'Un gran fresco de Giambattista Tiepolo, adquirido e instalado en 1893 para realzar la gran escalera. Representa el regreso de Enrique III de Polonia, complementando la grandeza del espacio.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Le Salon des Tapisseries', 'Salón introductorio a espacios íntimos, dedicado al arte francés del siglo XVIII. Exhibe tapices y obras maestras, diseñado para conversaciones privadas.'
    );

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Le Cabinet de Travail', 'El estudio de Édouard André y Nélie Jacquemart, de estilo inglés. Exhibe una rica colección de bronces florentinos, incluyendo obras de Donatello y esculturas.'
    );

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Le Boudoir', 'Espacio íntimo y solitario, originalmente parte del apartamento privado de Nélie. Exhibe obras clave como retratos de Vigée-Lebrun y un fresco de Tiepolo, con porcelanas y arte neoclásico.'
    );

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'La Bibliothèque', 'Dormitorio de Nélie transformado en la biblioteca más apartada de la mansión. Contiene la colección flamenca y holandesa del siglo XVII, incluyendo obras de Rembrandt y Vermeer.'
    );

INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Le Fumoir', 'Salón para conversaciones masculinas post-cena. Exhibe arte inglés y esculturas francesas del siglo XVIII, reflejando el interés de Édouard André por la política y los negocios.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'La Salle des Sculptures', 'Inicialmente vacía, Nélie y Édouard la transformaron para su vasta colección italiana de esculturas. Exhibe tesoros acumulados, presentados según su visión personal.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'La Salle Florentine', 'Dedicada a la escuela florentina, concebida como mausoleo-capilla. Exhibe obras religiosas, retablos y pinturas de maestros como Botticelli y Paolo Uccello, destacando la riqueza del arte florentino.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'La Salle Vénitienne', 'Reflejo del gusto de Édouard André, esta sala agrupa obras de Venecia y del norte de Italia. Presenta piezas de Bellini, Mantegna y Crivelli, con techos de casetones pintados.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Appartements Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'La Chambre de Madame', 'El dormitorio de Nélie Jacquemart, diseñado para evocar el reinado de Luis XV. Exhibe lujosos muebles y textiles de seda, con obras como el retrato de Maurice Quentin de La Tour.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Appartements Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'L''Antichambre', 'Situada entre los dormitorios, era el lugar de encuentro íntimo de la pareja. Contiene retratos familiares, incluyendo el de Nélie en 1872, y objetos personales de Édouard André.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Appartements Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'La Chambre de Monsieur', 'El dormitorio y baño adyacente de Édouard André. Renovado tras su muerte, presenta un interior femenino, con un busto en yeso de Carpeaux, que recuerda la admiración de Nélie por su esposo.'
    );

-- SALAS PARA PETIT PALAIS
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'XIXᵉ SALLE 4', 'Sala dedicada al arte del siglo XIX, exhibiendo una selección de pinturas, esculturas y objetos que representan el estilo y los temas de la época.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'XIXᵉ SALLE 7', 'Otra sala con obras del siglo XIX, complementando la colección con diferentes perspectivas y artistas de este periodo artístico fundamental.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'XIXᵉ SALLE 8', 'Una sala adicional que ofrece una profunda inmersión en el arte del siglo XIX, mostrando más facetas y artistas representativos de este prolífico siglo.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'GALERIE TUCK', 'Espacio que alberga la valiosa Colección Tuck, enfocada en mobiliario exquisito y artes decorativas del siglo XVIII, reflejando el lujo y la artesanía de la época.'
    );
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES
    (
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'XIXᵉ et XXᵉ', 'Área de exposición que combina obras de finales del siglo XIX y principios del siglo XX, ilustrando la transición y evolución artística entre ambos siglos.'
    );

-- ---------------------------------------------------------------
-- Tabla: EXPOSICIONES_EVENTOS
-- ---------------------------------------------------------------
-- EVENTOS JACQUEMART ANDRE (4 eventos)
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES
    (
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Salon de Musique' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Armonías del Siglo XVIII: Concierto de Cámara', TO_DATE('2025-09-15', 'YYYY-MM-DD'), TO_DATE('2025-09-15', 'YYYY-MM-DD'), 25.00, NULL, NULL
    );
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES
    (
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Salle des Sculptures' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Maestros del Cincel: Escultura Italiana', TO_DATE('2025-10-01', 'YYYY-MM-DD'), TO_DATE('2026-01-31', 'YYYY-MM-DD'), 18.00, NULL, 'Universidad de la Sorbona'
    );
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES
    (
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Jardin d''Hiver' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Jardin d''Hiver et L''Escalier' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Poesía bajo el Cristal: Tardes Literarias', TO_DATE('2024-05-20', 'YYYY-MM-DD'), TO_DATE('2024-05-20', 'YYYY-MM-DD'), 10.00, 75, NULL
    );
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES
    (
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Bibliothèque' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        'Curso: El Arte Flamenco y Holandés', TO_DATE('2025-11-05', 'YYYY-MM-DD'), TO_DATE('2025-12-10', 'YYYY-MM-DD'), 150.00, NULL, 'Escuela de Bellas Artes de París'
    );
-- EVENTOS PETIT PALAIS(4 eventos)
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES
    (
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ et XXᵉ' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'París 1900: La Ciudad de la Luz', TO_DATE('2025-07-01', 'YYYY-MM-DD'), TO_DATE('2025-10-31', 'YYYY-MM-DD'), 15.00, NULL, NULL
    );
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES
    (
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'GALERIE TUCK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'La Elegancia del Siglo XVIII: Conferencia sobre la Colección Tuck', TO_DATE('2025-09-20', 'YYYY-MM-DD'), TO_DATE('2025-09-20', 'YYYY-MM-DD'), NULL, NULL, 'Académie des Beaux-Arts'
    );
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES
    (
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ SALLE 7' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Grandes Maestros del Impresionismo Francés', TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 12.00, 85000, NULL
    );
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES
    (
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ SALLE 8' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Pequeños Artistas: Taller de Pintura del Siglo XIX', TO_DATE('2025-11-10', 'YYYY-MM-DD'), TO_DATE('2025-11-10', 'YYYY-MM-DD'), 8.00, 30, 'Unidad Educativa Infantiles Paris'
    );

-- ---------------------------------------------------------------
-- Tabla: CIERRES_TEMPORALES
-- ---------------------------------------------------------------

--CIERRES DEL JACQUEMART ANDRE
INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES
    (
        TO_DATE('2025-02-12', 'YYYY-MM-DD'),
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Jardin d''Hiver' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Jardin d''Hiver et L''Escalier' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        TO_DATE('2025-04-21', 'YYYY-MM-DD')
    );
INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES
    (
        TO_DATE('2023-10-28', 'YYYY-MM-DD'),
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Salon de Musique' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre= 'Musée Jacquemart André'),
        TO_DATE('2023-11-03', 'YYYY-MM-DD')
    );

-- CIERRES DE PETIT PALAIS - FECHAS CORREGIDAS PARA EVITAR CONFLICTOS
INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES
    (
        TO_DATE('2025-01-15', 'YYYY-MM-DD'),  -- Fecha cambiada para evitar conflictos
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ SALLE 7' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        TO_DATE('2025-02-28', 'YYYY-MM-DD')   -- Fecha cambiada para evitar conflictos
    );
INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES
    (
        TO_DATE('2025-01-15', 'YYYY-MM-DD'),  -- Fecha cambiada para evitar conflictos
        (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'GALERIE TUCK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        TO_DATE('2025-02-28', 'YYYY-MM-DD')   -- Fecha cambiada para evitar conflictos
    );


-- ---------------------------------------------------------------
-- Tabla: EST_ORGANIZACIONAL
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Consejo de Administración',
        'DIRECCION',
        1,
        'Órgano de gobierno supremo que establece la visión, misión y estrategia del museo. Supervisa la gestión general y la estabilidad financiera.',
        NULL
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Dirección General',
        'DIRECCION',
        2,
        'Máxima autoridad ejecutiva. Responsable de la gestión diaria del museo, estrategia de desarrollo, presupuesto y representación.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Consejo de Administración' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Departamento de Colecciones y Exposiciones',
        'DEPARTAMENTO',
        3,
        'Gestión, conservación, investigación y exhibición de colecciones permanentes. Planificación y curaduría de exposiciones temporales del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Departamento de Operaciones y Servicios al Visitante',
        'DEPARTAMENTO',
        3,
        'Gestión de infraestructura, seguridad, mantenimiento, logística, taquillas, tienda del museo, personal de sala y experiencia del visitante.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Departamento de Desarrollo y Comunicación',
        'DEPARTAMENTO',
        3,
        'Recaudación de fondos, patrocinios, marketing, prensa, redes sociales, desarrollo de audiencias, eventos especiales y programas de fidelización.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Departamento Financiero y Administrativo',
        'DEPARTAMENTO',
        3,
        'Contabilidad, presupuestos, recursos humanos, gestión legal y administración general del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Departamento de Educación y Mediación Cultural',
        'DEPARTAMENTO',
        3,
        'Diseño y ejecución de programas educativos para diversos públicos (escolares, familias, adultos), talleres, visitas guiadas y materiales didácticos.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );

-- MUSEO PETIT PALAIS
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Dirección y Conservaduría en Jefe del Petit Palais',
        'DIRECCION',
        1,
        'Máxima autoridad ejecutiva y científica del museo, responsable de la dirección general y la conservación de sus colecciones. Annick Lemoine es la Directora y Conservadora en Jefe del Petit Palais.',
        NULL
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Secretaría General',
        'DIRECCION',
        2,
        'Coordina la organización administrativa y técnica del museo, asistiendo a la Dirección en la implementación de proyectos. Delphine Capdepuy ocupa este puesto.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección y Conservaduría en Jefe del Petit Palais' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Servicio de Comunicación',
        'DEPARTAMENTO',
        3,
        'Responsable de las estrategias de comunicación, relaciones con la prensa y difusión de la imagen del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Secretaría de Operaciones',
        'DEPARTAMENTO',
        3,
        'Encargada de la gestión operativa de las instalaciones del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Secretaría de Asuntos Generales',
        'DEPARTAMENTO',
        3,
        'Gestiona los asuntos administrativos generales y el apoyo a las diferentes áreas del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Centro de Recursos de Documentación',
        'DEPARTAMENTO',
        3,
        'Gestiona la biblioteca y archivos del museo, proporcionando recursos para la investigación y el estudio.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Servicio Educativo y Cultural',
        'DEPARTAMENTO',
        3,
        'Diseña e implementa programas educativos, visitas guiadas y actividades culturales para diversos públicos.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Servicio de Exposiciones y Gestión de Colecciones',
        'DEPARTAMENTO',
        3,
        'Encargado de la curaduría y logística de exposiciones, así como la gestión y registro de las colecciones.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Infraestructura y Logística',
        'SECCION',
        4,
        'Gestión del mantenimiento técnico del museo y la logística de sus instalaciones.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría de Explotación' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Seguridad',
        'SECCION',
        4,
        'Garantiza la protección de las obras de arte, las instalaciones y la seguridad de los visitantes.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría de Explotación' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Recepción y Vigilancia',
        'SECCION',
        4,
        'Responsable de la bienvenida a los visitantes y de la vigilancia de las salas de exposición.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría de Explotación' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Gestión de Obras',
        'SECCION',
        4,
        'Gestiona el registro, la ubicación y el movimiento físico de las obras de arte dentro y fuera del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );


-- ---------------------------------------------------------------
-- Tabla: COLECCIONES_PERMANENTES
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
INSERT INTO COLECCIONES_PERMANENTES(id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
    (
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Arte Italiano',
        'Sumérgete en el Renacimiento y Barroco italiano con obras devocionales, esculturas y pinturas que resaltan la maestría en composición y emotividad de artistas como Mantegna y Uccello.',
        'Renacimiento',
        1
    );
INSERT INTO COLECCIONES_PERMANENTES(id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
    (
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Arte Flamenco y Holandés',
        'Explora el Barroco holandés y flamenco a través de retratos y obras religiosas que demuestran el dominio del claroscuro y la psicología de artistas como Rembrandt y Van Dyck.',
        'Barroco',
        4
    );
INSERT INTO COLECCIONES_PERMANENTES(id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
    (
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Arte Francés del sigo XVIII y Artes Decorativas',
        'Admira el refinamiento del Rococó y los inicios del Neoclasicismo francés, con retratos, paisajes arquitectónicos y bodegones que celebran la elegancia y la vida de la corte del siglo XVIII.',
        'Roccocó',
        2
    );
INSERT INTO COLECCIONES_PERMANENTES(id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
    (
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Arte del Siglo XIX',
        'Obras que ilustran la transición del Neoclasicismo al Romanticismo y las primeras pinceladas del Impresionismo, reflejando cambios artísticos y sociales del siglo XIX.',
        'Neoclasicismo',
        3
    );
-- MUSEO PETIT PALAIS
INSERT INTO COLECCIONES_PERMANENTES(id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
    (
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Mundo Clásico',
        'Selección de joyas del mundo griego y romano. Destacan la rareza, perfección técnica e interés científico en esta colección excepcional que abarca artistas maestros y diversas técnicas.',
        'Antigüedad',
        1
    );
INSERT INTO COLECCIONES_PERMANENTES(id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
    (
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Renacimiento',
        'Explora el florecimiento cultural europeo con obras maestras de pintores y escultores. Se busca la perfección, la perspectiva y la figura humana idealizada, marcando una era de humanismo y descubrimiento artístico.',
        'Humanismo',
        2
    );
INSERT INTO COLECCIONES_PERMANENTES(id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
    (
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Siglo XVIII',
        'Descubre la elegancia del arte del siglo XVIII, abarcando estilos como el Rococó y el Neoclasicismo temprano. Incluye pinturas, esculturas y artes decorativas de gran refinamiento que reflejan la sofisticación de la época.',
        'Rococó',
        3
    );
INSERT INTO COLECCIONES_PERMANENTES(id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
    (
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Siglo XIX',
        'Un viaje por las transformaciones artísticas del siglo XIX, desde el Romanticismo y Realismo hasta los inicios del Impresionismo. Refleja profundos cambios sociales y estéticos, con obras que definieron la modernidad.',
        'Modernidad',
        4
    );
INSERT INTO COLECCIONES_PERMANENTES(id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
    (
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'París 1900',
        'Colección dedicada a la efervescencia artística de París en la Belle Époque. Incluye obras que capturan el espíritu de la época, como el Art Nouveau y el Simbolismo, marcando el inicio del siglo XX.',
        'Esplendor',
        5
    );


-- ---------------------------------------------------------------
-- Tabla: COLECCIONES_PERMANENTES
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
-- ARTES ITALIANAS
INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        1
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André' AND
        cp.nombre = 'Arte Italiano' AND
        eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
        se.nombre = 'La Salle des Sculptures' AND
        ef.nombre = 'Le Musée Italien';
INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        2
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André' AND
        cp.nombre = 'Arte Italiano' AND
        eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
        se.nombre = 'La Salle Florentine' AND
        ef.nombre = 'Le Musée Italien';
INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        3
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André' AND
        cp.nombre = 'Arte Italiano' AND
        eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
        se.nombre = 'La Salle Vénitienne' AND
        ef.nombre = 'Le Musée Italien';
-- ARTE FLAMENCO Y HOLANDES
INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        5
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André' AND
        cp.nombre = 'Arte Flamenco y Holandés' AND
        eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
        se.nombre = 'La Bibliothèque' AND
        ef.nombre = 'Les Salons Privés';
-- ARTE FRANCES DEL SIGLO XVIII Y ARTES DECORATIVAS
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        6
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'Le Salon de Musique'
        AND ef.nombre = 'Les Grands Salons';

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        7
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'La Salle à Manger'
        AND ef.nombre = 'Les Grands Salons';

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        8
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'Le Salon des Tapisseries'
        AND ef.nombre = 'Les Salons Privés';

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        9
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'Le Boudoir'
        AND ef.nombre = 'Les Salons Privés';

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        10
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'Le Fumoir'
        AND ef.nombre = 'Les Salons Privés';

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        11
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'La Chambre de Madame'
        AND ef.nombre = 'Les Appartements Privés';

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        12
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'L''Antichambre'
        AND ef.nombre = 'Les Appartements Privés';

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        13
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'La Chambre de Monsieur'
        AND ef.nombre = 'Les Appartements Privés';

-- ARTE DEL SIGLO XIX
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        14
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte del Siglo XIX'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'Le Salon Des Peintures'
        AND ef.nombre = 'Les Grands Salons';

INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        15
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp
        ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo
        ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se
        ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef
        ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND cp.nombre = 'Arte del Siglo XIX'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND se.nombre = 'Le Grand Salon'
        AND ef.nombre = 'Les Grands Salons';


-- MUSEO PETIT PALAIS
INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        1
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée du Petit Palais' AND
        cp.nombre = 'Mundo Clásico' AND
        eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
        se.nombre = 'XIXᵉ et XXᵉ' AND
        ef.nombre = 'Galeries';

INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        2
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée du Petit Palais' AND
        cp.nombre = 'Renacimiento' AND
        eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
        se.nombre = 'XIXᵉ et XXᵉ' AND
        ef.nombre = 'Galeries';

INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        3
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée du Petit Palais' AND
        cp.nombre = 'Siglo XVIII' AND
        eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
        se.nombre = 'GALERIE TUCK' AND
        ef.nombre = 'Galeries';

INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        4
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée du Petit Palais' AND
        cp.nombre = 'Siglo XIX' AND
        eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
        se.nombre = 'XIXᵉ SALLE 4' AND
        ef.nombre = 'Galeries';

INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        5
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée du Petit Palais' AND
        cp.nombre = 'Siglo XIX' AND
        eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
        se.nombre = 'XIXᵉ SALLE 7' AND
        ef.nombre = 'Galeries';

INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        6
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée du Petit Palais' AND
        cp.nombre = 'Siglo XIX' AND
        eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
        se.nombre = 'XIXᵉ SALLE 8' AND 
        ef.nombre = 'Galeries';

INSERT INTO SALAS_COLECCIONES(id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden)
    SELECT
        cp.id_coleccion,
        eo.id_est_org,
        m.id_museo,
        se.id_sala,
        ef.id_est,
        7
    FROM
        MUSEOS m
    JOIN
        COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        SALAS_EXP se ON se.id_museo = m.id_museo
    JOIN
        EST_FISICA ef ON ef.id_museo = m.id_museo AND se.id_est = ef.id_est
    WHERE
        m.nombre = 'Musée du Petit Palais' AND
        cp.nombre = 'París 1900' AND
        eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
        se.nombre = 'XIXᵉ et XXᵉ' AND 
        ef.nombre = 'Galeries';

-- ---------------------------------------------------------------
-- Tabla: HIST_EMPLEADOS
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2000-05-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'DIRECTOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Dirección General'
        AND ep.doc_identidad = 2010;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2008-04-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'CURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND ep.doc_identidad = 2001;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2013-08-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'CURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND ep.doc_identidad = 2002;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2005-12-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'RESTAURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND ep.doc_identidad = 2003;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('1999-02-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'ADMINISTRATIVO',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Departamento Financiero y Administrativo'
        AND ep.doc_identidad = 2004;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2016-06-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'CURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND ep.doc_identidad = 2005;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2003-10-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'RESTAURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND ep.doc_identidad = 2006;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2018-03-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'RESTAURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Departamento de Colecciones y Exposiciones'
        AND ep.doc_identidad = 2007;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2009-07-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'ADMINISTRATIVO',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Departamento Financiero y Administrativo'
        AND ep.doc_identidad = 2008;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2013-01-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'ADMINISTRATIVO',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée Jacquemart André'
        AND eo.nombre = 'Departamento Financiero y Administrativo'
        AND ep.doc_identidad = 2009;

-- MUSEO PETIT PALAIS
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2006-10-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'DIRECTOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Dirección y Conservaduría en Jefe del Petit Palais'
        AND ep.doc_identidad = 2018;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2015-09-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'ADMINISTRATIVO',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Secretaría de Asuntos Generales'
        AND ep.doc_identidad = 2011;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2006-11-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'CURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones'
        AND ep.doc_identidad = 2012;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2015-02-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'CURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones'
        AND ep.doc_identidad = 2013;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2010-08-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'RESTAURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones'
        AND ep.doc_identidad = 2014;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2019-05-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'RESTAURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones'
        AND ep.doc_identidad = 2015;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2010-12-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'ADMINISTRATIVO',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Secretaría de Asuntos Generales'
        AND ep.doc_identidad = 2016;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2019-04-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'ADMINISTRATIVO',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Secretaría de Asuntos Generales'
        AND ep.doc_identidad = 2017;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2013-07-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'CURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones'
        AND ep.doc_identidad = 2019;

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin)
    SELECT
        TO_DATE('2007-03-01', 'YYYY-MM-DD'),
        eo.id_est_org,
        m.id_museo,
        ep.id_empleado,
        'CURADOR',
        NULL
    FROM
        MUSEOS m
    JOIN
        EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
    JOIN
        EMPLEADOS_PROFESIONALES ep ON 1=1
    WHERE
        m.nombre = 'Musée du Petit Palais'
        AND eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones'
        AND ep.doc_identidad = 2020;


-- ---------------------------------------------------------------
-- Tabla: HIST_OBRAS_MOV
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
SELECT
    o.id_obra,
    cp.id_coleccion,
    se.id_sala,
    ep.id_empleado,
    eo.id_est_org,
    m.id_museo,
    ef.id_est,
    TO_DATE('1915-01-15', 'YYYY-MM-DD'), -- Fecha estimada de adquisición
    'DONADA',
    'SI',
    NULL,
    1,
    NULL
FROM
    MUSEOS m
JOIN
    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
JOIN
    SALAS_EXP se ON se.id_museo = m.id_museo
JOIN
    EMPLEADOS_PROFESIONALES ep ON 1=1
JOIN
    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
JOIN
    EST_FISICA ef ON ef.id_museo = m.id_museo
JOIN
    OBRAS o ON 1=1
WHERE
    m.nombre = 'Musée Jacquemart André' AND
    o.nombre = 'Portrait of Comte Antoine Français de Nantes' AND
    cp.nombre = 'Arte del Siglo XIX' AND
    se.nombre = 'Le Salon Des Peintures' AND
    ep.doc_identidad = 2001 AND -- Sophie Dubois
    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
    ef.nombre = 'Les Grands Salons';
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1913-01-11', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    2,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Ruined Gallery' AND
	    cp.nombre = 'Arte del Siglo XIX' AND
	    se.nombre = 'Le Salon Des Peintures' AND
	    ep.doc_identidad = 2002 AND -- Lucas Martin
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Les Grands Salons';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1913-01-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    3,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Virgin and Child on a Throne' AND
	    cp.nombre = 'Arte Italiano' AND
	    se.nombre = 'La Salle Florentine' AND
	    ep.doc_identidad = 2005 AND -- Manon Marie Lefevre
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Le Musée Italien';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1913-01-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'NO',
	    NULL,
	    NULL,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'The New Model' AND
	    cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND
	    se.nombre = 'Le Salon des Tapisseries' AND
	    ep.doc_identidad = 2001 AND -- Sophie Dubois
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Les Salons Privés';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1916-01-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'NO',
	    NULL,
	    NULL,
	    500000
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Imaginary Portico' AND
	    cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND
	    se.nombre = 'Le Salon de Musique' AND
	    ep.doc_identidad = 2002 AND -- Lucas Martin
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Les Grands Salons';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1915-01-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'NO',
	    NULL,
	    NULL,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'La fuite en Egypte' AND
	    cp.nombre = 'Arte Italiano' AND
	    se.nombre = 'La Salle Florentine' AND
	    ep.doc_identidad = 2005 AND -- Manon Marie Lefevre
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Le Musée Italien';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1913-08-22', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    4,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Les Pèlerins d''Emmaüs' AND
	    cp.nombre = 'Arte Flamenco y Holandés' AND
	    se.nombre = 'La Bibliothèque' AND
	    ep.doc_identidad = 2001 AND -- Sophie Dubois
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Les Salons Privés';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1916-04-26', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    5,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Les Attributs des Sciences et des Arts' AND
	    cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND
	    se.nombre = 'La Salle à Manger' AND
	    ep.doc_identidad = 2002 AND -- Lucas Martin
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Les Grands Salons';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1913-01-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    6,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Saint Georges terrassant le dragon' AND
	    cp.nombre = 'Arte Italiano' AND
	    se.nombre = 'La Salle Florentine' AND
	    ep.doc_identidad = 2005 AND -- Manon Marie Lefevre
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Le Musée Italien';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1914-03-17', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    7,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Ecce Homo' AND
	    cp.nombre = 'Arte Italiano' AND
	    se.nombre = 'La Salle Florentine' AND
	    ep.doc_identidad = 2001 AND -- Sophie Dubois
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Le Musée Italien';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1916-01-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    8,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Portrait d''homme' AND
	    cp.nombre = 'Arte Flamenco y Holandés' AND
	    se.nombre = 'La Bibliothèque' AND
	    ep.doc_identidad = 2002 AND -- Lucas Martin
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Les Salons Privés';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1913-10-10', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    9,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Portrait de Françoise-Renée de Carbonnel de Canisy, marquise d''Antin' AND
	    cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND
	    se.nombre = 'Le Boudoir' AND
	    ep.doc_identidad = 2005 AND -- Manon Marie Lefevre
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Les Salons Privés';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1916-01-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    10,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Buste de Grégoire XV' AND
	    cp.nombre = 'Arte Italiano' AND
	    se.nombre = 'La Salle des Sculptures' AND
	    ep.doc_identidad = 2001 AND -- Sophie Dubois
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Le Musée Italien';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1913-01-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    11,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Le Martyre de Saint Sébastien' AND
	    cp.nombre = 'Arte Italiano' AND
	    se.nombre = 'La Salle des Sculptures' AND
	    ep.doc_identidad = 2002 AND -- Lucas Martin
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Le Musée Italien';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1913-01-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    12,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Buste de l''architecte Jacques V Gabriel' AND
	    cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND
	    se.nombre = 'Le Fumoir' AND
	    ep.doc_identidad = 2005 AND -- Manon Marie Lefevre
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Les Salons Privés';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1914-04-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    13,
	    3000000
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre = 'Musée Jacquemart André' AND
	    o.nombre = 'Buste d''Antoine-Louis François Le Fèvre de Caumartin' AND
	    cp.nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND
	    se.nombre = 'Le Fumoir' AND
	    ep.doc_identidad = 2001 AND -- Sophie Dubois
	    eo.nombre = 'Departamento de Colecciones y Exposiciones' AND
	    ef.nombre = 'Les Salons Privés';

-- MUSEO PETIT PALAIS

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1905-03-10', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    1,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='Ugolino' AND
	    cp.nombre = 'Siglo XIX' AND
	    se.nombre = 'XIXᵉ SALLE 4' AND
	    ep.doc_identidad = 2020 AND -- Alexandre Vincent
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1903-07-20', 'YYYY-MM-DD'),
	    'COMPRADA',
	    'SI',
	    NULL,
	    2,
	    50000.00
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='Ephebe from the Fins d''Annecy' AND
	    cp.nombre = 'Mundo Clásico' AND
	    se.nombre = 'XIXᵉ et XXᵉ' AND
	    ep.doc_identidad = 2019 AND -- Clara Fournier
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1904-01-05', 'YYYY-MM-DD'),
	    'DONADA',
	    'NO',
	    NULL,
	    3,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='White ground hydria' AND
	    cp.nombre = 'Mundo Clásico' AND
	    se.nombre = 'XIXᵉ et XXᵉ' AND
	    ep.doc_identidad = 2013 AND -- Alice Michel
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1906-02-15', 'YYYY-MM-DD'),
	    'COMPRADA',
	    'SI',
	    NULL,
	    4,
	    35000.00
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='Knight, Death and the Devil (Bartsch 98)' AND
	    cp.nombre = 'Renacimiento' AND
	    se.nombre = 'XIXᵉ et XXᵉ' AND
	    ep.doc_identidad = 2012 AND -- Paul Simon
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1907-09-01', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    5,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='Le Nouvelin de Vénerie' AND
	    cp.nombre = 'Renacimiento' AND
	    se.nombre = 'XIXᵉ et XXᵉ' AND
	    ep.doc_identidad = 2020 AND -- Alexandre Vincent
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1908-04-25', 'YYYY-MM-DD'),
	    'DONADA',
	    'NO',
	    NULL,
	    6,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='The Carcass or On the Sabbath Road' AND
	    cp.nombre = 'Renacimiento' AND
	    se.nombre = 'XIXᵉ et XXᵉ' AND
	    ep.doc_identidad = 2019 AND -- Clara Fournier
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1909-11-12', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    7,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='A Jaunt by Carriage' AND
	    cp.nombre = 'Siglo XVIII' AND
	    se.nombre = 'GALERIE TUCK' AND
	    ep.doc_identidad = 2013 AND -- Alice Michel
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1910-06-30', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    8,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='Jérôme de La Lande' AND
	    cp.nombre = 'Siglo XVIII' AND
	    se.nombre = 'GALERIE TUCK' AND
	    ep.doc_identidad = 2012 AND -- Paul Simon
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1912-08-01', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    9,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='A Parisian Woman' AND
	    cp.nombre = 'Siglo XIX' AND
	    se.nombre = 'XIXᵉ SALLE 7' AND
	    ep.doc_identidad = 2020 AND -- Alexandre Vincent
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1915-05-20', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    10,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='Combat of the Giaour and the Pasha' AND
	    cp.nombre = 'Siglo XIX' AND
	    se.nombre = 'XIXᵉ SALLE 8' AND
	    ep.doc_identidad = 2019 AND -- Clara Fournier
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1918-09-05', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    11,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='Dante' AND
	    cp.nombre = 'Siglo XIX' AND
	    se.nombre = 'XIXᵉ SALLE 8' AND
	    ep.doc_identidad = 2013 AND -- Alice Michel
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario)
	SELECT
	    o.id_obra,
	    cp.id_coleccion,
	    se.id_sala,
	    ep.id_empleado,
	    eo.id_est_org,
	    m.id_museo,
	    ef.id_est,
	    TO_DATE('1920-03-15', 'YYYY-MM-DD'),
	    'DONADA',
	    'SI',
	    NULL,
	    12,
	    NULL
	FROM
	    MUSEOS m
	JOIN
	    COLECCIONES_PERMANENTES cp ON cp.id_museo = m.id_museo
	JOIN
	    SALAS_EXP se ON se.id_museo = m.id_museo
	JOIN
	    EMPLEADOS_PROFESIONALES ep ON 1=1
	JOIN
	    EST_ORGANIZACIONAL eo ON eo.id_museo = m.id_museo
	JOIN
	    EST_FISICA ef ON ef.id_museo = m.id_museo
	JOIN
	    OBRAS o ON 1=1
	WHERE
	    m.nombre='Musée du Petit Palais' AND
	    o.nombre ='Cascade Pendant' AND
	    cp.nombre = 'París 1900' AND
	    se.nombre = 'XIXᵉ et XXᵉ' AND
	    ep.doc_identidad = 2012 AND -- Paul Simon
	    eo.nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND
	    ef.nombre = 'Galeries';

-- ---------------------------------------------------------------
-- Tabla: PROGRAMAS_MANT
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Revisión de superficie para detectar cambios de color o craquelado.',
    'Trimestral',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Portrait of Comte Antoine Français de Nantes';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Control de condiciones ambientales de humedad y temperatura en sala.',
    'Semanal',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Ruined Gallery';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Limpieza superficial de polvo y verificación de la estabilidad del soporte.',
    'Mensual',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Virgin and Child on a Throne';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Inspección visual para detectar signos de plagas o deterioro biológico.',
    'Semestral',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'The New Model';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Verificación de la integridad de marcos y elementos de montaje.',
    'Anual',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Imaginary Portico';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Chequeo de la iluminación y exposición a la luz UV para evitar daños.',
    'Trimestral',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'La fuite en Egypte';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Evaluación del estado de las capas pictóricas y cualquier signo de levantamiento.',
    'Semestral',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Les Pèlerins d''Emmaüs';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Revisión de la seguridad de la obra en su vitrina o pedestal de exhibición.',
    'Mensual',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Les Attributs des Sciences et des Arts';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Documentación fotográfica del estado actual de la obra para seguimiento.',
    'Anual',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Saint Georges terrassant le dragon';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Control de plagas y limpieza de áreas circundantes a la obra.',
    'Trimestral',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Ecce Homo';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Aplicación de técnicas de conservación preventiva para materiales orgánicos.',
    'Semestral',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Portrait d''homme';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Revisión de etiquetas y números de inventario para asegurar la correcta identificación.',
    'Anual',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Portrait de Françoise-Renée de Carbonnel de Canisy, marquise d''Antin';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Evaluación de posibles riesgos estructurales o de soporte en la obra.',
    'Trimestral',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Buste de Grégoire XV';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Control del acceso y manipulación de la obra por personal autorizado.',
    'Mensual',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Le Martyre de Saint Sébastien';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Limpieza y acondicionamiento del área inmediata de exhibición de la obra.',
    'Semanal',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Buste de l''architecte Jacques V Gabriel';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée Jacquemart André' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Reporte de cualquier anomalía o daño observado para su pronta intervención.',
    'Trimestral',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Buste d''Antoine-Louis François Le Fèvre de Caumartin';

-- MUSEO PETIT PALAIS
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Limpieza superficial de la escultura y revisión de su base.',
    'Trimestral',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Ugolino';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Monitoreo ambiental constante en la vitrina de exhibición.',
    'Semanal',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Ephebe from the Fins d''Annecy';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Inspección de la superficie cerámica para detectar nuevas fisuras.',
    'Mensual',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'White ground hydria';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Verificación de la integridad del grabado y protección contra luz directa.',
    'Trimestral',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Knight, Death and the Devil (Bartsch 98)';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Revisión del estado del lienzo y marco, con limpieza de polvo suave.',
    'Semestral',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Le Nouvelin de Vénerie';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Control de la iluminación y verificación de seguridad de la pieza.',
    'Anual',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'The Carcass or On the Sabbath Road';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Evaluación de las capas de pintura para detectar posibles levantamientos.',
    'Trimestral',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'A Jaunt by Carriage';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Verificación de la estabilidad del soporte y del marco del retrato.',
    'Mensual',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Jérôme de La Lande';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Limpieza y revisión de la escultura para detectar cualquier anomalía.',
    'Semestral',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'A Parisian Woman';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Inspección de las condiciones de exhibición y la seguridad de la obra.',
    'Anual',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Combat of the Giaour and the Pasha';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Revisión del estado de la escultura, buscando grietas o desgastes.',
    'Trimestral',
    'RESTAURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Dante';

INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable)
SELECT
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Musée du Petit Palais' ORDER BY hom.fecha_entrada DESC FETCH FIRST 1 ROW ONLY),
    o.id_obra,
    'Control de la iluminación en la vitrina y verificación del brillo de gemas.',
    'Mensual',
    'CURADOR'
FROM
    OBRAS o
WHERE
    o.nombre = 'Cascade Pendant';


-- ---------------------------------------------------------------
-- Tabla: MANTENIMIENTOS_OBRAS_REALIZADOS
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones)
SELECT
    pm.id_mant,
    hom.id_catalogo_museo,
    o.id_obra,
    ep.id_empleado,
    TO_DATE('2025-01-20', 'YYYY-MM-DD'),
    TO_DATE('2025-01-20', 'YYYY-MM-DD'),
    'Revisión ambiental completada. Se confirman condiciones estables para la obra.'
FROM
    OBRAS o
JOIN
    HIST_OBRAS_MOV hom ON hom.id_obra = o.id_obra
JOIN
    MUSEOS m ON hom.id_museo = m.id_museo
JOIN
    PROGRAMAS_MANT pm ON pm.id_obra = o.id_obra AND pm.id_catalogo = hom.id_catalogo_museo
JOIN
    EMPLEADOS_PROFESIONALES ep ON ep.doc_identidad = 2002 -- Lucas Martin (Curador Jacquemart)
WHERE
    o.nombre = 'Ruined Gallery'
    AND m.nombre = 'Musée Jacquemart André'
    AND pm.actividad LIKE 'Control de condiciones ambientales%'
    AND pm.tipo_responsable = 'CURADOR'
    AND hom.fecha_entrada = (SELECT MAX(fecha_entrada) FROM HIST_OBRAS_MOV WHERE id_obra = o.id_obra AND id_museo = m.id_museo);

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones)
SELECT
    pm.id_mant,
    hom.id_catalogo_museo,
    o.id_obra,
    ep.id_empleado,
    TO_DATE('2025-03-15', 'YYYY-MM-DD'),
    TO_DATE('2025-03-15', 'YYYY-MM-DD'),
    'Inspección visual contra plagas finalizada. No se detectaron indicios de actividad biológica.'
FROM
    OBRAS o
JOIN
    HIST_OBRAS_MOV hom ON hom.id_obra = o.id_obra
JOIN
    MUSEOS m ON hom.id_museo = m.id_museo
JOIN
    PROGRAMAS_MANT pm ON pm.id_obra = o.id_obra AND pm.id_catalogo = hom.id_catalogo_museo
JOIN
    EMPLEADOS_PROFESIONALES ep ON ep.doc_identidad = 2005 -- Manon Marie Lefevre (Curador Jacquemart)
WHERE
    o.nombre = 'The New Model'
    AND m.nombre = 'Musée Jacquemart André'
    AND pm.actividad LIKE 'Inspección visual para detectar signos de plagas%'
    AND pm.tipo_responsable = 'CURADOR'
    AND hom.fecha_entrada = (SELECT MAX(fecha_entrada) FROM HIST_OBRAS_MOV WHERE id_obra = o.id_obra AND id_museo = m.id_museo);

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones)
SELECT
    pm.id_mant,
    hom.id_catalogo_museo,
    o.id_obra,
    ep.id_empleado,
    TO_DATE('2025-04-22', 'YYYY-MM-DD'),
    TO_DATE('2025-04-22', 'YYYY-MM-DD'),
    'Seguridad de la obra en vitrina revisada y asegurada. Todo conforme.'
FROM
    OBRAS o
JOIN
    HIST_OBRAS_MOV hom ON hom.id_obra = o.id_obra
JOIN
    MUSEOS m ON hom.id_museo = m.id_museo
JOIN
    PROGRAMAS_MANT pm ON pm.id_obra = o.id_obra AND pm.id_catalogo = hom.id_catalogo_museo
JOIN
    EMPLEADOS_PROFESIONALES ep ON ep.doc_identidad = 2001 -- Sophie Dubois (Curador Jacquemart)
WHERE
    o.nombre = 'Les Attributs des Sciences et des Arts'
    AND m.nombre = 'Musée Jacquemart André'
    AND pm.actividad LIKE 'Revisión de la seguridad de la obra en su vitrina%'
    AND pm.tipo_responsable = 'CURADOR'
    AND hom.fecha_entrada = (SELECT MAX(fecha_entrada) FROM HIST_OBRAS_MOV WHERE id_obra = o.id_obra AND id_museo = m.id_museo);

-- MUSEO PETIT PALAIS
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones)
SELECT
    pm.id_mant,
    hom.id_catalogo_museo,
    o.id_obra,
    ep.id_empleado,
    TO_DATE('2025-05-10', 'YYYY-MM-DD'),
    TO_DATE('2025-05-10', 'YYYY-MM-DD'),
    'Monitoreo ambiental constante en la vitrina de exhibición realizado. Valores estables.'
FROM
    OBRAS o
JOIN
    HIST_OBRAS_MOV hom ON hom.id_obra = o.id_obra
JOIN
    MUSEOS m ON hom.id_museo = m.id_museo
JOIN
    PROGRAMAS_MANT pm ON pm.id_obra = o.id_obra AND pm.id_catalogo = hom.id_catalogo_museo
JOIN
    EMPLEADOS_PROFESIONALES ep ON ep.doc_identidad = 2019 -- Clara Fournier (Curador Petit Palais)
WHERE
    o.nombre = 'Ephebe from the Fins d''Annecy'
    AND m.nombre = 'Musée du Petit Palais'
    AND pm.actividad LIKE 'Monitoreo ambiental constante en la vitrina%'
    AND pm.tipo_responsable = 'CURADOR'
    AND hom.fecha_entrada = (SELECT MAX(fecha_entrada) FROM HIST_OBRAS_MOV WHERE id_obra = o.id_obra AND id_museo = m.id_museo);

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones)
SELECT
    pm.id_mant,
    hom.id_catalogo_museo,
    o.id_obra,
    ep.id_empleado,
    TO_DATE('2025-06-01', 'YYYY-MM-DD'),
    TO_DATE('2025-06-01', 'YYYY-MM-DD'),
    'Verificación de la estabilidad del soporte y marco del retrato realizada. No se observan anomalías.'
FROM
    OBRAS o
JOIN
    HIST_OBRAS_MOV hom ON hom.id_obra = o.id_obra
JOIN
    MUSEOS m ON hom.id_museo = m.id_museo
JOIN
    PROGRAMAS_MANT pm ON pm.id_obra = o.id_obra AND pm.id_catalogo = hom.id_catalogo_museo
JOIN
    EMPLEADOS_PROFESIONALES ep ON ep.doc_identidad = 2012 -- Paul Simon (Curador Petit Palais)
WHERE
    o.nombre = 'Jérôme de La Lande'
    AND m.nombre = 'Musée du Petit Palais'
    AND pm.actividad LIKE 'Verificación de la estabilidad del soporte y del marco%'
    AND pm.tipo_responsable = 'CURADOR'
    AND hom.fecha_entrada = (SELECT MAX(fecha_entrada) FROM HIST_OBRAS_MOV WHERE id_obra = o.id_obra AND id_museo = m.id_museo);

-- ---------------------------------------------------------------
-- Tabla: HORARIOS
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (1,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (2,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (3,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (4,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (5,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('10:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (6,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('07:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (7,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('07:00 PM', 'HH:MI PM'));

-- MUSEO PETIT PALAIS
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (2,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (3,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (4,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (5,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (6,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));
INSERT INTO HORARIOS (dia, id_museo, hora_inicio, hora_cierre)
VALUES (7,(SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('10:00 AM', 'HH:MI AM'),TO_DATE('06:00 PM', 'HH:MI PM'));

-- ---------------------------------------------------------------
-- Tabla: TIPO_TICKETS
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
-- Precios 2023 
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2023-03-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 18.00, 'ADULTO', TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2023-03-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 16.00, 'ESTUDIANTE', TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2023-03-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 8.50, 'INFANTIL', TO_DATE('2023-12-31', 'YYYY-MM-DD'));
-- Precios actuales 
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 17.00, 'ADULTO', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 15.00, 'ESTUDIANTE', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 9.50, 'INFANTIL', NULL);

-- MUSEO PETIT PALAIS
-- Precios 2023
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2023-02-15', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 14.00, 'ADULTO', TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2023-02-15', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 6.50, 'ESTUDIANTE', TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2023-02-15', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 0.00, 'INFANTIL', TO_DATE('2023-12-31', 'YYYY-MM-DD'));

-- Precios actuales (desde 01-ENE-2024)
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 15.50, 'ADULTO', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 7.50, 'ESTUDIANTE', NULL);
INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) VALUES 
(TO_DATE('2024-01-01', 'YYYY-MM-DD'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 0.00, 'INFANTIL', NULL);


-- ---------------------------------------------------------------
-- Tabla: TICKETS
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE

INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (1, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-01 10:15:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-01 10:20:00', 'YYYY-MM-DD HH24:MI:SS'),'ESTUDIANTE',15.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-01 10:25:00', 'YYYY-MM-DD HH24:MI:SS'),'INFANTIL',9.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-02 11:05:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-03 12:30:00', 'YYYY-MM-DD HH24:MI:SS'),'ESTUDIANTE',15.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-03 12:35:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (8, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-04 09:45:00', 'YYYY-MM-DD HH24:MI:SS'),'INFANTIL',9.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (9, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-04 14:00:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (10, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-05 15:30:00', 'YYYY-MM-DD HH24:MI:SS'),'ESTUDIANTE',15.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (11, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-05 15:35:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (12, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-06 18:00:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (13, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-06 18:05:00', 'YYYY-MM-DD HH24:MI:SS'),'INFANTIL',9.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (14, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-07 11:20:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (15, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),TO_DATE('2025-06-07 11:25:00', 'YYYY-MM-DD HH24:MI:SS'),'ESTUDIANTE',15.00);

-- MUSEO PETIT PALAIS

INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (1, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-01 10:05:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-01 10:10:00', 'YYYY-MM-DD HH24:MI:SS'),'ESTUDIANTE',7.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-01 10:15:00', 'YYYY-MM-DD HH24:MI:SS'),'INFANTIL',0.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-02 11:30:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-02 11:35:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-03 13:00:00', 'YYYY-MM-DD HH24:MI:SS'),'ESTUDIANTE',7.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-03 13:05:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (8, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-04 09:50:00', 'YYYY-MM-DD HH24:MI:SS'),'INFANTIL',0.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (9, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-04 14:15:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (10, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-05 15:40:00', 'YYYY-MM-DD HH24:MI:SS'),'ESTUDIANTE',7.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (11, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-05 15:45:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (12, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (13, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-06 17:05:00', 'YYYY-MM-DD HH24:MI:SS'),'INFANTIL',0.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (14, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-07 11:10:00', 'YYYY-MM-DD HH24:MI:SS'),'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (15, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),TO_DATE('2025-06-07 11:15:00', 'YYYY-MM-DD HH24:MI:SS'),'ESTUDIANTE',7.50);


-- ---------------------------------------------------------------
-- Tabla: HIST_MUSEO
-- ---------------------------------------------------------------
-- JACQUEMART ANDRE
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1913, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 'Fundación del Musée Jacquemart André.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1925, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 'Adquisición de la colección de arte italiano.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1935, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 'Exposición de arte renacentista.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1960, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 'Restauración de las pinturas murales.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1980, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 'Celebración del centenario del nacimiento de Nélie Jacquemart.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1995, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 'Renovación de las salas de exposición.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (2005, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 'Exposición de obras maestras italianas.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (2015, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 'Ampliación de la colección de esculturas.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (2025, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'), 'Implementación de programas educativos.');

-- MUSEO PETIT PALAIS
INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1902, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 'Fundación del Musée du Petit Palais.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1910, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 'Adquisición de nuevas colecciones de arte.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1920, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 'Exposición de arte moderno.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1950, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 'Restauración del edificio después de la guerra.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1975, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 'Celebración del 75 aniversario del museo.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (1990, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 'Modernización de las instalaciones del museo.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (2000, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 'Exposición sobre la historia de París.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (2010, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 'Ampliación de la colección permanente.');

INSERT INTO HIST_MUSEOS (anio, id_museo, hecho)
VALUES (2020, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'), 'Implementación de visitas virtuales.');


COMMIT;


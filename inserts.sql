-- -----------------------------------------------------------------------------
-- Script de Población para la Base de Datos de Museos
-- Versión Actualizada con subconsultas, ajustes de cantidad de registros y detalle restaurado.
-- -----------------------------------------------------------------------------
-- Este script contiene los comandos INSERT para poblar las tablas
-- del proyecto de Sistemas de Bases de Datos.
-- -----------------------------------------------------------------------------

SET DEFINE OFF;




-- ---------------------------------------------------------------
-- Tabla: LUGARES PARA TODOS LOS MUSEOS
-- ---------------------------------------------------------------
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Francia', 'PAIS', NULL, 'EUROPA');
-- CIUDAD DE FRANCIA
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Paris', 'CIUDAD', (SELECT id_lugar FROM LUGARES WHERE nombre='Francia' AND tipo='PAIS'), NULL);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Misy-Sur-Yonne', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Francia' AND tipo = 'PAIS'), null);
-- FIN CIUDADES DE FRANCIA
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Países Bajos', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Italia', 'PAIS', NULL, 'EUROPA');
-- CIUDADES DE ITALIA
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Roma', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Italia' AND tipo = 'PAIS'), null);
-- FIN CIUDADES DE ITALIA
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Grecia', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Alemania', 'PAIS', NULL, 'EUROPA');
-- CIUDADES DE ALEMANIA
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Leipzig', 'CIUDAD', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania' AND tipo = 'PAIS'), NULL);
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Hamburgo', 'CIUDAD', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania' AND tipo = 'PAIS'), NULL);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Oederan', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania' AND tipo = 'PAIS'), null);
-- FIN CIUDADES DE ALEMANIA
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Bélgica', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Estados Unidos', 'PAIS', NULL, 'AMERICA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Noruega', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Suiza', 'PAIS', NULL, 'EUROPA');
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('España', 'PAIS', NULL, 'EUROPA');
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Polonia', 'PAIS',NULL, 'EUROPA');
-- CIUDADES DE POLONIA
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Varsovia', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Polonia' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Lowicz', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Polonia' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Cracovia', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Polonia' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Radom', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Polonia' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Wolczyn', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Polonia' AND tipo = 'PAIS'), null);
-- FIN CIUDADES DE POLONIA
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Austria', 'PAIS',NULL, 'EUROPA');
-- CIUDADES DE AUSTRIA
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Viena', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Austria' AND tipo = 'PAIS'), null);
-- FIN CIUDADES DE AUSTRIA
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Reino Unido', 'PAIS',NULL, 'EUROPA');
-- CIUDADES DE REINO UNIDO
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Londres', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Reino Unido' AND tipo = 'PAIS'), null);
-- FIN CIUDADES DE REINO UNIDO
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Dinamarca', 'PAIS',NULL, 'EUROPA');
-- CIUDADES DE DINAMARCA
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Copenhague', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Dinamarca' AND tipo = 'PAIS'), null);
-- FIN CIUDADES DE DINAMARCA
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Venezuela', 'PAIS', NULL, 'AMERICA');
-- CIUDADES DE VENEZUELA 
INSERT INTO LUGARES (nombre, tipo, id_lugar_padre, continente) VALUES ('Caracas', 'CIUDAD', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Venezuela' AND tipo = 'PAIS'), NULL);
-- FIN CIUDADES DE VENEZUELA


-- ---------------------------------------------------------------
-- Tabla: IDIOMAS PARA TODOS LOS INSERT
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
INSERT INTO IDIOMAS (nombre) VALUES ('Polaco');

-- -----------------------------------------------------------------------------
-- PAIS: POLONIA
-- -----------------------------------------------------------------------------

--INSERT MUSEOS
INSERT INTO museos (id_lugar, Nombre, fecha_fundacion, mision) values ((SELECT id_lugar FROM LUGARES WHERE nombre = 'Varsovia'), 'Museo Nacional de Varsovia', '20/May/1862', 
'Recorrer y preservar la historia del arte de Polonia a través de su extensa colección, así como albergar importantes obras de arte de artistas extranjeros');
INSERT INTO museos (id_lugar, Nombre, fecha_fundacion, mision) values ((SELECT id_lugar FROM LUGARES WHERE nombre ='Lowicz'), 'Museo de Nieborow y Arkadia', '18/nov/1945',
'Conservar y presentar la herencia cultural y artística de las residencias aristocráticas polacas de los siglos XVII al XIX. Esto se logra a través de la exhibición de interiores originales, colecciones de arte, mobiliario, porcelana, libros antiguos y objetos decorativos.');

--INSERT HIST_MUSEOS 
INSERT INTO HIST_MUSEOS (ANIO, ID_MUSEO, HECHO) VALUES (1862, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 'Fundación del Museo Nacional de Varsovia bajo el nombre de "Museo de Bellas Artes"');
INSERT INTO HIST_MUSEOS (ANIO, ID_MUSEO, HECHO) VALUES (1938, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 'Inauguración del actual edificio del museo diseñado por Tadeusz Tolwiński');
INSERT INTO HIST_MUSEOS (ANIO, ID_MUSEO, HECHO) VALUES (1944, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 'El museo sufre graves daños durante el Alzamiento de Varsovia y pierde aproximadamente el 40% de sus colecciones');


INSERT INTO HIST_MUSEOS (ANIO, ID_MUSEO, HECHO) VALUES (1774, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 'Construcción del Palacio de Nieborów en estilo barroco por Michał Radziwiłł según diseño de Tylman van Gameren');
INSERT INTO HIST_MUSEOS (ANIO, ID_MUSEO, HECHO) VALUES (1945, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 'El palacio y jardines de Nieborów son nacionalizados y convertidos en museo tras la Segunda Guerra Mundial');
INSERT INTO HIST_MUSEOS (ANIO, ID_MUSEO, HECHO) VALUES (1962, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 'El complejo de Nieborów y Arkadia es declarado Monumento Histórico y pasa a formar parte de la red de museos nacionales');

--INSERT HORARIOS
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (1, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('18:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('18:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('18:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('18:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('20:00:00', 'HH24:MI:SS')); -- Viernes extendido
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('18:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('18:00:00', 'HH24:MI:SS'));

INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (1, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('16:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('16:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('16:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('16:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('16:00:00', 'HH24:MI:SS'));
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('17:00:00', 'HH24:MI:SS')); -- Sábado extendido
INSERT INTO HORARIOS (DIA, ID_MUSEO, HORA_INICIO, HORA_CIERRE) VALUES (7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), TO_DATE('10:00:00','HH24:MI:SS'), TO_DATE('17:00:00', 'HH24:MI:SS')); -- Domingo extendido


--INSERT TIPO_TICKETS

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2015', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 4.00, 'ADULTO', TO_DATE('31-12-2017', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2015', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 2.65, 'ESTUDIANTE', TO_DATE('31-12-2017', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2018', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 5.50, 'ADULTO', TO_DATE('31-12-2019', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2018', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 3.30, 'ESTUDIANTE', TO_DATE('31-12-2019', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2020', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 5.80, 'ADULTO', TO_DATE('31-12-2021', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2020', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 3.95, 'ESTUDIANTE', TO_DATE('31-12-2021', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2022', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 5.20, 'ADULTO', TO_DATE('31-12-2023', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2022', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 3.10, 'ESTUDIANTE', TO_DATE('31-12-2023', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2024', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 7.50, 'ADULTO', NULL);

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2024', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 5.00, 'ESTUDIANTE', NULL);

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2015', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 0.00, 'INFANTIL', NULL);


INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2015', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 4.50, 'ADULTO', TO_DATE('31-12-2017', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2015', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 2.80, 'ESTUDIANTE', TO_DATE('31-12-2017', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2018', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 5.80, 'ADULTO', TO_DATE('31-12-2019', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2018', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 3.50, 'ESTUDIANTE', TO_DATE('31-12-2019', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2020', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 6.20, 'ADULTO', TO_DATE('31-12-2021', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2020', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 4.20, 'ESTUDIANTE', TO_DATE('31-12-2021', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2022', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 7.00, 'ADULTO', TO_DATE('31-12-2023', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2022', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 4.80, 'ESTUDIANTE', TO_DATE('31-12-2023', 'DD-MM-YYYY'));

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2024', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 8.20, 'ADULTO', NULL);

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2024', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 5.50, 'ESTUDIANTE', NULL);

INSERT INTO TIPO_TICKETS (fecha_inicio, id_museo, precio, tipo, fecha_fin) 
VALUES (TO_DATE('01-01-2015', 'DD-MM-YYYY'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 0.00, 'INFANTIL', NULL);

--INSERT TICKETS
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (1, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), SYSDATE, 'ADULTO', 7.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), SYSDATE, 'ESTUDIANTE', 5.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), SYSDATE, 'INFANTIL', 0.00);

INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (1, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), SYSDATE, 'ADULTO', 8.20);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), SYSDATE, 'ESTUDIANTE', 5.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), SYSDATE, 'INFANTIL', 0.00);


--INSERT EST_FISICA
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 'Gmach Główny Muzeum Narodowego w Warszawie', 'EDIFICIO', 
'Edificio Neoclasico Moderno, Reconstruido tras la Segunda Guerra Mundial. Es la sede principal del Museo Nacional', 
'Aleje Jerozolimskie 3, 00-495 Varsovia, Polonia', NULL);
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 'Planta Baja', 'PISO', 
'En este piso se encuentran las exposiciones temporales, asi como las de culturas antiguas y de arte medieval', 
(SELECT id_museo FROM EST_FISICA WHERE nombre = 'Gmach Główny Muzeum Narodowego w Warszawie'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Gmach Główny Muzeum Narodowego w Warszawie'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 'Primera Planta', 'PISO', 
'Este piso alberga las exposiciones de Arte Sacro, Pintura Flamenca, y la Galería de Arte Decorativa y la Galería de Los Maestros Europeos y polacos', 
(SELECT id_museo FROM EST_FISICA WHERE nombre = 'Gmach Główny Muzeum Narodowego w Warszawie'), 
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Gmach Główny Muzeum Narodowego w Warszawie'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 'Segunda Planta', 'PISO', 
'Esta planta muestra la gran variedad de elementos decorativos que la sociedad de Varsovia ha utilizado. 
En este espacio se establecen los estudios de diversos diseñadores nacionales quienes se nutren con las muestras.', 
(SELECT id_museo FROM EST_FISICA WHERE nombre = 'Gmach Główny Muzeum Narodowego w Warszawie'), (SELECT id_museo FROM MUSEOS WHERE nombre = 'Gmach Główny Muzeum Narodowego w Warszawie'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 'Sotano', 'PISO', 
'En el sotano se encuentra la galeria de arte medieval', 
(SELECT id_museo FROM EST_FISICA WHERE nombre = 'Gmach Główny Muzeum Narodowego w Warszawie'), 
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Gmach Główny Muzeum Narodowego w Warszawie'));

INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 'Palacio de Nieborów', 'EDIFICIO', 
'Un Palacio Barroco de 2 pisos, reconocido por sus jardines', 
'Radziwiłł Palace in Nieborów and Romantic Park in Arkadia, Aleja Lipowa 3599-416 Nieborów', NULL);
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 'Planta Baja', 'PISO', 
'En la planta baja se encuentra el vestibulo, que es el unico interior original preservado del museo', (SELECT id_museo FROM EST_FISICA WHERE nombre = 'Palacio de Nieborów'), 
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Palacio de Nieborów'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 'Primera Planta', 'PISO', 
'En esta planta se encuentran algunas habitaciones, la biblioteca, estudios y la escalera principal', (SELECT id_museo FROM EST_FISICA WHERE nombre = 'Palacio de Nieborów'), 
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Palacio de Nieborów'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 'Segunda Planta', 'PISO', 
'En esta planta se encuentra la habitacion de la princesa, asi como otros recuerdos y fotografias de la familia Radziwill', (SELECT id_museo FROM EST_FISICA WHERE nombre = 'Palacio de Nieborów'), 
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Palacio de Nieborów'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 'Parque Romantico de Arkadia', 'AREA', 
'Diseñado por una de las damas Radziwill, se convirtió en su orgullo, un parque y jardin decorado en estilo clásico romano', (SELECT id_museo FROM EST_FISICA WHERE nombre = 'Palacio de Nieborów'), 
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Palacio de Nieborów'));
INSERT INTO EST_FISICA (id_museo, nombre, tipo, descripcion, direccion_edificio, id_est_padre) VALUES 
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 'Jardin Barroco de Nieborow', 'AREA', 
'Jardin Barroco de estilo Francés, construido en el Siglo XIX', (SELECT id_museo FROM EST_FISICA WHERE nombre = 'Palacio de Nieborów'), 
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Palacio de Nieborów'));

-- UPDATE MUSEO NACIONAL DE VARSOVIA
UPDATE est_fisica 
SET id_est_padre = (SELECT id_est FROM EST_FISICA WHERE nombre = 'Gmach Główny Muzeum Narodowego w Warszawie')
WHERE tipo = 'PISO' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia');
-- UPDATE MUSEO DE NIEBOROW Y ARKADIA
UPDATE est_fisica 
SET id_est_padre = (SELECT id_est FROM EST_FISICA WHERE nombre = 'Palacio de Nieborów')
WHERE tipo = 'PISO' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia');
UPDATE est_fisica 
SET id_est_padre = (SELECT id_est FROM EST_FISICA WHERE nombre = 'Palacio de Nieborów')
WHERE tipo = 'AREA' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia');


--INSERT EMPLEADOS_VIGILANTE_MANT
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Thadeus', 'Kosciusko', 30114385, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Josef', 'Konrad', 30114386, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Frederik', 'Chopin', 30114387, 'MANTENIMIENTO');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Theodore', 'Katcinsky ', 30114388, 'MANTENIMIENTO');

INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Nikolas', 'Copernico', 32114395, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Robert', 'Lewandowski', 32114396, 'VIGILANTE');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Roman', 'Polanski', 32114397, 'MANTENIMIENTO');
INSERT INTO EMPLEADOS_VIGILANTE_MANT (nombre, apellido, doc_identidad, tipo_responsable) VALUES 
('Eric', 'Lehnsherr', 32114398, 'MANTENIMIENTO');

--INSERT ASIGNACION_MES
INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-07', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 30114385), 'MATUTINO');
 
INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-07', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Segunda Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 30114386), 'MATUTINO');
 
 INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-07', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 30114387), 'VESPERTINO');
 
 INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-07', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Sotano' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 30114388), 'NOCTURNO');


INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-07', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Palacio de Nieborów' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 32114395), 'MATUTINO');
 
INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-07', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Segunda Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 32114396), 'MATUTINO');
 
 INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-07', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Segunda Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 32114397), 'VESPERTINO');
 
 INSERT INTO ASIGNACIONES_MES (mes_anio, id_est, id_museo, id_vig_mant, turno) VALUES 
(TO_DATE('2025-06-07', 'YYYY-MM-DD'), 
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Parque Romantico de Arkadia' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 (SELECT id_vig_mant FROM EMPLEADOS_VIGILANTE_MANT WHERE doc_identidad = 32114398), 'NOCTURNO');


 --INSERTS SALAS_EXP
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 'Galería Faras', 'Arte cristiano de Nubia (frescos del siglo VIII-XIV)');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 'Galería Arte Medieval', 'Esculturas, pinturas y objetos litúrgicos (siglos XII-XVI)');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 'Galería Arte Oriental', 'Cerámicas y textiles de Asia Central');
  INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 'Galería de Arte Polaco Antiguo', 'Pinturas renacentistas y barrocas y retratos de la nobleza polaca');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 'Sala de Arte Europeo', 'Obras de Maestros Europeos');
  INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Segunda Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 'Galería de Arte del Siglo XIX', 'Obras del Romanticismo, Simbolisto y Realismo Polaco');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Segunda Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 'Sala de Arte Decorativo', 'Plata, porcelana y muebles históricos');
 
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'Vestibulo', 'El unico interior preservado de la mansion de cuando era habitada por la familia Nieborowsky');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'Exhibicion', 'Prendas y Joyas de la Familia Radziwill, asi como una exposicion de su historia');
  INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'El Cuarto Blanco', 'Sala de Baile y Capilla de la Mansion');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'El Estudio Amarillo', 'Un diseño neo renacentista con una decoración de pinturas');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'La Biblioteca', 'Biblioteca con vistas al jardín y retratos de varios monarcas europeos');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'El Cuarto de Dibujo Rojo', 'Un cuarto con diseño Neo-Rococo, con muebles franceses y el retrato de una dama');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Segunda Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'El Cuarto de la Princesa', 'El cuarto de la hija del ultimo dueño de la mansión');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Segunda Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'La Armería Nesvish', 'Un conjunto de armaduras y armas que pertenecieron a los Radziwill');
 INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Parque Romantico de Arkadia' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'Parque Romantico de Arkadia', 'Jardin diseñado por la aristocracia para imitar el éstilo romano');
  INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Jardin Barroco de Nieborow' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'), 
 'Jardin Barroco de Nieborow', 'Jardin diseñado por la aristocracia para imitar el éstilo barroco frances');
INSERT INTO SALAS_EXP (id_est, id_museo, nombre, descripcion) VALUES 
((SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')), 
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'), 
 'Sala de Arte Moderno', 'Sala dedicada a obras modernas y contemporáneas (siglos XX-XXI)');

 --INSERT CIERRES_TEMPORALES
 INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES
(TO_DATE('2025-08-15', 'YYYY-MM-DD'), (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Galería Arte Medieval' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 TO_DATE('2025-08-30', 'YYYY-MM-DD'));

 INSERT INTO CIERRES_TEMPORALES (fecha_inicio, id_sala, id_est, id_museo, fecha_fin) VALUES
(TO_DATE('2025-07-01', 'YYYY-MM-DD'), (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'El Estudio Amarillo' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 TO_DATE('2025-08-31', 'YYYY-MM-DD'));

 --INSERT EST_ORGANIZACIONAL
 INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo Nacional de Varsovia'), 'Direccion General', 'DIRECCION', 1, 'La maxima autoridad del museo, responsable de todos las areas yl buen funcionamiento de la institucion',
NULL);
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo Nacional de Varsovia'), 'Departamento de Colecciones', 'DEPARTAMENTO', 2, 'Responsables de la Conservacion, la investigacion, adquisicion, catalogacion y prestamos',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion General' and id_museo = (select id_museo from museos where nombre = 'Museo Nacional de Varsovia')));
 INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo Nacional de Varsovia'), 'Departamento de Conservacion y Restauracion', 'DEPARTAMENTO', 2, 
'Responsables de coordinar los laboratorios y talleres',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion General' and id_museo = (select id_museo from museos where nombre = 'Museo Nacional de Varsovia')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo Nacional de Varsovia'), 'Departamento de Exposiciones', 'DEPARTAMENTO', 2, 
'Responsables de la logistica y montaje de las exposiciones',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion General' and id_museo = (select id_museo from museos where nombre = 'Museo Nacional de Varsovia')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo Nacional de Varsovia'), 'Departamento de Educacion y Publico', 'DEPARTAMENTO', 2, 
'Responsables de los pogramas educativos la mediacion cultural y la accesibilidad',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion General' and id_museo = (select id_museo from museos where nombre = 'Museo Nacional de Varsovia')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo Nacional de Varsovia'), 'Departamento de Comunicacion', 'DEPARTAMENTO', 2, 
'Responsables de la prensa, publicaciones y patrocinios',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion General' and id_museo = (select id_museo from museos where nombre = 'Museo Nacional de Varsovia')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo Nacional de Varsovia'), 'Departamento de Administracion', 'DEPARTAMENTO', 2, 
'Recursos Humanos, finanzas, mantenimiento y seguridad',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion General' and id_museo = (select id_museo from museos where nombre = 'Museo Nacional de Varsovia')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo Nacional de Varsovia'), 'Seguridad y Proteccion', 'SECCION', 3, 
'SEGURIDAD DEL MUSEO Y CONTROL DE ACCESOS',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Departamento de Administracion' and id_museo = (select id_museo from museos where nombre = 'Museo Nacional de Varsovia')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia'), 
'Direccion', 'DIRECCION', 1, 'La maxima autoridad del museo, responsable de todos las areas y el l buen funcionamiento de la institucion',
NULL);
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia'), 'Departamento de Restauracion y Coleccion', 'DEPARTAMENTO', 2, 
'Encargados del mantenimiento y restauracion de las colecciones del museo',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion' and id_museo = (select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia'), 'Departamento de Educacion y Turismo', 'DEPARTAMENTO', 2, 
'Encargados de las visitas guiadas, paseos para escuelas y talleres educativos',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion' and id_museo = (select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia'), 'Departamento de Administracion y Mantenimiento', 'DEPARTAMENTO', 2, 
'Encargados de la administracion y los patrocinios, así como el mantenimiento de los jardines y palacios',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion' and id_museo = (select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES 
((select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia'), 'Departamento de Seguridad y Proteccion', 'DEPARTAMENTO', 2, 
'Encargados de la vigilancia, control de ingresos y prevencion de riesgos',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Direccion' and id_museo = (select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia')));
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia'), 'Mantenimiento', 'SECCION', 3, 
'Potreccion de los jardines y los palacios',
(select id_est_org from EST_ORGANIZACIONAL where NOMBRE = 'Departamento de Administracion y Mantenimiento' and id_museo = (select id_museo from museos where nombre = 'Museo de Nieborow y Arkadia')));

--INSERT EXPOSICIONES_EVENTOS
INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Galería Arte Oriental' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 'Caminos a Jerusalem', TO_DATE('28-06-2025', 'DD-MM-YYYY'), TO_DATE('30-06-2025', 'DD-MM-YYYY'), 10.00, NULL, NULL);
 INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Sala de Arte Decorativo' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Segunda Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 'Autoretrato', TO_DATE('07-06-2025', 'DD-MM-YYYY'), TO_DATE('14-06-2025', 'DD-MM-YYYY'), 8.00, NULL, NULL);

INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Vestibulo' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Planta Baja' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 'El Entretenimiento de Nuestros Ancestros', TO_DATE('07-06-2025', 'DD-MM-YYYY'), TO_DATE('07-06-2025', 'DD-MM-YYYY'), 6.00, 25, 'Szkoła Nieborów');
 INSERT INTO EXPOSICIONES_EVENTOS (id_sala, id_est, id_museo, nombre, fecha_inicio, fecha_fin, costo_persona, cant_visitantes, institucion_educativa) VALUES 
((SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Biblioteca' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Primera Planta' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 'La Extraordinaria Historia de la Biblioteca de Nieborow', TO_DATE('15-07-2025', 'DD-MM-YYYY'), TO_DATE('15-07-2025', 'DD-MM-YYYY'), 6.00, 25, 'Szkoła Nieborów');

--INSERT COLECCIONES_PERMANENTES 
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 'Colección de Arte Antiguo',
 'Registros artisticos arqueológicos de multipes partes del mundo',
 'Antiguo', 1);
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 'Colección de Arte Cristiano Oriental',
 'Arte cristiano oriental, de tendencia católica y ortodoxa',
 'Cristiano', 2);
 INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 'Colección de Arte Europeo Temprano',
 'RColección de Arte de varias partes de Europa desde el Siglo XV al XIX',
 'Renacimiento', 3);
 INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 'Colección de Pinturas Polacas hasta 1914',
 'Una colección de 7000 pinturas de origen polaco desde el Siglo XVI al XX',
 'Polacas', 4);
 INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 'Colección de Arte Moderno',
 'Selección de obras que se remontan de 1914 a la actualidad ',
 'Moderno', 5);
 INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 'Colección de Arte Decorativo',
 'Una colección de cerámicas, metales, cristales y muebles',
 'Decorativo', 6);
 INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
 'Colección de Arte Oriental',
 'Colección de arte japones, chino, indio, budista e islámico',
 'Oriental', 7);

 INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Restauracion y Coleccion' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 'El Vestibulo',
 'El vestibulo en sí mismo es una exhibición por ser una parte original del palacio, además cuenta con diferentes objetos de exposición que nos introducen a las familias que habitaron el palacio',
 'Vestibulo', 1);
 INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Restauracion y Coleccion' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 'Cuartos, Estudios y Biblioteca',
 'El primer piso es una exhibición completa de las habitaciones del palacio y sus objetos ',
 'Primer Piso', 2);
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Restauracion y Coleccion' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 'Objetos de la Familia Radziwill',
 'Objetos Personales, Pinturas, y miscelanea que perteneció a los habitantes del palacio',
 'Familia', 3);
 INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Restauracion y Coleccion' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 'Cuarto de la Princesa',
 'El cuarto de la princesa del palacio',
 'Princesa', 4);
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Restauracion y Coleccion' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 'La Armeria Nesvish',
 'Armaduras, armas, y otros objetos militares de época',
 'Armeria', 5);
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Restauracion y Coleccion' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 'Jardines Barrocos',
 'Los jardines barrocos del palacio de estilo frances',
 'Jardín', 6);
INSERT INTO COLECCIONES_PERMANENTES (id_est_org, id_museo, nombre, caracteristicas, palabra_clave, orden_recorrido) VALUES
((SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Restauracion y Coleccion' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
 'Parque Romantico de Arkadia',
 'El parque de estilo romántico diseñado por una de las habitantes del palacio',
 'Parque', 7);

-- INSERT_EMPLEADOS
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(33114385, 'Lukasz', 'Gawel', TO_DATE('1970-11-11', 'YYYY-MM-DD'), 48226211031, NULL, NULL); --Director 
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(33114386, 'Marcin', 'Romeyko', TO_DATE('1975-03-14', 'YYYY-MM-DD'), 48226230031, NULL, 'Hurko'); --Curador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(33114387, 'Aleksandra', 'Sulikowska', TO_DATE('1974-12-29', 'YYYY-MM-DD'), 48226211025, NULL, 'Belczowska'); --Curadora
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(33114388, 'Natalia', 'Kowalski', TO_DATE('1973-03-23', 'YYYY-MM-DD'), 48226211034, NULL, NULL); --Restauradora
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(33114389, 'Damian', 'Wojcik', TO_DATE('1965-04-20', 'YYYY-MM-DD'), 48229711031, 'Aleksandr', 'Nowak'); --Restaurador


INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(34114385, 'Agnieszka', 'Morawińska', TO_DATE('1944-06-29', 'YYYY-MM-DD'), 48468385635, NULL, NULL); --Directora
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(34114386, 'Monika', 'Antczak', TO_DATE('1968-06-28', 'YYYY-MM-DD'), 48469695635, NULL, NULL); --Curadora
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(34114387, 'Jan', 'Sienkiewicz', TO_DATE('1963-05-15', 'YYYY-MM-DD'), 48469699835, 'Karol', 'Ohanowicz'); --Curador
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(34114388, 'Lech', 'Agopsowicz', TO_DATE('1980-05-02', 'YYYY-MM-DD'), 48469345635, 'Sebastian', 'Chalembek');
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(34114389, 'Jadwiga', 'Mechaniów', TO_DATE('1991-09-12', 'YYYY-MM-DD'), 48464699835, 'Joanna', 'Fedoruk');


--INSERT FORMACIONES
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114385), 'Doctorado en Humanidades', 2001, 'En el Instituto de Estudios Polacos en la Universidad Jagellónica');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114386), 'Licenciatura en Curaduría en Artes', 2000, 'Narrativas contemporáneas en la curaduría de arte digital, Universidad de Varsovia');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114387), 'Licenciatura en Curaduría en Artes', 1998, 'El rol del curador en la revalorización del arte marginal en Polonia, Academia de Bellas Artes de Varsovia');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114388), 'Licenciatura en Restauración de Artes', 2005, 'Técnicas innovadoras en la restauración de pintura al óleo del siglo XIX, Universidad Jagellónica');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114389), 'Licenciatura en Restauración de Artes', 1999, 'Conservación preventiva de esculturas en espacios públicos: Caso estudio en Toruń, Universidad Nicolas Copernico');


INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114385), 'Doctorado en Humanidades', 1976, 'Instituto de Historia del Arte, Universidad de Varsovia');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114386), 'Licenciatura en Curaduría en Artes', 1995, 'Curaduría crítica y su impacto en la percepción del arte poscomunista, Universidad de Wroclaw');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114387), 'Licenciatura en Curaduría en Artes', 2002, 'Exhibiciones inmersivas: Estrategias curatoriales en la era postpandémica, Universidad de Adam Mickiewicz');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114388), 'Licenciatura en Restauración de Artes', 2006, 'Uso de nanotecnología en la restauración de cerámica arqueológica, Universidad de Arte de Szczecin');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114389), 'Licenciatura en Restauración de Artes', 2009, 'Recuperación de textiles históricos: Metodologías y desafíos éticos, Universidad de Lodz');

--INSERT IDIOMAS_EMPLEADOS
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114385), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114385), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114386), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114387), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114387), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Ruso'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114388), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114388), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Español'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 33114389), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));


INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114385), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114385), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114385), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114386), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114387), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114388), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114389), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Polaco'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 34114389), 
(SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));


--INSERT OBRAS
    --MUSEO NACIONAL DE VARSOVIA
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)  
VALUES (  
  'La Batalla De Grunwald',  
  TO_DATE('1878-01-01', 'YYYY-MM-DD'),  
  'PINTURA',  
  '426 x 987 cm',  
  'Óleo sobre lienzo. Matejko empleó capas gruesas de pintura (impasto) y detalles finos con pinceladas expresivas para crear dinamismo.',  
  'Pintura histórica del Romanticismo polaco. Representa la victoria polaco-lituana sobre los caballeros teutónicos en 1410, con dramatismo y simbolismo nacionalista.'  
);  
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)  
VALUES (  
  'Cristo En La Columna',  
  TO_DATE('1770-01-01', 'YYYY-MM-DD'),  
  'ESCULTURA',  
  '180 x 80 x 60 cm',  
  'Madera de tilo tallada y policromada, con ojos de vidrio. Técnica barroca de realismo anatómico y dorados en detalles.',  
  'Escultura barroca religiosa. Representa el sufrimiento de Cristo con intensidad emocional, típica del arte sacro polaco del siglo XVIII.'  
);  
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)  
VALUES (  
  'Extranjero',  
  TO_DATE('1902-01-01', 'YYYY-MM-DD'),  
  'PINTURA',  
  '100 x 70 cm',  
  'Óleo sobre cartón. Malczewski combinó pinceladas sueltas con símbolos detallados, usando veladuras para efectos atmosféricos.',  
  'Simbolismo polaco. La obra fusiona lo onírico con lo nacional, mostrando un viajero misterioso como alegoría de la identidad y el exilio.'  
);  
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)  
VALUES (  
  'Copernico',  
  TO_DATE('1822-01-01', 'YYYY-MM-DD'),  
  'ESCULTURA',  
  '275 x 120 x 120 cm',  
  'Mármol de Carrara tallado con precisión académica. Superficies pulidas y pliegues geométricos en la vestimenta.',  
  'Neoclasicismo. Retrato idealizado de Nicolás Copérnico, con influencia de la escultura romana antigua y énfasis en la razón científica.'  
);  
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Madonna De Krużlowa',
  TO_DATE('1410-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '96 x 66 cm',
  'Temple sobre madera de tilo. Técnica gótica con dorados al agua y pan de oro en fondos y detalles.',
  'Arte gótico religioso. Representa a la Virgen María con el Niño, de estilo suave y líneas curvilíneas, típico de la escuela polaca medieval.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Eros Bendato',
  TO_DATE('1999-01-01', 'YYYY-MM-DD'),
  'ESCULTURA',
  '300 x 200 x 150 cm',
  'Bronce fundido con pátina verde. Superficie fragmentada y texturizada, mezclando clasicismo y deconstrucción.',
  'Arte contemporáneo neoclásico. Reinterpretación de la mitología griega con rostros vendados, simbolizando el amor ciego y la fragilidad humana.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'El Judío Errante',
  TO_DATE('1905-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '150 x 100 cm',
  'Óleo sobre lienzo. Uso de veladuras y contrastes lumínicos para crear dramatismo.',
  'Simbolismo polaco. Alegoría del exilio y la identidad judía, con tonos melancólicos y figuras fantasmales.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Reina Jadwiga',
  TO_DATE('1930-01-01', 'YYYY-MM-DD'),
  'ESCULTURA',
  '220 x 80 x 60 cm',
  'Madera de roble tallada y policromada. Estilización geométrica típica del Art Déco.',
  'Art Déco polaco. Retrato idealizado de la reina Jadwiga, combinando tradición medieval y modernidad.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Autorretrato Con Paleta',
  TO_DATE('1896-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '60 x 45 cm',
  'Óleo sobre cartón. Pinceladas sueltas y empastadas, con predominio de tonos neutros y grises.',
  'Impresionismo y realismo psicológico. Boznańska explora la introspección y la identidad femenina en el arte.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Torso De Mujer',
  TO_DATE('1968-01-01', 'YYYY-MM-DD'),
  'ESCULTURA',
  '50 x 30 x 20 cm',
  'Resina de poliéster y fibra de vidrio. Superficie lisa con fragmentos corporales distorsionados.',
  'Arte vanguardista. Explora el cuerpo femenino desde una perspectiva surrealista y existencial.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Vista De Varsovia Desde Praga',
  TO_DATE('1770-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '120 x 170 cm',
  'Óleo sobre lienzo. Perspectiva lineal precisa y detalles arquitectónicos minuciosos.',
  'Vedutismo rococó. Documenta la ciudad de Varsovia en el siglo XVIII con rigor topográfico y luz diáfana.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'El Esclavo',
  TO_DATE('1910-01-01', 'YYYY-MM-DD'),
  'ESCULTURA',
  '180 x 70 x 50 cm',
  'Bronce con texturas rugosas. Volúmenes distorsionados para expresar angustia.',
  'Expresionismo. Representa la opresión humana con formas brutas y emocionales.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Niña Con Crisantemos',
  TO_DATE('1884-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '90 x 60 cm',
  'Óleo sobre lienzo. Técnica académica con detalles en flores y rostro.',
  'Realismo polaco. Retrato infantil con simbolismo floral, reflejando pureza y melancolía.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Forma Espacial',
  TO_DATE('1928-01-01', 'YYYY-MM-DD'),
  'ESCULTURA',
  '40 x 40 x 40 cm',
  'Metal (acero y aluminio) ensamblado. Estructuras geométricas abstractas.',
  'Constructivismo. Obra pionera del arte abstracto, integrando espacio y movimiento.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'El Rabino',
  TO_DATE('1878-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '100 x 70 cm',
  'Óleo sobre lienzo. Claroscuro y detalles realistas en rostro y vestimenta.',
  'Romanticismo judío. Fusiona identidad religiosa con retrato psicológico profundo.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Stańczyk',
  TO_DATE('1862-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '88 x 120 cm',
  'Óleo sobre lienzo. Matejko empleó veladuras y contrastes de luz para destacar el rostro del bufón, con detalles minuciosos en los objetos del fondo.',
  'Pintura histórica del Romanticismo polaco. Representa al bufón real Stańczyk en un momento de reflexión melancólica, simbolizando la crítica a la decadencia política del Reino de Polonia en el siglo XVI.'
);

--Museo de Nieborow y Arkadia 
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Retrato De Helena Radziwiłł',
  TO_DATE('1790-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '90 x 70 cm',
  'Óleo sobre lienzo. Técnica academicista con detalles en los encajes y joyas. Fondos oscuros para resaltar la figura.',
  'Retrato cortesano del Clasicismo. Representa a Helena Radziwiłł con elegancia aristocrática, típica de la nobleza polaco-lituana.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Diana Cazadora',
  TO_DATE('1750-01-01', 'YYYY-MM-DD'),
  'ESCULTURA',
  '150 x 60 x 50 cm',
  'Mármol blanco de Carrara tallado. Superficie pulida con detalles anatómicos precisos en el rostro y el arco.',
  'Escultura neoclásica. Representación mitológica de Diana, diosa de la caza, con influencia de modelos grecorromanos.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Vista Del Palacio De Nieborów',
  TO_DATE('1800-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '45 x 60 cm',
  'Acuarela sobre papel. Perspectiva arquitectónica precisa y colores suaves para captar la luz.',
  'Vedutismo romántico. Documenta el palacio barroco de Nieborów, residencia de los Radziwiłł, con jardines simétricos.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Escritorio De Ébano Con Incrustaciones',
  TO_DATE('1780-01-01', 'YYYY-MM-DD'),
  'ESCULTURA', 
  '120 x 80 x 60 cm',
  'Madera de ébano con incrustaciones de marfil y nácar. Patas talladas en forma de garras de león.',
  'Estilo Luis XVI. Mueble de lujo con motivos florales y geométricos, perteneciente a la colección Radziwiłł.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Jardines De Arkadia',
  TO_DATE('1820-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '70 x 100 cm',
  'Óleo sobre tabla. Pinceladas libres y colores pastel para capturar la atmósfera bucólica.',
  'Paisajismo romántico. Representa el jardín inglés de Arkadia, diseñado como un paraíso mitológico con templos y estanques.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Sátiro Durmiente',
  TO_DATE('1770-01-01', 'YYYY-MM-DD'),
  'ESCULTURA',
  '80 x 50 x 40 cm',
  'Mármol rosado de Verona. Texturas contrastadas entre la piel pulida y la base rústica.',
  'Barroco tardío. Figura mitológica que combina elegancia clásica con un toque de sensualidad.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Bodegón Con Frutas Y Flores',
  TO_DATE('1795-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '50 x 40 cm',
  'Óleo sobre cobre. Detalles hiperrealistas en pétalos y frutas, con fondos oscuros.',
  'Naturaleza muerta neoclásica. Influencia de la escuela francesa, con simbolismo de abundancia y fugacidad.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Reloj De Bronce Dorado',
  TO_DATE('1810-01-01', 'YYYY-MM-DD'),
  'ESCULTURA', -- *Ajusta si necesitas otra categoría.
  '60 x 30 x 20 cm',
  'Bronce fundido y dorado con motivos de hojas de acanto. Esfera de porcelana pintada a mano.',
  'Estilo Imperio. Pieza de lujo con figuras alegóricas al tiempo, típica de la decoración palaciega.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Retrato De Michał Hieronim Radziwiłł',
  TO_DATE('1785-01-01', 'YYYY-MM-DD'),
  'PINTURA',
  '200 x 120 cm',
  'Óleo sobre lienzo. Uso de brocados aplicados en oro para los detalles del vestido.',
  'Retrato barroco. Muestra al magnate con atributos de poder: armadura, libros y mapas de sus tierras.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)
VALUES (
  'Fuente De Neptuno',
  TO_DATE('1760-01-01', 'YYYY-MM-DD'),
  'ESCULTURA',
  '300 x 150 x 150 cm',
  'Piedra arenisca tallada y parcialmente policromada. Base con conchas y motivos marinos.',
  'Barroco tardío. Escultura funcional para los jardines, mezclando mitología y arte decorativo.'
);
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)  
VALUES (  
  'El Sueño De La Doncella',  
  TO_DATE('1780-01-01', 'YYYY-MM-DD'),  
  'PINTURA',  
  '65 x 50 cm',  
  'Óleo sobre lienzo. Técnica de veladuras para crear efectos atmosféricos y luz tenue. Pinceladas suaves en los rostros.',  
  'Rococó tardío. Escena pastoral que idealiza la vida campesina, con influencia de Watteau y Fragonard.'  
);  
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos)  
VALUES (  
  'Cupido Jugando Con Un Cisne',  
  TO_DATE('1775-01-01', 'YYYY-MM-DD'),  
  'ESCULTURA',  
  '45 x 30 x 25 cm',  
  'Porcelana de Sèvres pintada a mano. Detalles dorados con pan de oro y esmaltes vítreos.',  
  'Neoclasicismo francés. Figura mitológica que combina elegancia y juego, típica de la decoración de salones nobles.'  
);  


--INSERT ARTISTAS
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintor histórico polaco, maestro del Romanticismo. Sus obras glorifican la historia de Polonia con dramatismo y simbolismo patriótico.',
  'Jan',
  NULL,
  'Matejko',
  NULL,
  TO_DATE('1838-06-24', 'YYYY-MM-DD'),
  TO_DATE('1893-11-01', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Cracovia')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Escultor barroco polaco de origen alemán. Especializado en arte sacro, con obras realistas y emotivas para iglesias y palacios.',
  'Jan',
  'Jerzy',
  'Plersch',
  NULL,
  TO_DATE('1704-01-01', 'YYYY-MM-DD'),
  TO_DATE('1774-01-01', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Viena')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintor simbolista polaco. Fusionó temas nacionales con elementos oníricos y alegóricos, explorando el exilio y la identidad.',
  'Jacek',
  NULL,
  'Malczewski',
  NULL,
  TO_DATE('1854-07-15', 'YYYY-MM-DD'),
  TO_DATE('1929-10-08', 'YYYY-MM-DD'),
  NULL,(SELECT id_lugar FROM LUGARES WHERE nombre = 'Radom')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Escultor danés del Neoclasicismo. Trabajó en Roma y Polonia, creando retratos idealizados con influencia grecorromana.',
  'Bertel',
  NULL,
  'Thorvaldsen',
  NULL,
  TO_DATE('1770-11-19', 'YYYY-MM-DD'),
  TO_DATE('1844-03-24', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Copenhague')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Escultor polaco contemporáneo. Reconocido por reinterpretar la mitología clásica con figuras fragmentadas y rostros vendados.',
  'Igor',
  NULL,
  'Mitoraj',
  NULL,
  TO_DATE('1944-03-26', 'YYYY-MM-DD'),
  TO_DATE('2014-10-06', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Oederan')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintor italiano activo en Polonia. Retratista oficial de la corte del rey Estanislao Augusto Poniatowski.',
  'Marcello',
  NULL,
  'Bacciarelli',
  NULL,
  TO_DATE('1731-02-16', 'YYYY-MM-DD'),
  TO_DATE('1818-01-05', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Roma')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintor y dibujante polaco, pionero de la veduta. Documentó arquitectura y paisajes con precisión topográfica.',
  'Zygmunt',
  NULL,
  'Vogel',
  NULL,
  TO_DATE('1764-06-15', 'YYYY-MM-DD'),
  TO_DATE('1826-04-20', 'YYYY-MM-DD'),
  'Ptaszek', (SELECT id_lugar FROM LUGARES WHERE nombre = 'Wolczyn')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintora polaca, una de las primeras mujeres en destacar en el arte profesional. Discípula de Jacques-Louis David.',
  'Anna',
  NULL,
  'Rajecka',
  NULL,
  TO_DATE('1762-01-01', 'YYYY-MM-DD'),
  TO_DATE('1832-01-01', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Varsovia')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintor italiano especializado en escenas bélicas y pastorales. Hermano del famoso aventurero Giacomo Casanova.',
  'Francesco',
  NULL,
  'Casanova',
  NULL,
  TO_DATE('1727-05-01', 'YYYY-MM-DD'),
  TO_DATE('1803-07-08', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Londres')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintor austriaco de retratos cortesanos, activo en Polonia. Destacó por su estilo neoclásico y representaciones elegantes de la nobleza polaca.',
  'Józef',
  NULL,
  'Grassi',
  NULL,
  TO_DATE('1757-04-22', 'YYYY-MM-DD'),
  TO_DATE('1838-01-07', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Viena')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintor y grabador francopolaco, pionero del Romanticismo en Polonia. Retrató escenas costumbristas y paisajes con sensibilidad prerromántica.',
  'Jan',
  'Piotr',
  'Norblin',
  NULL,
  TO_DATE('1745-07-15', 'YYYY-MM-DD'),
  TO_DATE('1830-02-23', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Misy-Sur-Yonne')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Escultor Ucraniano de origen polaco, director de la escuela de artes decorativas y pinturas de varsovia',
  'Jan', NULL,
  'Szczepkowski',
  NULL,
  TO_DATE('1878-03-08', 'YYYY-MM-DD'),
  TO_DATE('1964-02-17', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Ivano-Frankivsk')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintor polaco conocido principalmente por sus retratos, aunque produjo obras en una amplia variedad de géneros',
  'Kazimierz', 'Teofil',
  'Pochwalski',
  NULL,
  TO_DATE('1855-12-25', 'YYYY-MM-DD'),
  TO_DATE('1940-11-07', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Cracovia')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Escultor polaco, activo a principios del siglo XX. Su larga carrera produjo muchas obras de arte famosas, incluidos varios monumentos públicos de renombre en su país natal, Polonia.',
  'Henryk', NULL,
  'Kuna',
  NULL,
  TO_DATE('1885-01-01', 'YYYY-MM-DD'),
  TO_DATE('1945-12-17', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Varsovia')
);
 INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Pintora Polaca de retratos',
  'Olga', NULL,
  'Boznańska',
  NULL,
  TO_DATE('1865-04-15', 'YYYY-MM-DD'),
  TO_DATE('1940-10-26', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Cracovia')
);
INSERT INTO ARTISTAS (resumen_caracteristicas, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_difuncion, apodo, id_lugar)
VALUES (
  'Fue un destacado pinto Judeo-Polaco',
  'Maurycy', NULL,
  'Gottlieb',
  NULL,
  TO_DATE('1856-01-01', 'YYYY-MM-DD'),
  TO_DATE('1979-07-17', 'YYYY-MM-DD'),
  NULL, (SELECT id_lugar FROM LUGARES WHERE nombre = 'Drohobich')
);

--INSERT ARTISTAS_OBRA
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'La Batalla De Grunwald'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jan' AND primer_apellido = 'Matejko'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Stańczyk'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jan' AND primer_apellido = 'Matejko'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Cristo En La Columna'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jan' AND primer_apellido = 'Plersch'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Extranjero'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jacek' AND primer_apellido = 'Malczewski'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Copernico'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Bertel' AND primer_apellido = 'Thorvaldsen'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Eros Bendato'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Igor' AND primer_apellido = 'Mitoraj'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Retrato De Helena Radziwiłł'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Marcello' AND primer_apellido = 'Bacciarelli'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Vista Del Palacio De Nieborów'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Zygmunt' AND primer_apellido = 'Vogel'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Bodegón Con Frutas Y Flores'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Anna' AND primer_apellido = 'Rajecka'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'El Sueño De La Doncella'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Francesco' AND primer_apellido = 'Casanova'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Retrato De Michał Hieronim Radziwiłł'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Józef' AND primer_apellido = 'Grassi'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Jardines De Arkadia'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jan' AND primer_apellido = 'Norblin'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Reina Jadwiga'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Jan' AND primer_apellido = 'Szczepkowski'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Autorretrato Con Paleta'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Kazimierz' AND primer_apellido = 'Pochwalski'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Torso De Mujer'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Henryk' AND primer_apellido = 'Kuna'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Niña Con Crisantemos'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Olga' AND primer_apellido = 'Boznańska'));
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'El Rabino'), 
(SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Maurycy' AND primer_apellido = 'Gottlieb'));

--INSERT HIST_OBRA_MOV
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Copernico'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Moderno' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Europeo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1830-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 1, NULL); --ARTE MODERNO
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'La Batalla De Grunwald'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Pinturas Polacas hasta 1914' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería de Arte del Siglo XIX' AND ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1893-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, NULL, NULL); --ARTE POLACO PASADO
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Cristo En La Columna'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Europeo Temprano' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Europeo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1890-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, NULL, NULL); --ARTE EUROPEO CLÁSICO
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Extranjero'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Pinturas Polacas hasta 1914' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería de Arte del Siglo XIX' AND ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1920-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL);
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Madonna De Krużlowa'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Cristiano Oriental' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Arte Medieval' AND ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1900-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'NO', NULL, NULL, NULL); --ARTE CRISTIANO
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Eros Bendato'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Moderno' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Europeo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('2014-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 1, NULL); 
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Stańczyk'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Pinturas Polacas hasta 1914' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería de Arte del Siglo XIX' AND ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1862-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, NULL, NULL); 
    --ESCULTURA
    INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Reina Jadwiga'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Moderno' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Moderno' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1935-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 1, NULL); 
     INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Torso De Mujer'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Moderno' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Moderno' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1920-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'NO', NULL, NULL, NULL); 
     INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Esclavo'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Europeo Temprano' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Europeo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1916-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL); 
       INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Forma Espacial'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Moderno' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Moderno' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1932-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL); 

    --PINTURA
    INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Judío Errante'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Moderno' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Moderno' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('2008-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', TO_DATE('2026-01-01', 'YYYY-MM-DD'), NULL, NULL);
     INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Autorretrato Con Paleta'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Pinturas Polacas hasta 1914' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería de Arte del Siglo XIX' AND ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1982-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL);
    INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Vista De Varsovia Desde Praga'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Europeo Temprano' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Europeo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1960-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL);
      INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Niña Con Crisantemos'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Pinturas Polacas hasta 1914' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería de Arte del Siglo XIX' AND ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('2025-06-01', 'YYYY-MM-DD'), 
    'COMPRADA A MUSEO', 'NO', NULL, NULL, NULL);
         INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Rabino'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Pinturas Polacas hasta 1914' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería de Arte del Siglo XIX' AND ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'), 
    TO_DATE('1956-08-09', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL);

    --NIEBOROW ARKADIA
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Sátiro Durmiente'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Jardines Barrocos' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Jardin Barroco de Nieborow' AND ef.nombre = 'Jardin Barroco de Nieborow' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Jardin Barroco de Nieborow' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1850-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL); 
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Bodegón Con Frutas Y Flores'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Objetos de la Familia Radziwill' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Estudio Amarillo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1801-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'NO', NULL, NULL, NULL); 
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Sueño De La Doncella'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Objetos de la Familia Radziwill' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Estudio Amarillo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1862-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL); 
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Retrato De Helena Radziwiłł'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Objetos de la Familia Radziwill' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Cuarto de Dibujo Rojo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1790-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, NULL, NULL); 
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Fuente De Neptuno'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Parque Romantico de Arkadia' AND ef.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1760-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 1, NULL); 
    --ESCULTURA
    INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Diana Cazadora'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Parque Romantico de Arkadia' AND ef.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1760-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 2, NULL); 
    INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Cupido Jugando Con Un Cisne'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Parque Romantico de Arkadia' AND ef.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1760-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 3, NULL); 
     INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Escritorio De Ébano Con Incrustaciones'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Cuartos, Estudios y Biblioteca' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Cuarto de Dibujo Rojo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1780-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL); 
     INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Reloj De Bronce Dorado'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Cuartos, Estudios y Biblioteca' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'La Biblioteca' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114386), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1810-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL); 
    --PINTURA
    INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Vista Del Palacio De Nieborów'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Objetos de la Familia Radziwill' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Estudio Amarillo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1800-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, NULL, NULL); 
    INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Jardines De Arkadia'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Objetos de la Familia Radziwill' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Estudio Amarillo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1820-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, NULL, NULL); 
    INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Retrato De Michał Hieronim Radziwiłł'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Objetos de la Familia Radziwill' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Estudio Amarillo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114387), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'), 
    TO_DATE('1785-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, NULL, NULL);

--INSERT HIST_EMPLEADO
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-01-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Direccion General' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114385),
 'DIRECTOR',
 NULL);
 INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-01-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Conservacion y Restauracion' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114386),
 'CURADOR',
 NULL);
 INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2023-02-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Conservacion y Restauracion' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114387),
 'CURADOR',
 NULL);
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2023-12-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Conservacion y Restauracion' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114388),
 'RESTAURADOR',
 NULL);
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2020-02-09', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Conservacion y Restauracion' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389),
 'RESTAURADOR',
 NULL);
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2010-10-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Direccion General' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114385),
 'DIRECTOR',
 TO_DATE('2018-05-01', 'YYYY-MM-DD'));


INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-06-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Direccion' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114385),
 'DIRECTOR', NULL);
 INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-08-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114386),
 'CURADOR', NULL);
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2010-09-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114387),
 'CURADOR', NULL);
 INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-08-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114388),
 'RESTAURADOR', NULL);
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2012-11-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114389),
 'RESTAURADOR', NULL);


--INSERT PROGRAMAS_MANT
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Eros Bendato' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Eros Bendato'),
    'Limpieza y revisión de la escultura',
    'Semestral',
    'RESTAURADOR'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Copernico' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Copernico'),
    'Limpieza y revisión de la escultura',
    'Semestral',
    'RESTAURADOR'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'La Batalla De Grunwald' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'La Batalla De Grunwald'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Stańczyk' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Stańczyk'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Cristo En La Columna' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Cristo En La Columna'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Extranjero' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Extranjero'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR'
);
 --ESCULTURA
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'Reina Jadwiga' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Reina Jadwiga'),
    'Limpieza y revisión de la escultura',
    'Semestral',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'Torso De Mujer' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Torso De Mujer'),
    'Limpieza y revisión de la escultura',
    'Semestral',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'El Esclavo' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Esclavo'),
    'Limpieza y revisión de la escultura',
    'Semestral',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'Forma Espacial' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Forma Espacial'),
    'Limpieza y revisión de la escultura',
    'Semestral',
    'RESTAURADOR');
    --PINTURA
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'El Judío Errante' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Judío Errante'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'Autorretrato Con Paleta' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Autorretrato Con Paleta'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'Vista De Varsovia Desde Praga' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Vista De Varsovia Desde Praga'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'Niña Con Crisantemos' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Niña Con Crisantemos'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'El Rabino' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Rabino'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR');

--NIEBOROW Y ARKADIA
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Sátiro Durmiente' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Sátiro Durmiente'),
    'Limpieza de la escultura, revision de sus materiales, correccion de imperfecciones',
    'Mensual',
    'RESTAURADOR'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Fuente De Neptuno' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Fuente De Neptuno'),
    'Limpieza de la escultura, revision de sus materiales, correccion de imperfecciones',
    'Mensual',
    'RESTAURADOR'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Bodegón Con Frutas Y Flores' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Bodegón Con Frutas Y Flores'),
    'Revision de deterioro, labores de conservacion y limpieza interna del marco',
    'Semestral',
    'RESTAURADOR'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Retrato De Helena Radziwiłł' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Retrato De Helena Radziwiłł'),
    'Revision de deterioro, labores de conservacion y limpieza interna del marco',
    'Semestral',
    'RESTAURADOR'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'El Sueño De La Doncella' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Sueño De La Doncella'),
    'Revision de deterioro, labores de conservacion y limpieza interna del marco',
    'Semestral',
    'RESTAURADOR'
);
--ESCULTURA
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo
    WHERE o.nombre = 'Cupido Jugando Con Un Cisne' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Cupido Jugando Con Un Cisne'),
    'Limpieza de la escultura, revision de sus materiales, correccion de imperfecciones',
    'Mensual',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo
    WHERE o.nombre = 'Reloj De Bronce Dorado' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Reloj De Bronce Dorado'),
    'Limpieza de la escultura, revision de sus materiales, correccion de imperfecciones',
    'Mensual',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo
    WHERE o.nombre = 'Escritorio De Ébano Con Incrustaciones' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Escritorio De Ébano Con Incrustaciones'),
    'Limpieza de la escultura, revision de sus materiales, correccion de imperfecciones',
    'Mensual',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo
    WHERE o.nombre = 'Diana Cazadora' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Diana Cazadora'),
    'Limpieza de la escultura, revision de sus materiales, correccion de imperfecciones',
    'Mensual',
    'RESTAURADOR');
    --PINTURA
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'Vista Del Palacio De Nieborów' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Vista Del Palacio De Nieborów'),
    'Revision de deterioro, labores de conservacion y limpieza interna del marco',
    'Semestral',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'Jardines De Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Jardines De Arkadia'),
    'Revision de deterioro, labores de conservacion y limpieza interna del marco',
    'Semestral',
    'RESTAURADOR');
    INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo 
    WHERE o.nombre = 'Retrato De Michał Hieronim Radziwiłł' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Retrato De Michał Hieronim Radziwiłł'),
    'Revision de deterioro, labores de conservacion y limpieza interna del marco',
    'Semestral',
    'RESTAURADOR');



--INSERT MANTENIMIENTOS_OBRAS_REALIZADOS
--MUSEO DE VARSOVIA
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, 
    id_catalogo, 
    id_obra, 
    id_empleado, 
    fecha_inicio, 
    fecha_fin, 
    observaciones
) VALUES (
    (SELECT pm.id_mant 
     FROM PROGRAMAS_MANT pm 
     JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Copernico' 
     AND pm.actividad LIKE 'Limpieza y revisión%' 
     AND pm.id_catalogo = (
         SELECT hom.id_catalogo_museo 
         FROM HIST_OBRAS_MOV hom 
         JOIN MUSEOS m ON hom.id_museo = m.id_museo 
         WHERE hom.id_obra = o.id_obra 
         AND m.nombre = 'Museo Nacional de Varsovia' 
         AND ROWNUM = 1
     )),
    (SELECT hom.id_catalogo_museo 
     FROM HIST_OBRAS_MOV hom 
     JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Copernico' 
     AND m.nombre = 'Museo Nacional de Varsovia' 
     AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Copernico'),  -- Cambiado a 'Copernico' para consistencia
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114388), 
    TO_DATE('2025-06-15', 'YYYY-MM-DD'),
    TO_DATE('2025-06-22', 'YYYY-MM-DD'),
    'Sin novedades, procedimiento realizado sin cambios relevantes, la escultura se conserva en buen estado'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Eros Bendato' AND pm.actividad LIKE 'Limpieza y revisión%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Eros Bendato' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Eros Bendato'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114388), 
    TO_DATE('2025-07-15', 'YYYY-MM-DD'),
    TO_DATE('2025-07-22', 'YYYY-MM-DD'),
    'Sin novedades, procedimiento realizado sin cambios relevantes, la escultura se conserva en buen estado'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'La Batalla De Grunwald' AND pm.actividad LIKE 'Revisión de los materiales%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'La Batalla De Grunwald' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'La Batalla De Grunwald'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-07-22', 'YYYY-MM-DD'), NULL,
    'Maravillosa obra, no requiere de labores mayores, aún así se está realizando una inspección minuciosa'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Stańczyk' AND pm.actividad LIKE 'Revisión de los materiales%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Stańczyk' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Stańczyk'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-22', 'YYYY-MM-DD'),
    'La pintura requirió de retoques menores'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Cristo En La Columna' AND pm.actividad LIKE 'Revisión de los materiales%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Cristo En La Columna' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Cristo En La Columna'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-01-30', 'YYYY-MM-DD'), TO_DATE('2025-02-07', 'YYYY-MM-DD'),
    'La pintura requirió de retoques menores, un trabajo fantástico'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Extranjero' AND pm.actividad LIKE 'Revisión de los materiales%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Extranjero' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Extranjero'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-01-30', 'YYYY-MM-DD'), TO_DATE('2025-02-07', 'YYYY-MM-DD'),
    'La pintura requirió de un trabajo preciso por ciertas áreas deterioradas, buen trabajo'
);
INSERT INTO PROGRAMAS_MANT (id_catalogo, id_obra, actividad, frecuencia, tipo_responsable) VALUES (
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Madonna De Krużlowa' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Madonna De Krużlowa'),
    'Revisión de los materiales, control de deterioro, mantenimiento de marco',
    'Anual',
    'RESTAURADOR'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Madonna De Krużlowa' AND pm.actividad LIKE 'Revisión de los materiales%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Madonna De Krużlowa' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Madonna De Krużlowa'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-07-30', 'YYYY-MM-DD'), TO_DATE('2025-08-07', 'YYYY-MM-DD'),
    'La pintura requirió de un trabajo preciso por ciertas áreas deterioradas, buen trabajo'
);
 --ESCULTURA
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, 
    id_catalogo, 
    id_obra, 
    id_empleado, 
    fecha_inicio, 
    fecha_fin, 
    observaciones
) VALUES (
    (SELECT pm.id_mant 
     FROM PROGRAMAS_MANT pm 
     JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Reina Jadwiga' 
     AND pm.actividad LIKE 'Limpieza y revisión%' 
     AND pm.id_catalogo = (
         SELECT hom.id_catalogo_museo 
         FROM HIST_OBRAS_MOV hom 
         JOIN MUSEOS m ON hom.id_museo = m.id_museo 
         WHERE hom.id_obra = o.id_obra 
         AND m.nombre = 'Museo Nacional de Varsovia' 
         AND ROWNUM = 1
     )),
    (SELECT hom.id_catalogo_museo 
     FROM HIST_OBRAS_MOV hom 
     JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Reina Jadwiga'
     AND m.nombre = 'Museo Nacional de Varsovia' 
     AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Reina Jadwiga'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114388), 
    TO_DATE('2025-03-10', 'YYYY-MM-DD'),
    TO_DATE('2025-03-17', 'YYYY-MM-DD'),
    'Limpieza superficial realizada con éxito. La policromía de madera se conserva estable sin necesidad de intervención adicional.');

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, 
    id_catalogo, 
    id_obra, 
    id_empleado, 
    fecha_inicio, 
    fecha_fin, 
    observaciones
) VALUES (
    (SELECT pm.id_mant 
     FROM PROGRAMAS_MANT pm 
     JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Torso De Mujer' 
     AND pm.actividad LIKE 'Limpieza y revisión%' 
     AND pm.id_catalogo = (
         SELECT hom.id_catalogo_museo 
         FROM HIST_OBRAS_MOV hom 
         JOIN MUSEOS m ON hom.id_museo = m.id_museo 
         WHERE hom.id_obra = o.id_obra 
         AND m.nombre = 'Museo Nacional de Varsovia' 
         AND ROWNUM = 1
     )),
    (SELECT hom.id_catalogo_museo 
     FROM HIST_OBRAS_MOV hom 
     JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Torso De Mujer'
     AND m.nombre = 'Museo Nacional de Varsovia' 
     AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Torso De Mujer'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114388), 
    TO_DATE('2025-05-05', 'YYYY-MM-DD'),
    TO_DATE('2025-05-12', 'YYYY-MM-DD'),
    'Revisión de estructura en resina de poliéster. No se detectaron microfisuras. Limpieza con disolvente suave aplicada correctamente.');

INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, 
    id_catalogo, 
    id_obra, 
    id_empleado, 
    fecha_inicio, 
    fecha_fin, 
    observaciones
) VALUES (
    (SELECT pm.id_mant 
     FROM PROGRAMAS_MANT pm 
     JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'El Esclavo' 
     AND pm.actividad LIKE 'Limpieza y revisión%' 
     AND pm.id_catalogo = (
         SELECT hom.id_catalogo_museo 
         FROM HIST_OBRAS_MOV hom 
         JOIN MUSEOS m ON hom.id_museo = m.id_museo 
         WHERE hom.id_obra = o.id_obra 
         AND m.nombre = 'Museo Nacional de Varsovia' 
         AND ROWNUM = 1
     )),
    (SELECT hom.id_catalogo_museo 
     FROM HIST_OBRAS_MOV hom 
     JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'El Esclavo'
     AND m.nombre = 'Museo Nacional de Varsovia' 
     AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Esclavo'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114388), 
    TO_DATE('2025-08-20', 'YYYY-MM-DD'),
    TO_DATE('2025-08-27', 'YYYY-MM-DD'),
    'Mantenimiento rutinario al bronce. Se aplicó protección contra oxidación. La pátina verde original se mantiene en óptimas condiciones.');
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, 
    id_catalogo, 
    id_obra, 
    id_empleado, 
    fecha_inicio, 
    fecha_fin, 
    observaciones
) VALUES (
    (SELECT pm.id_mant 
     FROM PROGRAMAS_MANT pm 
     JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Forma Espacial' 
     AND pm.actividad LIKE 'Limpieza y revisión%' 
     AND pm.id_catalogo = (
         SELECT hom.id_catalogo_museo 
         FROM HIST_OBRAS_MOV hom 
         JOIN MUSEOS m ON hom.id_museo = m.id_museo 
         WHERE hom.id_obra = o.id_obra 
         AND m.nombre = 'Museo Nacional de Varsovia' 
         AND ROWNUM = 1
     )),
    (SELECT hom.id_catalogo_museo 
     FROM HIST_OBRAS_MOV hom 
     JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Forma Espacial'
     AND m.nombre = 'Museo Nacional de Varsovia' 
     AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Forma Espacial'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114388), 
    TO_DATE('2025-11-15', 'YYYY-MM-DD'),
    TO_DATE('2025-11-22', 'YYYY-MM-DD'),
    'Limpieza de estructura metálica con compuesto antistático. Ensamblajes revisados: todos los componentes están firmes. Obra en estado estable.');
    --PINTURA

-- 2. Para 'El Judío Errante'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'El Judío Errante' AND pm.actividad LIKE 'Revisión de los materiales%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'El Judío Errante' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Judío Errante'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-02-10', 'YYYY-MM-DD'), TO_DATE('2025-02-17', 'YYYY-MM-DD'),
    'Análisis de veladuras al óleo: los contrastes lumínicos se mantienen intactos. Se aplicó protección UV al marco original.'
);

-- 3. Para 'Autorretrato Con Paleta'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Autorretrato Con Paleta' AND pm.actividad LIKE 'Revisión de los materiales%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Autorretrato Con Paleta' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Autorretrato Con Paleta'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-04-05', 'YYYY-MM-DD'), TO_DATE('2025-04-12', 'YYYY-MM-DD'),
    'Revisión del óleo sobre cartón: las pinceladas empastadas muestran estabilidad. Control de humedad en vitrina realizado con éxito.'
);

-- 4. Para 'Vista De Varsovia Desde Praga'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Vista De Varsovia Desde Praga' AND pm.actividad LIKE 'Revisión de los materiales%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Vista De Varsovia Desde Praga' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Vista De Varsovia Desde Praga'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-06-18', 'YYYY-MM-DD'), TO_DATE('2025-06-25', 'YYYY-MM-DD'),
    'Limpieza de óleo sobre lienzo: detalles arquitectónicos revisados con lupa binocular. Se corrigió tensión del bastidor.'
);

-- 5. Para 'Niña Con Crisantemos'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Niña Con Crisantemos' AND pm.actividad LIKE 'Revisión de los materiales%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Niña Con Crisantemos' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Niña Con Crisantemos'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-09-03', 'YYYY-MM-DD'), TO_DATE('2025-09-10', 'YYYY-MM-DD'),
    'Análisis de craquelado: los pigmentos florales se conservan sin alteraciones. Marco dorado limpiado con técnica no invasiva.'
);

-- 6. Para 'El Rabino'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'El Rabino' AND pm.actividad LIKE 'Revisión de los materiales%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'El Rabino' AND m.nombre = 'Museo Nacional de Varsovia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Rabino'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 33114389), 
    TO_DATE('2025-11-07', 'YYYY-MM-DD'), TO_DATE('2025-11-14', 'YYYY-MM-DD'),
    'Revisión del claroscuro: estudio con luz rasante confirma integridad de las capas pictóricas. Vestimenta ritual en perfecto estado.');


--NIEBOROW Y ARKADIA
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Sátiro Durmiente' AND pm.actividad LIKE 'Limpieza de la escultura%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Sátiro Durmiente' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Sátiro Durmiente'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114388), 
    TO_DATE('2025-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-22', 'YYYY-MM-DD'),
    'Se realizaron las labores con éxito'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Fuente De Neptuno' AND pm.actividad LIKE 'Limpieza de la escultura%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Fuente De Neptuno' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Fuente De Neptuno'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114388), 
    TO_DATE('2025-02-18', 'YYYY-MM-DD'), TO_DATE('2025-02-25', 'YYYY-MM-DD'),
    'Se realizaron las labores con éxito'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Bodegón Con Frutas Y Flores' AND pm.actividad LIKE 'Revision de deterioro%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Bodegón Con Frutas Y Flores' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Bodegón Con Frutas Y Flores'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114389), 
    TO_DATE('2025-06-15', 'YYYY-MM-DD'), TO_DATE('2025-06-21', 'YYYY-MM-DD'),
    'Trabajo finalizado sin complicaciones'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'Retrato De Helena Radziwiłł' AND pm.actividad LIKE 'Revision de deterioro%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'Retrato De Helena Radziwiłł' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Retrato De Helena Radziwiłł'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114389), 
    TO_DATE('2025-04-18', 'YYYY-MM-DD'), TO_DATE('2025-04-25', 'YYYY-MM-DD'),
    'Todo bien con el retrato'
);
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra WHERE o.nombre = 'El Sueño De La Doncella' AND pm.actividad LIKE 'Revision de deterioro%' 
    AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra JOIN MUSEOS m ON hom.id_museo = m.id_museo WHERE o.nombre = 'El Sueño De La Doncella' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'El Sueño De La Doncella'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114389), 
    TO_DATE('2025-11-11', 'YYYY-MM-DD'), TO_DATE('2025-11-19', 'YYYY-MM-DD'),
    'El proceso de trabajo fue largo, pero no presentó complicaciones'
);
-- 1. Para 'Cupido Jugando Con Un Cisne'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Cupido Jugando Con Un Cisne' AND pm.actividad LIKE 'Limpieza de la escultura%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Cupido Jugando Con Un Cisne' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Cupido Jugando Con Un Cisne'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114388), 
    TO_DATE('2025-04-08', 'YYYY-MM-DD'), TO_DATE('2025-04-15', 'YYYY-MM-DD'),
    'Limpieza de porcelana de Sèvres con solución alcalina suave. Los esmaltes vítreos y dorados se conservan perfectamente.'
);

-- 2. Para 'Reloj De Bronce Dorado'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Reloj De Bronce Dorado' AND pm.actividad LIKE 'Limpieza de la escultura%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Reloj De Bronce Dorado' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Reloj De Bronce Dorado'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114388), 
    TO_DATE('2025-06-12', 'YYYY-MM-DD'), TO_DATE('2025-06-19', 'YYYY-MM-DD'),
    'Mecanismo de relojería revisado y lubricado. Limpieza de bronce con método electroquímico para preservar la pátina original.'
);

-- 3. Para 'Escritorio De Ébano Con Incrustaciones'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Escritorio De Ébano Con Incrustaciones' AND pm.actividad LIKE 'Limpieza de la escultura%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Escritorio De Ébano Con Incrustaciones' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Escritorio De Ébano Con Incrustaciones'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114388), 
    TO_DATE('2025-08-22', 'YYYY-MM-DD'), TO_DATE('2025-08-29', 'YYYY-MM-DD'),
    'Tratamiento con cera microcristalina para madera de ébano. Las incrustaciones de nácar fueron limpiadas con hisopos de algodón humedecidos.'
);

-- 4. Para 'Diana Cazadora'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Diana Cazadora' AND pm.actividad LIKE 'Limpieza de la escultura%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Diana Cazadora' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Diana Cazadora'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114388), 
    TO_DATE('2025-10-03', 'YYYY-MM-DD'), TO_DATE('2025-10-10', 'YYYY-MM-DD'),
    'Limpieza de mármol de Carrara con compresa de celulosa. Se sellaron microfisuras en la base con resina compatible.'
);
    --PINTURA
 -- 1. Para 'Vista Del Palacio De Nieborów'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Vista Del Palacio De Nieborów' AND pm.actividad LIKE 'Revision de deterioro%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Vista Del Palacio De Nieborów' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Vista Del Palacio De Nieborów'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114389), 
    TO_DATE('2025-03-05', 'YYYY-MM-DD'), TO_DATE('2025-03-11', 'YYYY-MM-DD'),
    'Análisis con luz ultravioleta revela estabilidad en acuarela sobre papel. Se realizó desacidificación preventiva del soporte.'
);

-- 2. Para 'Jardines De Arkadia'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Jardines De Arkadia' AND pm.actividad LIKE 'Revision de deterioro%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Jardines De Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Jardines De Arkadia'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114389), 
    TO_DATE('2025-07-22', 'YYYY-MM-DD'), TO_DATE('2025-07-28', 'YYYY-MM-DD'),
    'Revisión de craquelado en óleo sobre tabla. Los pigmentos pastel muestran excelente adherencia. Marco dorado estabilizado.'
);

-- 3. Para 'Retrato De Michał Hieronim Radziwiłł'
INSERT INTO MANTENIMIENTOS_OBRAS_REALIZADOS (
    id_mant, id_catalogo, id_obra, id_empleado, fecha_inicio, fecha_fin, observaciones
) VALUES (
    (SELECT pm.id_mant FROM PROGRAMAS_MANT pm JOIN OBRAS o ON pm.id_obra = o.id_obra 
     WHERE o.nombre = 'Retrato De Michał Hieronim Radziwiłł' AND pm.actividad LIKE 'Revision de deterioro%' 
     AND pm.id_catalogo = (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN MUSEOS m ON hom.id_museo = m.id_museo 
                          WHERE hom.id_obra = o.id_obra AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1)),
    (SELECT hom.id_catalogo_museo FROM HIST_OBRAS_MOV hom JOIN OBRAS o ON hom.id_obra = o.id_obra 
     JOIN MUSEOS m ON hom.id_museo = m.id_museo 
     WHERE o.nombre = 'Retrato De Michał Hieronim Radziwiłł' AND m.nombre = 'Museo de Nieborow y Arkadia' AND ROWNUM = 1),
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Retrato De Michał Hieronim Radziwiłł'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 34114389), 
    TO_DATE('2025-10-14', 'YYYY-MM-DD'), TO_DATE('2025-10-20', 'YYYY-MM-DD'),
    'Limpieza de brocados aplicados en oro con hisopos de algodón. El óleo sobre lienzo presenta estabilidad óptima en capas pictóricas.'
);   


 --INSERT SALAS_COLECCIONES
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Antiguo' AND m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Arte Oriental' AND ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'),
    1);
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Cristiano Oriental' AND m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Arte Medieval' AND ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'),
    1);
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Cristiano Oriental' AND m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Faras' AND ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'),
    2);
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Europeo Temprano' AND m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Europeo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'),
    1);
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Pinturas Polacas hasta 1914' AND m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería de Arte Polaco Antiguo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'),
    1);
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Moderno' AND m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Europeo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo Nacional de Varsovia'),
    1);
INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Decorativo' AND m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala de Arte Decorativo' AND ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo Nacional de Varsovia'),
    1);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Colección de Arte Oriental' AND m.nombre = 'Museo Nacional de Varsovia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo Nacional de Varsovia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Arte Oriental' AND ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Planta Baja' AND m.nombre = 'Museo Nacional de Varsovia'),
    1);


 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'El Vestibulo' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Vestibulo' AND ef.nombre = 'Planta Baja' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Planta Baja' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    1);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Cuartos, Estudios y Biblioteca' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Cuarto Blanco' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    1);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Cuartos, Estudios y Biblioteca' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Estudio Amarillo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    2);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Cuartos, Estudios y Biblioteca' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'La Biblioteca' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    3);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Cuartos, Estudios y Biblioteca' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Cuarto de Dibujo Rojo' AND ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Primera Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    4);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Cuarto de la Princesa' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'El Cuarto de la Princesa' AND ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    1);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'La Armeria Nesvish' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'La Armería Nesvish' AND ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Segunda Planta' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    1);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Objetos de la Familia Radziwill' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Exhibicion' AND ef.nombre = 'Planta Baja' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Planta Baja' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    1);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Jardines Barrocos' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Jardin Barroco de Nieborow' AND ef.nombre = 'Jardin Barroco de Nieborow' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Jardin Barroco de Nieborow' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    1);
 INSERT INTO SALAS_COLECCIONES (id_coleccion, id_est_org, id_museo, id_sala, id_est_fisica, orden) VALUES (
(SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Restauracion y Coleccion' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT id_museo FROM MUSEOS WHERE nombre = 'Museo de Nieborow y Arkadia'),
(SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Parque Romantico de Arkadia' AND ef.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'),
(SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Parque Romantico de Arkadia' AND m.nombre = 'Museo de Nieborow y Arkadia'),
    1);


COMMIT;

-- -----------------------------------------------------------------------------
-- PAIS: VENEZUELA
-- -----------------------------------------------------------------------------

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
(9155789, 'José', 'Pérez', TO_DATE('1970-05-12', 'YYYY-MM-DD'), 584121234567, 'Antonio', NULL); -- Restaurador de Arte Caracas
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(8345878, 'María', 'González', TO_DATE('1965-11-20', 'YYYY-MM-DD'), 584241234567, NULL, 'Ramírez'); -- Restauradora Galería Nacional
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

-- Empleado Profesional: Stefan Baumann (doc_identidad: 9155789)
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
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-06-01', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Curaduría de Arte Universal' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Bellas Artes')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Bellas Artes'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 15310561),
 'CURADOR',
 NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-09-15', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Educación y Programas Públicos' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Bellas Artes')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museo de Bellas Artes'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 9155789),
 'RESTAURADOR',
 NULL);

-- Historial de empleados en la Galería Nacional de Arte
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2012-04-10', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Curaduría y Colecciones' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Galería Nacional de Arte')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Galería Nacional de Arte'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 834 5878),
 'RESTAURADOR',
 TO_DATE('2023-12-30', 'YYYY-MM-DD'));

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-07-22', 'YYYY-MM-DD'),
 (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo WHERE eo.nombre = 'Departamento de Administración' AND eo.id_museo = (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Galería Nacional de Arte')),
 (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Galería Nacional de Arte'),
 (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 11230566),
 'CURADOR',
 NULL);
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

 COMMIT;


-------------------------------------------------------------------------------------
-- PAIS: FRANCIA
-------------------------------------------------------------------------------------


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
    ((SELECT id_lugar FROM LUGARES WHERE nombre='Paris'), 'Musée Jacquemart André', TO_DATE('1913-01-01', 'YYYY-MM-DD'), 'Preservar y exhibir la vasta y exquisita colección de arte que fue reunida por Édouard André y su esposa Nélie Jacquemart durante sus vidas');
INSERT INTO MUSEOS(id_lugar, nombre, fecha_fundacion, mision) VALUES
    ((SELECT id_lugar FROM LUGARES WHERE nombre='Paris'), 'Musée du Petit Palais', TO_DATE('1902-01-01', 'YYYY-MM-DD'), 'Preservar, exhibir y hacer accesible al público una vasta colección de arte desde la Antigüedad hasta el siglo XIX. También busca educar e inspirar a través de exposiciones temporales y actividades culturales en su icónico edificio');

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
        2,
        'Gestión, conservación, investigación y exhibición de colecciones permanentes. Planificación y curaduría de exposiciones temporales del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Departamento de Operaciones y Servicios al Visitante',
        'DEPARTAMENTO',
        2,
        'Gestión de infraestructura, seguridad, mantenimiento, logística, taquillas, tienda del museo, personal de sala y experiencia del visitante.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Departamento de Desarrollo y Comunicación',
        'DEPARTAMENTO',
        2,
        'Recaudación de fondos, patrocinios, marketing, prensa, redes sociales, desarrollo de audiencias, eventos especiales y programas de fidelización.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Departamento Financiero y Administrativo',
        'DEPARTAMENTO',
        2,
        'Contabilidad, presupuestos, recursos humanos, gestión legal y administración general del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
        'Departamento de Educación y Mediación Cultural',
        'DEPARTAMENTO',
        2,
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
        2,
        'Responsable de las estrategias de comunicación, relaciones con la prensa y difusión de la imagen del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Secretaría de Operaciones',
        'DEPARTAMENTO',
        2,
        'Encargada de la gestión operativa de las instalaciones del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Secretaría de Asuntos Generales',
        'DEPARTAMENTO',
        2,
        'Gestiona los asuntos administrativos generales y el apoyo a las diferentes áreas del museo.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Centro de Recursos de Documentación',
        'DEPARTAMENTO',
        2,
        'Gestiona la biblioteca y archivos del museo, proporcionando recursos para la investigación y el estudio.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Servicio Educativo y Cultural',
        'DEPARTAMENTO',
        2,
        'Diseña e implementa programas educativos, visitas guiadas y actividades culturales para diversos públicos.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Servicio de Exposiciones y Gestión de Colecciones',
        'DEPARTAMENTO',
        2,
        'Encargado de la curaduría y logística de exposiciones, así como la gestión y registro de las colecciones.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría General' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Infraestructura y Logística',
        'SECCION',
        3,
        'Gestión del mantenimiento técnico del museo y la logística de sus instalaciones.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría de Operaciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Seguridad',
        'SECCION',
        3,
        'Garantiza la protección de las obras de arte, las instalaciones y la seguridad de los visitantes.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría de Operaciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Recepción y Vigilancia',
        'SECCION',
        3,
        'Responsable de la bienvenida a los visitantes y de la vigilancia de las salas de exposición.',
        (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría de Operaciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'))
    );
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
    (
        (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
        'Gestión de Obras',
        'SECCION',
        3,
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
-- CONSEJO DE ADMINISTRACIÓN (NIVEL SUPERIOR - FALTABA PARA COMPLETAR JERARQUÍA)
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('1995-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Consejo de Administración' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2010),
 'DIRECTOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2008-04-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001),
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2013-08-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002),
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2005-12-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2003),
 'RESTAURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('1999-02-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento Financiero y Administrativo' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2004),
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2016-06-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005),
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2003-10-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2006),
 'RESTAURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2007),
 'RESTAURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2009-07-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento Financiero y Administrativo' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2008),
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2013-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento Financiero y Administrativo' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2009),
 'ADMINISTRATIVO', NULL);

-- MUSEO PETIT PALAIS
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2006-10-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección y Conservaduría en Jefe del Petit Palais' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2018),
 'DIRECTOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-09-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría de Asuntos Generales' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2011),
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2006-11-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2012),
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-02-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2013),
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2010-08-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2014),
 'RESTAURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-05-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2015),
 'RESTAURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2010-12-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría de Asuntos Generales' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2016),
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-04-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Secretaría de Asuntos Generales' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2017),
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2013-07-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2019),
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2007-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2020),
 'CURADOR', NULL);


-- ---------------------------------------------------------------
-- Tabla: HIST_OBRAS_MOV
-- ---------------------------------------------------------------
-- MUSEO JACQUEMART ANDRE
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Portrait of Comte Antoine Français de Nantes'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte del Siglo XIX' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Salon Des Peintures' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), -- Sophie Dubois
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1915-01-15', 'YYYY-MM-DD'), -- Fecha estimada de adquisición
 'DONADA',
 'SI',
 NULL,
 1,
 NULL);
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Ruined Gallery'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte del Siglo XIX' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Salon Des Peintures' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002), -- Lucas Martin
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1913-01-11', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 2,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Virgin and Child on a Throne'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Italiano' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Salle Florentine' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005), -- Manon Marie Lefevre
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1913-01-15', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 3,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'The New Model'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Salon des Tapisseries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), -- Sophie Dubois
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1913-01-15', 'YYYY-MM-DD'),
 'DONADA',
 'NO',
 NULL,
 NULL,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Imaginary Portico'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Salon de Musique' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002), -- Lucas Martin
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1916-01-15', 'YYYY-MM-DD'),
 'DONADA',
 'NO',
 NULL,
 NULL,
 500000);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'La fuite en Egypte'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Italiano' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Salle Florentine' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005), -- Manon Marie Lefevre
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1915-01-15', 'YYYY-MM-DD'),
 'DONADA',
 'NO',
 NULL,
 NULL,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Les Pèlerins d''Emmaüs'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Flamenco y Holandés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Bibliothèque' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), -- Sophie Dubois
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1913-08-22', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 4,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Les Attributs des Sciences et des Arts'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Salle à Manger' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002), -- Lucas Martin
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Grands Salons' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1916-04-26', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 5,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Saint Georges terrassant le dragon'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Italiano' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Salle Florentine' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005), -- Manon Marie Lefevre
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1913-01-15', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 6,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Ecce Homo'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Italiano' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Salle Florentine' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), -- Sophie Dubois
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1914-03-17', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 7,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Portrait d''homme'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Flamenco y Holandés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Bibliothèque' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002), -- Lucas Martin
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1916-01-15', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 8,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Portrait de Françoise-Renée de Carbonnel de Canisy, marquise d''Antin'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Boudoir' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005), -- Manon Marie Lefevre
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1913-10-10', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 9,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Buste de Grégoire XV'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Italiano' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Salle des Sculptures' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), -- Sophie Dubois
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1916-01-15', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 10,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Le Martyre de Saint Sébastien'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Italiano' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'La Salle des Sculptures' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2002), -- Lucas Martin
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Le Musée Italien' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1913-01-15', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 11,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Buste de l''architecte Jacques V Gabriel'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Fumoir' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2005), -- Manon Marie Lefevre
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1913-01-15', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 12,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Buste d''Antoine-Louis François Le Fèvre de Caumartin'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Arte Francés del sigo XVIII y Artes Decorativas' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'Le Fumoir' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2001), -- Sophie Dubois
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Les Salons Privés' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André')),
 TO_DATE('1914-04-15', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 13,
 3000000);

-- MUSEO PETIT PALAIS

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Ugolino'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Siglo XIX' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ SALLE 4' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2020), -- Alexandre Vincent
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1905-03-10', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 1,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Ephebe from the Fins d''Annecy'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Mundo Clásico' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ et XXᵉ' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2019), -- Clara Fournier
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1903-07-20', 'YYYY-MM-DD'),
 'COMPRADA',
 'SI',
 NULL,
 2,
 50000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'White ground hydria'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Mundo Clásico' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ et XXᵉ' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2013), -- Alice Michel
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1904-01-05', 'YYYY-MM-DD'),
 'DONADA',
 'NO',
 NULL,
 3,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Knight, Death and the Devil (Bartsch 98)'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Renacimiento' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ et XXᵉ' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2012), -- Paul Simon
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1906-02-15', 'YYYY-MM-DD'),
 'COMPRADA',
 'SI',
 NULL,
 4,
 35000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Le Nouvelin de Vénerie'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Renacimiento' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ et XXᵉ' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2020), -- Alexandre Vincent
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1907-09-01', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 5,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'The Carcass or On the Sabbath Road'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Renacimiento' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ et XXᵉ' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2019), -- Clara Fournier
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1908-04-25', 'YYYY-MM-DD'),
 'DONADA',
 'NO',
 NULL,
 6,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'A Jaunt by Carriage'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Siglo XVIII' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'GALERIE TUCK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2013), -- Alice Michel
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1909-11-12', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 7,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Jérôme de La Lande'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Siglo XVIII' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'GALERIE TUCK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2012), -- Paul Simon
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1910-06-30', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 8,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'A Parisian Woman'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Siglo XIX' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ SALLE 7' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2020), -- Alexandre Vincent
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1912-08-01', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 9,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Combat of the Giaour and the Pasha'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Siglo XIX' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ SALLE 8' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2019), -- Clara Fournier
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1915-05-20', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 10,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Dante'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'Siglo XIX' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ SALLE 8' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2013), -- Alice Michel
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1918-09-05', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 11,
 NULL);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES
((SELECT id_obra FROM OBRAS WHERE nombre = 'Cascade Pendant'),
 (SELECT id_coleccion FROM COLECCIONES_PERMANENTES WHERE nombre = 'París 1900' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_sala FROM SALAS_EXP WHERE nombre = 'XIXᵉ et XXᵉ' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 2012), -- Paul Simon
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Servicio de Exposiciones y Gestión de Colecciones' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),
 (SELECT id_est FROM EST_FISICA WHERE nombre = 'Galeries' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais')),
 TO_DATE('1920-03-15', 'YYYY-MM-DD'),
 'DONADA',
 'SI',
 NULL,
 12,
 NULL);


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
VALUES (1, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ESTUDIANTE',15.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'INFANTIL',9.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ESTUDIANTE',15.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (8, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'INFANTIL',9.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (9, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (10, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ESTUDIANTE',15.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (11, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (12, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (13, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'INFANTIL',9.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (14, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (15, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ESTUDIANTE',15.00);

-- MUSEO PETIT PALAIS

INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (1, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (2, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ESTUDIANTE',7.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (3, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'INFANTIL',0.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (4, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (5, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (6, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ESTUDIANTE',7.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (7, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (8, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'INFANTIL',0.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (9, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (10, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ESTUDIANTE',7.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (11, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (12, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (13, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'INFANTIL',0.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (14, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio)
VALUES (15, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ESTUDIANTE',7.50);

-- TICKETS ADICIONALES PARA MEJORAR RANKING DE POPULARIDAD
-- MUSEO JACQUEMART ANDRE - Tickets adicionales distribuidos en 2024
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (16, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (17, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ESTUDIANTE',15.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (18, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (19, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'INFANTIL',9.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (20, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (21, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ESTUDIANTE',15.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (22, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (23, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ADULTO',17.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (24, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'INFANTIL',9.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (25, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée Jacquemart André'),SYSDATE,'ESTUDIANTE',15.00);

-- MUSEO PETIT PALAIS - Tickets adicionales distribuidos en 2024
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (16, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (17, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ESTUDIANTE',7.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (18, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (19, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'INFANTIL',0.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (20, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (21, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ESTUDIANTE',7.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (22, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (23, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ADULTO',15.50);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (24, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'INFANTIL',0.00);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (25, (SELECT id_museo FROM MUSEOS WHERE nombre = 'Musée du Petit Palais'),SYSDATE,'ESTUDIANTE',7.50);

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
('Pierre De Wiessant', TO_DATE('1885-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '197 cm x 117 cm x 94 cm', 'Bronce.', 'Escultura moderna, parte del grupo "Los Burgueses de Calais".');
INSERT INTO OBRAS (nombre, fecha_periodo, tipo_obra, dimensiones, desc_materiales_tecnicas, desc_estilos_generos) VALUES 
('La Petite Danseuse de Quatorze Ans', TO_DATE('1881-01-01', 'YYYY-MM-DD'), 'ESCULTURA', '99 cm de altura', 'Bronce fundido con pátina, corpiño de tul, lazo de seda.', 'Realismo / Impresionismo. Escultura revolucionaria por su realismo y el uso de materiales mixtos.');
-- CORREGIDO: Las siguientes 4 obras estaban duplicadas de la sección PINTURAS y causaban errores
-- Se han eliminado para mantener solo una versión de cada obra
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
(20000001, 'Stefan', 'Weppelmann', TO_DATE('1968-03-15', 'YYYY-MM-DD'), 4934121370460, NULL, NULL); -- Director MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000002, 'Jeannette', 'Stoschek', TO_DATE('1975-07-22', 'YYYY-MM-DD'), 4934121370461, NULL, NULL); -- Subdirectora MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000003, 'Sithara', 'Weeratunga', TO_DATE('1985-11-08', 'YYYY-MM-DD'), 4934121370462, NULL, NULL); -- Agente para la Diversidad MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000004, 'Olga', 'Vostretsova', TO_DATE('1982-04-18', 'YYYY-MM-DD'), 4934121370463, NULL, NULL); -- Agente para la Diversidad MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000005, 'Jan', 'Nicolaisen', TO_DATE('1973-09-12', 'YYYY-MM-DD'), 4934121370464, NULL, NULL); -- Jefe Pintura y Escultura MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000006, 'Jenny', 'Graser', TO_DATE('1981-01-25', 'YYYY-MM-DD'), 4934121370465, NULL, NULL); -- Curadora Pintura y Escultura S. XX/XXI MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000007, 'Philipp', 'Freytag', TO_DATE('1979-06-30', 'YYYY-MM-DD'), 4934121370466, NULL, NULL); -- Curador Fotografía y Artes Mediales MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000008, 'Julia', 'Beckmann', TO_DATE('1987-12-14', 'YYYY-MM-DD'), 4934121370467, NULL, NULL); -- Asistente de Curaduría MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000009, 'Anne', 'Richter', TO_DATE('1984-08-03', 'YYYY-MM-DD'), 4934121370468, NULL, NULL); -- Asistente de Curaduría MdbK
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000010, 'Ulrike', 'Saß', TO_DATE('1976-05-19', 'YYYY-MM-DD'), 4934121370469, NULL, NULL); -- Investigación de Procedencia MdbK
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
(20000050, 'Prof. Alexander', 'Klar', TO_DATE('1965-05-18', 'YYYY-MM-DD'), 494028613200, NULL, NULL); -- Director Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000051, 'Helga', 'Huskamp', TO_DATE('1972-09-24', 'YYYY-MM-DD'), 494028613201, NULL, NULL); -- Managing Director Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000052, 'Andreas', 'Stolzenburg', TO_DATE('1968-11-12', 'YYYY-MM-DD'), 494028613202, NULL, NULL); -- Grabados y Dibujos Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000053, 'Sandra', 'Pisot', TO_DATE('1975-03-07', 'YYYY-MM-DD'), 494028613203, NULL, NULL); -- Antiguos Maestros Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000054, 'Markus', 'Bertsch', TO_DATE('1971-08-29', 'YYYY-MM-DD'), 494028613204, NULL, NULL); -- Siglo XIX Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000055, 'Toby', 'Kamps', TO_DATE('1969-01-15', 'YYYY-MM-DD'), 494028613205, NULL, NULL); -- Colección Modernista Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000056, 'Brigitte', 'Kölle', TO_DATE('1973-06-21', 'YYYY-MM-DD'), 494028613206, NULL, NULL); -- Arte Contemporáneo Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000057, 'Corinne', 'Diserens', TO_DATE('1967-04-10', 'YYYY-MM-DD'), 494028613207, NULL, NULL); -- Arte Contemporáneo Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000058, 'Annabelle', 'Görgen-Lammers', TO_DATE('1980-12-03', 'YYYY-MM-DD'), 494028613208, NULL, NULL); -- Esculturas y Numismática Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000059, 'Ute', 'Haug', TO_DATE('1974-07-16', 'YYYY-MM-DD'), 494028613209, NULL, NULL); -- Investigación de Procedencia Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000060, 'David', 'Klemm', TO_DATE('1982-02-28', 'YYYY-MM-DD'), 494028613210, NULL, NULL); -- Proyecto de Digitalización Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000061, 'Ursula', 'Trieloff', TO_DATE('1976-10-05', 'YYYY-MM-DD'), 494028613211, NULL, NULL); -- Oficina de Colecciones Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000062, 'Andrea', 'Weniger', TO_DATE('1970-05-22', 'YYYY-MM-DD'), 494028613212, NULL, NULL); -- Educación Kunsthalle
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
(20000068, 'Jan', 'Metzler', TO_DATE('1977-12-19', 'YYYY-MM-DD'), 494028613218, NULL, NULL); -- Marketing y Relaciones con el Cliente Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000069, 'Martina', 'Gschwilm', TO_DATE('1983-06-02', 'YYYY-MM-DD'), 494028613219, NULL, NULL); -- Comunicación Digital Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000070, 'Mira', 'Forte', TO_DATE('1985-03-17', 'YYYY-MM-DD'), 494028613220, NULL, NULL); -- Prensa y Relaciones Públicas Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000071, 'Gesa-Thorid', 'Huget', TO_DATE('1974-08-06', 'YYYY-MM-DD'), 494028613221, NULL, NULL); -- Patrocinios y Alianzas Kunsthalle
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, primer_apellido, fecha_nacimiento, contacto, segundo_nombre, segundo_apellido) VALUES 
(20000072, 'Anna', 'Punke-Dresen', TO_DATE('1976-11-23', 'YYYY-MM-DD'), 494028613222, NULL, NULL); -- Patrocinios y Alianzas Kunsthalle
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
INSERT INTO ARTISTAS_OBRAS (id_obra, id_artista) VALUES ((SELECT id_obra FROM OBRAS WHERE nombre = 'Pierre De Wiessant'), (SELECT id_artista FROM ARTISTAS WHERE primer_nombre = 'Auguste' AND primer_apellido = 'Rodin'));
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

-- Empleado Profesional: Stefan Weppelmann - Director (doc_identidad: 20000001)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Francés'));

-- Empleado Profesional: Jeannette Stoschek - Subdirectora (doc_identidad: 20000002)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Jan Nicolaisen - Jefe Pintura y Escultura (doc_identidad: 20000005)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000005), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000005), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Jenny Graser - Curadora (doc_identidad: 20000006)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000006), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000006), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Philipp Freytag - Curador (doc_identidad: 20000007)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000007), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000007), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Theresa Anna Bräunig - Jefa Restauración (doc_identidad: 20000017)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000017), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000017), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleado Profesional: Carolin Rothmund - Jefa Educación (doc_identidad: 20000019)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000019), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000019), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Empleados para Hamburger Kunsthalle
-- Prof. Alexander Klar - Director (doc_identidad: 20000050)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Francés'));

-- Helga Huskamp - Managing Director (doc_identidad: 20000051)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000051), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000051), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Andreas Stolzenburg - Grabados y Dibujos (doc_identidad: 20000052)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000052), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000052), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Sandra Pisot - Antiguos Maestros (doc_identidad: 20000053)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000053), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000053), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000053), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Italiano'));

-- Markus Bertsch - Siglo XIX (doc_identidad: 20000054)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000054), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000054), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

-- Toby Kamps - Colección Modernista (doc_identidad: 20000055)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000055), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000055), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));

-- Andrea Weniger - Educación (doc_identidad: 20000062)
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000062), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Alemán'));
INSERT INTO EMPLEADOS_IDIOMAS (id_empleado, id_idioma) VALUES ((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000062), (SELECT id_idioma FROM IDIOMAS WHERE nombre = 'Inglés'));

PROMPT Data inserted into EMPLEADOS_IDIOMAS table.
PROMPT -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Tabla: FORMACIONES
-- -----------------------------------------------------------------------------
PROMPT Inserting data into FORMACIONES table...

-- Formaciones para Empleado: Stefan Weppelmann - Director (doc_identidad: 20000001)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), 'Doctorado en Historia del Arte', 1998, 'Especialización en arte italiano del Renacimiento, Universidad de Bonn.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), 'Máster en Historia del Arte', 1994, 'Arte del Renacimiento y Barroco, Universidad de Heidelberg.');

-- Formaciones para Empleado: Jeannette Stoschek - Subdirectora (doc_identidad: 20000002)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), 'Doctorado en Historia del Arte', 2003, 'Especialización en arte gráfico alemán del siglo XIX y XX.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), 'Máster en Museología', 1999, 'Gestión de colecciones y conservación preventiva.');

-- Formaciones para Empleado: Jan Nicolaisen - Jefe Pintura y Escultura (doc_identidad: 20000005)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000005), 'Doctorado en Historia del Arte', 2001, 'Pintura alemana del siglo XIX, Universidad de Leipzig.');

-- Formaciones para Empleado: Jenny Graser - Curadora (doc_identidad: 20000006)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000006), 'Doctorado en Historia del Arte', 2009, 'Arte del siglo XX y XXI, especialización en escultura contemporánea.');

-- Formaciones para Empleado: Philipp Freytag - Curador (doc_identidad: 20000007)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000007), 'Doctorado en Historia del Arte', 2010, 'Fotografía y nuevos medios en el arte contemporáneo.');

-- Formaciones para Empleado: Theresa Anna Bräunig - Jefa Restauración (doc_identidad: 20000017)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000017), 'Máster en Conservación-Restauración', 2005, 'Especialización en pintura sobre lienzo y tabla, Academia de Bellas Artes de Dresden.');

-- Formaciones para Empleado: Carolin Rothmund - Jefa Educación (doc_identidad: 20000019)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000019), 'Máster en Educación Artística', 2010, 'Pedagogía museística y mediación cultural, Universidad de Leipzig.');

-- Formaciones para Empleados Hamburger Kunsthalle
-- Prof. Alexander Klar - Director (doc_identidad: 20000050)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), 'Doctorado en Historia del Arte', 1995, 'Especialización en arte alemán del siglo XIX, Universidad de Heidelberg.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), 'Máster en Museología', 1991, 'Gestión y administración de museos, Universidad de Múnich.');

-- Helga Huskamp - Managing Director (doc_identidad: 20000051)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000051), 'Doctorado en Administración Pública', 2002, 'Especialización en gestión cultural y museística.');
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000051), 'MBA en Gestión Cultural', 1998, 'Administración de instituciones culturales.');

-- Andreas Stolzenburg - Grabados y Dibujos (doc_identidad: 20000052)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000052), 'Doctorado en Historia del Arte', 1996, 'Especialización en grabado alemán del siglo XVI-XVIII.');

-- Sandra Pisot - Antiguos Maestros (doc_identidad: 20000053)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000053), 'Doctorado en Historia del Arte', 2004, 'Pintura italiana del Renacimiento y Barroco.');

-- Markus Bertsch - Siglo XIX (doc_identidad: 20000054)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000054), 'Doctorado en Historia del Arte', 2006, 'Romanticismo alemán y pintura del siglo XIX.');

-- Toby Kamps - Colección Modernista (doc_identidad: 20000055)
INSERT INTO FORMACIONES (id_empleado_prof, titulo, anio, descripcion_espec) VALUES 
((SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000055), 'Máster en Arte Moderno', 1994, 'Arte estadounidense contemporáneo, Universidad de Nueva York.');

-- Andrea Weniger - Educación (doc_identidad: 20000062)
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
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Dirección General MdbK', 'DIRECCION', 1, 'Unidad central que supervisa todas las demás áreas del museo. Jefatura: Stefan Weppelmann (Director), Jeannette Stoschek (Subdirectora).', NULL);

-- NIVEL 2: DEPARTAMENTOS
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'MdbK [in transit]', 'DEPARTAMENTO', 2, 'Programa especial bajo supervisión directa de la Dirección. Personal: Sithara Weeratunga, Olga Vostretsova (Agentes para la Diversidad).', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Colecciones MdbK', 'DEPARTAMENTO', 2, 'Gestión, estudio, conservación y desarrollo de las colecciones del museo. Jefatura: Jeannette Stoschek (Jefa de Colecciones y Colección Gráfica), Jan Nicolaisen (Jefe de Pintura y Escultura).', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Restauración MdbK', 'DEPARTAMENTO', 2, 'Conservación preventiva y curativa de las obras de arte. Jefatura: Theresa Anna Bräunig.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Biblioteca y Archivo de Artistas MdbK', 'DEPARTAMENTO', 2, 'Gestión de recursos bibliográficos y archivos documentales. Jefatura: Sebastian Stumpe.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Departamento de Colecciones Externas MdbK', 'DEPARTAMENTO', 2, 'Gestión del Archivo EVELYN RICHTER & URSULA ARNOLD. Jefatura: Jeannette Stoschek.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

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
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Curaduría MdbK', 'SECCION', 3, 'Personal: Jenny Graser (Curadora Pintura y Escultura S. XX/XXI), Philipp Freytag (Curador Fotografía y Artes Mediales), Julia Beckmann, Anne Richter (Asistentes de Curaduría).', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'), 'Sección de Investigación de Procedencia MdbK', 'SECCION', 3, 'Personal: Ulrike Saß, Lina Frubrich.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')));

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
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Management Board Kunsthalle', 'DIRECCION', 1, 'Consejo de Dirección. Jefatura: Prof. Alexander Klar (Director), Helga Huskamp (Managing Director). Personal de Soporte a la Dirección: Asistentes de Dirección y del Consejo.', NULL);

-- NIVEL 2: DEPARTAMENTOS
INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Colecciones y Exposiciones Kunsthalle', 'DEPARTAMENTO', 2, 'Departamento académico central organizado por áreas de colección. Jefes: Andreas Stolzenburg, Sandra Pisot, Markus Bertsch, Toby Kamps, Brigitte Kölle, Corinne Diserens, Annabelle Görgen-Lammers.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Educación Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Andrea Weniger.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Biblioteca, Archivo y Documentación Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Katharina Therese Gietkowski.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Conservación y Tecnología del Arte Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Silvia Castro (Conservación, Antiguos Maestros), Sabine Zorn (Conservación Papel y Fotografía). Especialidades: Antiguos Maestros, Siglo XIX, Arte Moderno.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Registro y Coordinación de Exposiciones Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Meike Wenck.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Marketing y Relaciones con el Cliente Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Jan Metzler.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Comunicación Digital Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Martina Gschwilm.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Prensa y Relaciones Públicas Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Mira Forte.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Departamento de Patrocinios y Alianzas Kunsthalle', 'DEPARTAMENTO', 2, 'Jefatura: Gesa-Thorid Huget, Anna Punke-Dresen.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

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
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de Investigación de Procedencia e Historia de la Colección Kunsthalle', 'SECCION', 3, 'Jefatura: Ute Haug.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

INSERT INTO EST_ORGANIZACIONAL (id_museo, nombre, tipo, nivel, descripcion, id_est_org_padre) VALUES
((SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'), 'Sección de Proyecto de Digitalización Kunsthalle', 'SECCION', 3, 'Jefatura: David Klemm.', (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')));

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
-- VERSIÓN CORREGIDA Y COMPLETADA - 09-JUN-2025
-- NOTA: Los triggers han sido corregidos para evitar errores de tabla mutante
-- -----------------------------------------------------------------------------
PROMPT Inserting data into HIST_EMPLEADOS table...

-- =============================================================================
-- Historial para Museum der bildenden Künste Leipzig (MdbK)
-- =============================================================================

-- Dirección
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2021-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000001), -- Stefan Weppelmann
 'DIRECTOR', NULL);

-- Subdirección (Deputy Director - ACTIVO)
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-06-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Dirección General MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000002), -- Jeannette Stoschek (como Subdirectora)
 'DIRECTOR', NULL);

-- MdbK [in transit]
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2020-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'MdbK [in transit]' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000003), -- Sithara Weeratunga
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2020-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'MdbK [in transit]' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000004), -- Olga Vostretsova
 'ADMINISTRATIVO', NULL);


INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000005), -- Jan Nicolaisen
 'CURADOR', NULL);

-- Sección de Curaduría
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-09-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Curaduría MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000006), -- Jenny Graser
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2020-02-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Curaduría MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000007), -- Philipp Freytag
 'CURADOR', NULL);

-- Departamento de Restauración
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-08-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Restauración MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000017), -- Theresa Anna Bräunig
 'RESTAURADOR', NULL);

-- Departamento de Biblioteca y Archivo
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Biblioteca y Archivo de Artistas MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000018), -- Sebastian Stumpe
 'ADMINISTRATIVO', NULL);

-- Departamento de Educación Artística
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2016-04-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Educación Artística MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000019), -- Carolin Rothmund
 'ADMINISTRATIVO', NULL);

-- Registros de historial faltantes para empleados de MdbK
-- Sección de Curaduría (Asistentes)
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Curaduría MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000008), -- Julia Beckmann
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-09-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Curaduría MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000009), -- Anne Richter
 'CURADOR', NULL);

-- Sección de Investigación de Procedencia
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Investigación de Procedencia MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000010), -- Ulrike Saß
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-06-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Investigación de Procedencia MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000011), -- Lina Frubrich
 'CURADOR', NULL);

-- Sección de Documentación y Digitalización
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-05-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Documentación y Digitalización MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000012), -- Susanne Petri
 'ADMINISTRATIVO', NULL);

-- Sección de Registro y Gestión de Préstamos
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2016-11-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Registro y Gestión de Préstamos MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000013), -- Linda Wagner
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-08-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Registro y Gestión de Préstamos MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000014), -- Ulrike Milde
 'ADMINISTRATIVO', NULL);

-- Sección de Gestión de Colección Física
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Gestión de Colección Física MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000015), -- Marko Kloss
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Gestión de Colección Física MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000016), -- Uwe Wagner
 'ADMINISTRATIVO', NULL);

-- Departamento de Relaciones Públicas, Marketing y Eventos
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-07-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Relaciones Públicas, Marketing y Eventos MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000020), -- Jörg Dittmer
 'ADMINISTRATIVO', NULL);

-- Sección de Prensa y Comunicación Online
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-04-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Prensa y Comunicación Online MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000021), -- Sonja Lucia Gatterwe
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-02-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Prensa y Comunicación Online MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000022), -- Ulrike Otto
 'ADMINISTRATIVO', NULL);

-- Sección de Nuevos Medios
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Nuevos Medios MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000023), -- Dirk Kuntze
 'ADMINISTRATIVO', NULL);

-- Departamento de Recaudación de Fondos y Alquileres
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2016-09-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Recaudación de Fondos y Alquileres MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000024), -- Katrin Siegmeyer
 'ADMINISTRATIVO', NULL);

-- Departamento de Administración
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2014-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Administración MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000025), -- Anne-Kathrin Herrmann
 'ADMINISTRATIVO', NULL);

-- Sección de Tienda del Museo
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-06-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Tienda del Museo MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000026), -- Janet Schirmer
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-08-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Tienda del Museo MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000027), -- Tim Sachse
 'ADMINISTRATIVO', NULL);

-- Departamento de Seguridad y Gestión de Instalaciones
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2013-05-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Seguridad y Gestión de Instalaciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000028), -- Torsten Cech
 'ADMINISTRATIVO', NULL);

-- Sección de Mantenimiento de Instalaciones
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-10-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Mantenimiento de Instalaciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000029), -- Sven Hottenrott
 'ADMINISTRATIVO', NULL);

-- Sección de Mantenimiento de Instalaciones (Servicios de Edificio)
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-07-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Mantenimiento de Instalaciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000030), -- Dennis Kuhn
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-12-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Mantenimiento de Instalaciones MdbK' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000031), -- Jens Wuttke
 'ADMINISTRATIVO', NULL);

-- =============================================================================
-- Historial para Hamburger Kunsthalle
-- =============================================================================

-- Management Board
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-09-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000050), -- Prof. Alexander Klar
 'DIRECTOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-04-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Management Board Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000051), -- Helga Huskamp
 'ADMINISTRATIVO', NULL);

-- Departamento de Colecciones y Exposiciones (Curadores y Jefes de Colección)
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2010-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000052), -- Andreas Stolzenburg
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2012-09-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000053), -- Sandra Pisot
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2016-02-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000054), -- Markus Bertsch
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-06-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000055), -- Toby Kamps
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2011-11-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000056), -- Brigitte Kölle
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2013-05-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000057), -- Corinne Diserens
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-09-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000058), -- Annabelle Görgen-Lammers
 'CURADOR', NULL);

-- Secciones del Departamento de Colecciones
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-01-15', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Investigación de Procedencia e Historia de la Colección Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000059), -- Ute Haug
 'CURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-11-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Proyecto de Digitalización Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000060), -- David Klemm
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2014-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Oficina de Colecciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000061), -- Ursula Trieloff
 'ADMINISTRATIVO', NULL);

-- Departamento de Educación
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2014-08-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Educación Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000062), -- Andrea Weniger
 'ADMINISTRATIVO', NULL);

-- Departamento de Biblioteca, Archivo y Documentación
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2016-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Biblioteca, Archivo y Documentación Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000063), -- Katharina Therese Gietkowski
 'ADMINISTRATIVO', NULL);

-- Departamento de Conservación y Tecnología del Arte
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2012-07-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Conservación y Tecnología del Arte Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000064), -- Silvia Castro
 'RESTAURADOR', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2011-02-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Conservación y Tecnología del Arte Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000065), -- Sabine Zorn
 'RESTAURADOR', NULL);

-- Departamento de Registro y Coordinación de Exposiciones
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-05-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Registro y Coordinación de Exposiciones Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000066), -- Meike Wenck
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Sección de Manejo de Obras Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000067), -- Jochen Möhle
 'ADMINISTRATIVO', NULL);

-- Departamentos Administrativos y de Soporte
INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Marketing y Relaciones con el Cliente Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000068), -- Jan Metzler
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2020-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Comunicación Digital Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000069), -- Martina Gschwilm
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2018-08-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Prensa y Relaciones Públicas Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000070), -- Mira Forte
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2016-06-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Patrocinios y Alianzas Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000071), -- Gesa-Thorid Huget
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2017-03-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Patrocinios y Alianzas Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000072), -- Anna Punke-Dresen
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2019-10-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Gestión de Eventos y Coordinación de Programas Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000073), -- Sina Fuhrmann
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2013-01-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Supervisión de Salas Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000074), -- Hassan Daneschwar
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2010-09-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Edificio y Tecnología Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000075), -- Ralf Suerbaum
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2014-07-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Recursos Humanos Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000076), -- Marion Asmus
 'ADMINISTRATIVO', NULL);

INSERT INTO HIST_EMPLEADOS (fecha_inicio, id_est_org, id_museo, id_empleado_prof, cargo, fecha_fin) VALUES
(TO_DATE('2015-11-01', 'YYYY-MM-DD'),
 (SELECT id_est_org FROM EST_ORGANIZACIONAL WHERE nombre = 'Departamento de Contraloría y Finanzas Kunsthalle' AND id_museo = (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle')),
 (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
 (SELECT id_empleado FROM EMPLEADOS_PROFESIONALES WHERE doc_identidad = 20000077), -- Kathrin von Gönner
 'ADMINISTRATIVO', NULL);

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

-- -----------------------------------------------------------------------------
-- REGISTROS FALTANTES DE HIST_OBRAS_MOV
-- Agregando los registros de adquisición inicial para las 18 obras que carecían de historial
-- -----------------------------------------------------------------------------

-- Obras de Caspar David Friedrich para MdbK Leipzig
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Felsenlandschaft im Elbsandsteingebirge'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000005), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1823-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 2, 450000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Das Eismeer'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000005), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1824-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 3, 600000.00);

-- Obra de Carl Spitzweg para MdbK Leipzig
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Der Schmetterlingsjäger'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000006), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1840-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, 4, 180000.00);

-- Obra de Arnold Böcklin para MdbK Leipzig
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Selbstporträt mit fiedelndem Tod'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000006), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1872-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'NO', NULL, 5, 320000.00);

-- Obras de Ernst Ludwig Kirchner para MdbK Leipzig
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Selbstbildnis mit Modell'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Vanguardias del Siglo XX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala Temporal A - 1.OG' AND ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000006), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1910-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 6, 850000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Mädchenkopf'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Vanguardias del Siglo XX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala Temporal A - 1.OG' AND ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000007), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1918-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'NO', NULL, 7, 280000.00);

-- Obra de Paul Klee para MdbK Leipzig
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Arabische Stadt'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Vanguardias del Siglo XX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala Temporal A - 1.OG' AND ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000007), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1928-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 8, 750000.00);

-- Esculturas de Max Klinger para MdbK Leipzig
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Adam und Eva'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000005), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1897-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 11, 1800000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Prometheus'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000005), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1886-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, 12, 950000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Kassandra'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte Alemán del Siglo XIX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Galería Romántica Alemana' AND ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000006), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerías Arte Siglo XIX MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1886-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'NO', NULL, 13, 1200000.00);

-- Esculturas de Wilhelm Lehmbruck para MdbK Leipzig
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Die große Sinnende'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Vanguardias del Siglo XX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala Temporal A - 1.OG' AND ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000006), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1908-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, 14, 680000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Kniende'), 
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Vanguardias del Siglo XX (MdbK)' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Sala Temporal A - 1.OG' AND ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000007), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Museum der bildenden Künste Leipzig'), 
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Area Exposiciones Temporales 1.OG MdbK' AND m.nombre = 'Museum der bildenden Künste Leipzig'), 
    TO_DATE('1913-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'NO', NULL, 15, 520000.00);

-- Esculturas de Eva Hesse para Hamburger Kunsthalle
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Repetition Nineteen III'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Galerie der Gegenwart (Colección Contemporánea)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Espacio Contemporáneo Nivel 0' AND ef.nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000056), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1968-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, 4, 650000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Ohne Titel (Wolken)'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Galerie der Gegenwart (Colección Contemporánea)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Espacio Contemporáneo Nivel 0' AND ef.nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000057), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Sammlung Zeitgenössische Kunst GdG KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1985-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'NO', NULL, 6, 400000.00);

-- Obras de Auguste Rodin para Hamburger Kunsthalle
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Der Kuss'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Gran Salón Hubertus Wald' AND ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000054), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1882-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'SI', NULL, 7, 8500000.00);

INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Pierre De Wiessant'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Gran Salón Hubertus Wald' AND ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000054), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Hubertus-Wald-Forum KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1885-01-01', 'YYYY-MM-DD'), 
    'DONADA POR MUSEO', 'NO', NULL, 8, 4200000.00);

-- Obra de Édouard Manet para Hamburger Kunsthalle
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Nana, eine Studie'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Salas Caspar David Friedrich' AND ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000054), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1877-01-01', 'YYYY-MM-DD'), 
    'COMPRADA', 'NO', NULL, 2, 1850000.00);

-- Obra de Pablo Picasso para Hamburger Kunsthalle
INSERT INTO HIST_OBRAS_MOV (id_obra, id_coleccion, id_sala, id_empleado, id_est_org, id_museo, id_est_fis, fecha_entrada, tipo_adquisicion, destacada, fecha_salida, orden_recorrido, valor_monetario) VALUES (
    (SELECT id_obra FROM OBRAS WHERE nombre = 'Die Absinthtrinkerin'),
    (SELECT cp.id_coleccion FROM COLECCIONES_PERMANENTES cp JOIN MUSEOS m ON cp.id_museo = m.id_museo WHERE cp.nombre = 'Arte del Siglo XIX (Kunsthalle)' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT se.id_sala FROM SALAS_EXP se JOIN EST_FISICA ef ON se.id_est = ef.id_est JOIN MUSEOS m ON se.id_museo = m.id_museo WHERE se.nombre = 'Salas Caspar David Friedrich' AND ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ep.id_empleado FROM EMPLEADOS_PROFESIONALES ep WHERE ep.doc_identidad = 20000055), 
    (SELECT eo.id_est_org FROM EST_ORGANIZACIONAL eo JOIN MUSEOS m ON eo.id_museo = m.id_museo WHERE eo.nombre = 'Departamento de Colecciones y Exposiciones Kunsthalle' AND m.nombre = 'Hamburger Kunsthalle'),
    (SELECT m.id_museo FROM MUSEOS m WHERE m.nombre = 'Hamburger Kunsthalle'),
    (SELECT ef.id_est FROM EST_FISICA ef JOIN MUSEOS m ON ef.id_museo = m.id_museo WHERE ef.nombre = 'Galerien 19. Jahrhundert KH' AND m.nombre = 'Hamburger Kunsthalle'),
    TO_DATE('1901-01-01', 'YYYY-MM-DD'), 
    'DONADA', 'SI', NULL, 9, 25000000.00);

PROMPT Data inserted into HIST_OBRAS_MOV table (MISSING RECORDS ADDED).
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
    1,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    TO_DATE('2025-06-04 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    'ADULTO',
    12.00
);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    2,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    TO_DATE('2025-06-04 10:32:15', 'YYYY-MM-DD HH24:MI:SS'),
    'ESTUDIANTE',
    7.00
);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    3,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Museum der bildenden Künste Leipzig'),
    TO_DATE('2025-06-05 14:05:30', 'YYYY-MM-DD HH24:MI:SS'),
    'INFANTIL',
    0.00
);

-- Tickets para Hamburger Kunsthalle
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    1,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    TO_DATE('2025-06-04 11:15:45', 'YYYY-MM-DD HH24:MI:SS'),
    'ADULTO',
    16.00
);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    2,
    (SELECT id_museo FROM MUSEOS WHERE nombre = 'Hamburger Kunsthalle'),
    TO_DATE('2025-06-04 11:17:00', 'YYYY-MM-DD HH24:MI:SS'),
    'ADULTO',
    16.00
);
INSERT INTO TICKETS (id_num_ticket, id_museo, fecha_hora_emision, tipo, precio) VALUES (
    3,
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







COMMIT;
SET DEFINE ON;

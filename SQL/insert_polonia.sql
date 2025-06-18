--INSERT LUGARES
    --Polonia
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Polonia', 'PAIS',NULL, 'EUROPA');
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

    --Otros Países
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Austria', 'PAIS',NULL, 'EUROPA');
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Viena', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Austria' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Dinamarca', 'PAIS',NULL, 'EUROPA');
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Copenhague', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Dinamarca' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Italia', 'PAIS',NULL, 'EUROPA');
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Roma', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Italia' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Reino Unido', 'PAIS',NULL, 'EUROPA');
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Londres', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Reino Unido' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Alemania', 'PAIS',NULL, 'EUROPA');
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Oederan', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Alemania' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Francia', 'PAIS',NULL, 'EUROPA');
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Misy-Sur-Yonne', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Francia' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Ucrania', 'PAIS',NULL, 'EUROPA');
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Ivano-Frankivsk', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Ucrania' AND tipo = 'PAIS'), null);
INSERT INTO lugares (nombre, tipo, id_lugar_padre, continente) values ('Drohobich', 'CIUDAD',
(SELECT id_lugar FROM LUGARES WHERE nombre = 'Ucrania' AND tipo = 'PAIS'), null);



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


--INSERT IDIOMAS
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



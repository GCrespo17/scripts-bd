-- Select para obtener la estructura organizacional

-- 1. Obtener todas las unidades organizacionales del museo

SELECT id_est_org, nombre, tipo, nivel, descripcion, id_est_org_padre
FROM EST_ORGANIZACIONAL
WHERE id_museo = :id_museo
ORDER BY nivel ASC, nombre ASC;

-- 2. Obtener todos los empleados actualmente asignados en ese museo

SELECT he.id_est_org, ep.id_empleado, ep.primer_nombre, ep.segundo_nombre, 
       ep.primer_apellido, ep.segundo_apellido, he.cargo, he.fecha_inicio, 
       ep.doc_identidad, he.fecha_fin
FROM HIST_EMPLEADOS he
JOIN EMPLEADOS_PROFESIONALES ep ON he.id_empleado_prof = ep.id_empleado
WHERE he.id_museo = :id_museo 
ORDER BY he.cargo DESC, ep.primer_apellido ASC;

-- Selects para obtener la estructura física

-- 1. Obtener todas las unidades físicas de un museo en específico 

SELECT 
    ef.id_est, 
    ef.nombre, 
    ef.tipo, 
    ef.descripcion, 
    ef.direccion_edificio, 
    ef.id_est_padre
FROM EST_FISICA ef
WHERE ef.id_museo = :id
ORDER BY ef.tipo DESC, ef.nombre ASC;

-- 2. Obtener todas las salas activas y sus exposiciones de un museo en específico 

SELECT 
    ee.nombre as nombre_evento,
    se.nombre as nombre_sala
FROM EXPOSICIONES_EVENTOS ee
JOIN SALAS_EXP se ON ee.id_sala = se.id_sala 
    AND ee.id_est = se.id_est AND ee.id_museo = se.id_museo
WHERE ee.id_museo = :id 
    AND ee.fecha_fin >= SYSDATE
ORDER BY ee.fecha_inicio ASC;

-- Selects para la ficha del museo

-- 1. Obtener información básica

SELECT id_museo, nombre, fecha_fundacion, mision 
FROM MUSEOS 
WHERE id_museo = :id;

-- 2. Obtener los registros históricos del museo 

SELECT anio, hecho 
FROM HIST_MUSEOS 
WHERE id_museo = :id 
ORDER BY anio ASC;

-- 3. Obtener las colecciones permanentes 

SELECT nombre 
FROM COLECCIONES_PERMANENTES 
WHERE id_museo = :id 
ORDER BY orden_recorrido ASC;

-- 4. Obtener el ranking (nacional y mundial) 

SELECT 
    ciudad,
    pais,
    antigüedad_promedio_anios,
    tasa_rotación_alta_pct,
    visitas_último_año,
    estabilidad_score,
    popularidad_score,
    score_final,
    categoría_ranking,
    posición_mundial,
    total_mundial,
    posición_nacional,
    total_nacional
FROM V_MUSEOS_RANKING_SCORES 
WHERE id_museo = :id;

-- Selects para el expediente del empleado

-- 1. Obtener los datos del empleado 

SELECT * FROM EMPLEADOS_PROFESIONALES 
WHERE id_empleado = :id;

-- 2. Obtener su formación académica 

SELECT titulo, anio, descripcion_espec 
FROM FORMACIONES 
WHERE id_empleado_prof = :id 
ORDER BY anio DESC;

-- 3. Obtener los idiomas que habla el empleado 

SELECT i.nombre 
FROM IDIOMAS i 
JOIN EMPLEADOS_IDIOMAS ei ON i.id_idioma = ei.id_idioma 
WHERE ei.id_empleado = :id;

-- 4. Obtener el historial del empleado

SELECT h.fecha_inicio, h.fecha_fin, h.cargo, e.nombre as unidad_organizativa, m.nombre as museo
FROM HIST_EMPLEADOS h
JOIN EST_ORGANIZACIONAL e ON h.id_est_org = e.id_est_org
JOIN MUSEOS m ON h.id_museo = m.id_museo
WHERE h.id_empleado_prof = :id
ORDER BY h.fecha_inicio DESC;




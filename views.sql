
-- -----------------------------------------------------------------------------
-- VISTA: VW_MOVIMIENTOS_ACTIVOS
-- -----------------------------------------------------------------------------
-- Descripción: Vista que facilita la consulta de movimientos de obras activos
-- utilizando únicamente las tablas del modelo ER original
-- -----------------------------------------------------------------------------

CREATE OR REPLACE VIEW VW_MOVIMIENTOS_ACTIVOS AS
SELECT 
    hom.id_catalogo_museo,
    hom.id_obra,
    o.nombre as nombre_obra,
    m.nombre as museo,
    hom.fecha_entrada,
    hom.fecha_salida,
    hom.tipo_adquisicion,
    hom.destacada,
    hom.orden_recorrido,
    hom.valor_monetario,
    CASE 
        WHEN hom.fecha_salida IS NULL THEN 'ACTIVA'
        ELSE 'FINALIZADA'
    END as estado_movimiento,
    -- Información adicional útil
    SYSDATE - hom.fecha_entrada as dias_en_ubicacion
FROM HIST_OBRAS_MOV hom
JOIN OBRAS o ON hom.id_obra = o.id_obra
JOIN MUSEOS m ON hom.id_museo = m.id_museo
WHERE hom.fecha_salida IS NULL  -- Solo movimientos activos
ORDER BY m.nombre, hom.fecha_entrada DESC;

-- =============================================================================
-- FIN DEL SCRIPT DE CREACIÓN UNIFICADA
-- =============================================================================



-- -----------------------------------------------------------------------------
-- VISTA: V_MUSEOS_RANKING_SCORES
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 15-NOV-2024
-- Descripción:
-- Vista que calcula los puntajes de ranking para todos los museos, permitiendo
-- comparaciones nacionales y mundiales. Reutiliza la lógica del SP_CALCULAR_RANKING_MUSEO
-- pero de forma eficiente para múltiples museos.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW V_MUSEOS_RANKING_SCORES AS
WITH EstabilidadPersonal AS (
    -- Calcular métricas de estabilidad del personal por museo
    SELECT 
        he.id_museo,
        COUNT(*) as total_empleados,
        AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25) as antiguedad_promedio_anios,
        SUM(CASE WHEN (COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) < (365.25 * 5) THEN 1 ELSE 0 END) / COUNT(*) * 100 as tasa_rotacion_alta_pct,
        -- Asignar puntaje de estabilidad (0 a 10)
        LEAST(AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25), 10) as estabilidad_score
    FROM HIST_EMPLEADOS he
    GROUP BY he.id_museo
),
PopularidadVisitas AS (
    -- Calcular métricas de popularidad por visitas anuales
    SELECT 
        t.id_museo,
        COUNT(*) as visitas_ultimo_anio,
        -- Asignar puntaje de popularidad (0 a 10)
        CASE 
            WHEN COUNT(*) > 1000000 THEN 10
            WHEN COUNT(*) > 500000 THEN 8
            WHEN COUNT(*) > 250000 THEN 6
            WHEN COUNT(*) > 100000 THEN 4
            WHEN COUNT(*) > 50000 THEN 2
            ELSE 1
        END as popularidad_score
    FROM TICKETS t
    WHERE t.fecha_hora_emision >= (SYSDATE - 365)
    GROUP BY t.id_museo
),
UbicacionMuseos AS (
    -- Obtener la ubicación (país) de cada museo
    SELECT 
        m.id_museo,
        m.nombre as nombre_museo,
        ciudad.nombre as ciudad,
        pais.id_lugar as id_pais,
        pais.nombre as pais
    FROM MUSEOS m
    JOIN LUGARES ciudad ON m.id_lugar = ciudad.id_lugar
    JOIN LUGARES pais ON ciudad.id_lugar_padre = pais.id_lugar
    WHERE ciudad.tipo = 'CIUDAD' AND pais.tipo = 'PAIS'
)
SELECT 
    um.id_museo,
    um.nombre_museo,
    um.ciudad,
    um.id_pais,
    um.pais,
    COALESCE(ep.antiguedad_promedio_anios, 0) as antiguedad_promedio_anios,
    COALESCE(ep.tasa_rotacion_alta_pct, 0) as tasa_rotacion_alta_pct,
    COALESCE(pv.visitas_ultimo_anio, 0) as visitas_ultimo_anio,
    COALESCE(ep.estabilidad_score, 1) as estabilidad_score,
    COALESCE(pv.popularidad_score, 1) as popularidad_score,
    -- Calcular puntaje final (60% estabilidad, 40% popularidad)
    (COALESCE(ep.estabilidad_score, 1) * 0.6) + (COALESCE(pv.popularidad_score, 1) * 0.4) as score_final,
    -- Asignar categoría descriptiva
    CASE 
        WHEN (COALESCE(ep.estabilidad_score, 1) * 0.6) + (COALESCE(pv.popularidad_score, 1) * 0.4) >= 8 THEN
            'Excelente (Líder del Sector)'
        WHEN (COALESCE(ep.estabilidad_score, 1) * 0.6) + (COALESCE(pv.popularidad_score, 1) * 0.4) >= 6 THEN
            'Bueno (Sólido y Reconocido)'
        WHEN (COALESCE(ep.estabilidad_score, 1) * 0.6) + (COALESCE(pv.popularidad_score, 1) * 0.4) >= 4 THEN
            'Regular (Estable con Potencial)'
        ELSE
            'En Desarrollo (Nicho o Volátil)'
    END as categoria_ranking
FROM UbicacionMuseos um
LEFT JOIN EstabilidadPersonal ep ON um.id_museo = ep.id_museo
LEFT JOIN PopularidadVisitas pv ON um.id_museo = pv.id_museo;
/
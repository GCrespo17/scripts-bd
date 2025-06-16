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
-- Fecha de Modificación: 15-DIC-2024
-- Descripción:
-- Vista que calcula los puntajes de ranking para todos los museos, implementando
-- la nueva lógica de ranking basada PRIORITARIAMENTE en rotación de empleados:
-- 1. PRIORIDAD PRINCIPAL: Rotación de empleados (tiempo de permanencia promedio)
--    - Promedio > 10 años = puntuación 1 (MEJOR, baja rotación)
--    - Promedio entre 5-10 años = puntuación 2 (MEDIO)
--    - Promedio < 5 años = puntuación 3 (PEOR, alta rotación)
-- 2. CRITERIO DE DESEMPATE: Rangos de tickets vendidos en el último año
--    - 50+ visitas = puntuación 1, 25-49 = puntuación 2, etc.
-- Incluye posiciones de ranking pre-calculadas nacionales y mundiales.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW V_MUSEOS_RANKING_SCORES AS
WITH EstabilidadPersonal AS (
    -- Calcular métricas de estabilidad del personal por museo
    SELECT 
        he.id_museo,
        COUNT(*) as total_empleados,
        AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25) as antiguedad_promedio_anios,
        SUM(CASE WHEN (COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) < (365.25 * 5) THEN 1 ELSE 0 END) / COUNT(*) * 100 as tasa_rotacion_alta_pct,
        -- *** NUEVA LÓGICA: Asignar puntuación basada en rotación (1=mejor, 3=peor) ***
        CASE 
            WHEN AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25) > 10 THEN 1  -- MEJOR: baja rotación
            WHEN AVG((COALESCE(he.fecha_fin, SYSDATE) - he.fecha_inicio) / 365.25) >= 5 THEN 2  -- MEDIO
            ELSE 3  -- PEOR: alta rotación
        END as puntuacion_rotacion
    FROM HIST_EMPLEADOS he
    GROUP BY he.id_museo
),
PopularidadVisitas AS (
    -- Métricas de afluencia de visitantes (último año) - VOLUMEN TOTAL
    -- Incluye: tickets de entrada general + visitantes de exposiciones específicas
    SELECT 
        id_museo,
        (tickets_anuales + visitas_exposiciones_anuales) as visitas_ultimo_anio,
        -- Clasificación por rangos de popularidad (volumen total)
        CASE 
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 50 THEN 1  -- Excelente afluencia
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 25 THEN 2  -- Buena afluencia
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 10 THEN 3  -- Afluencia regular
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 5 THEN 4   -- Afluencia baja
            WHEN (tickets_anuales + visitas_exposiciones_anuales) >= 1 THEN 5   -- Afluencia muy baja
            ELSE 6                                                              -- Sin registro de visitas
        END as puntuacion_visitas
    FROM (
        SELECT 
            m.id_museo,
            -- Contar tickets de entrada general (último año)
            COALESCE((SELECT COUNT(*) 
                     FROM TICKETS t 
                     WHERE t.id_museo = m.id_museo 
                       AND t.fecha_hora_emision >= (SYSDATE - 365)), 0) as tickets_anuales,
            -- Sumar visitantes de exposiciones/eventos (último año)
            COALESCE((SELECT SUM(ee.cant_visitantes) 
                     FROM EXPOSICIONES_EVENTOS ee 
                     WHERE ee.id_museo = m.id_museo 
                       AND ee.cant_visitantes IS NOT NULL
                       AND ee.fecha_inicio >= (SYSDATE - 365)), 0) as visitas_exposiciones_anuales
        FROM MUSEOS m
    )
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
),
ScoresBase AS (
    -- Calcular scores base para todos los museos
    SELECT 
        um.id_museo,
        um.nombre_museo,
        um.ciudad,
        um.id_pais,
        um.pais,
        COALESCE(ROUND(ep.antiguedad_promedio_anios, 2), 0) as antiguedad_promedio_anios,
        COALESCE(ROUND(ep.tasa_rotacion_alta_pct, 2), 100) as tasa_rotacion_alta_pct,
        COALESCE(pv.visitas_ultimo_anio, 0) as visitas_ultimo_anio,
        -- *** NUEVA LÓGICA: Puntuación basada en rotación (1=mejor, 3=peor) ***
        COALESCE(ep.puntuacion_rotacion, 3) as puntuacion_rotacion,
        -- *** PUNTUACIÓN DE VISITAS POR RANGOS ***
        COALESCE(pv.puntuacion_visitas, 6) as puntuacion_visitas,
        -- *** SCORE FINAL MEJORADO: Rotación + Visitas como decimal ***
        -- Ejemplo: Rotación 1 + Visitas 3 = 1.03 (mejor que Rotación 2 + Visitas 1 = 2.01)
        COALESCE(ep.puntuacion_rotacion, 3) + (COALESCE(pv.puntuacion_visitas, 6) / 100.0) as score_final
    FROM UbicacionMuseos um
    LEFT JOIN EstabilidadPersonal ep ON um.id_museo = ep.id_museo
    LEFT JOIN PopularidadVisitas pv ON um.id_museo = pv.id_museo
)
SELECT 
    sb.id_museo,
    sb.nombre_museo,
    sb.ciudad,
    sb.id_pais,
    sb.pais,
    sb.antiguedad_promedio_anios,
    sb.tasa_rotacion_alta_pct,
    sb.visitas_ultimo_anio,
    -- Incluir puntuación de rotación para referencia
    sb.puntuacion_rotacion as estabilidad_score,
    -- Para compatibilidad, mantener popularidad_score basado en rangos
    CASE sb.puntuacion_visitas
        WHEN 1 THEN 10  -- 50+ visitas
        WHEN 2 THEN 8   -- 25-49 visitas  
        WHEN 3 THEN 6   -- 10-24 visitas
        WHEN 4 THEN 4   -- 5-9 visitas
        WHEN 5 THEN 2   -- 1-4 visitas
        ELSE 1          -- 0 visitas
    END as popularidad_score,
    sb.score_final,
    -- *** NUEVA LÓGICA: Categoría basada en puntuación de rotación ***
    CASE sb.puntuacion_rotacion
        WHEN 1 THEN 'Excelente (Personal Muy Estable - +10 años promedio)'
        WHEN 2 THEN 'Bueno (Personal Estable - 5-10 años promedio)'
        WHEN 3 THEN 'En Desarrollo (Alta Rotación - <5 años promedio)'
        ELSE 'Sin Clasificar (Datos Insuficientes)'
    END as categoria_ranking,
    -- *** RANKING CON NUEVA LÓGICA: Primero por rotación, luego por visitas ***
    -- Ranking Mundial (todos los museos) - menor score_final = mejor posición
    RANK() OVER (ORDER BY sb.score_final ASC) as posicion_mundial,
    COUNT(*) OVER () as total_mundial,
    -- Ranking Nacional (museos del mismo país) - menor score_final = mejor posición
    RANK() OVER (PARTITION BY sb.id_pais ORDER BY sb.score_final ASC) as posicion_nacional,
    COUNT(*) OVER (PARTITION BY sb.id_pais) as total_nacional
FROM ScoresBase sb;
/
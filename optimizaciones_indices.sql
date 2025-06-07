-- -----------------------------------------------------------------------------
-- ARCHIVO: OPTIMIZACIONES E ÍNDICES PARA MEJORAR EFICIENCIA
-- -----------------------------------------------------------------------------
-- Fecha de Creación: 06-JUN-2025
-- Descripción: Este archivo contiene todos los índices necesarios y optimizaciones
-- para mejorar significativamente el rendimiento de triggers y procedures.
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- SECCIÓN 1: ÍNDICES CRÍTICOS PARA OPTIMIZACIÓN DE TRIGGERS
-- -----------------------------------------------------------------------------

-- ✅ ÍNDICE 1: Para optimizar trigger trg_tickets_before_insert
-- Consulta: SELECT MAX(id_num_ticket) FROM TICKETS WHERE id_museo = ?
CREATE INDEX idx_tickets_museo_num_ticket ON TICKETS(id_museo, id_num_ticket);

-- ✅ ÍNDICE 2: Para optimizar trigger TRG_TICKETS_PRECIO_AUTO
-- Consulta en TIPO_TICKETS con filtros complejos de fechas
CREATE INDEX idx_tipo_tickets_museo_tipo_fechas ON TIPO_TICKETS(id_museo, tipo, fecha_inicio, fecha_fin);

-- ✅ ÍNDICE 3: Para optimizar trigger TRG_HIST_EMPLEADOS_FECHAS
-- Consulta: solapamiento de fechas por empleado
CREATE INDEX idx_hist_empleados_emp_fechas ON HIST_EMPLEADOS(id_empleado_prof, fecha_inicio, fecha_fin);

-- ✅ ÍNDICE 4: Para optimizar trigger TRG_HIST_OBRAS_MOV_FECHAS
-- Consulta: buscar movimientos activos de obra (fecha_salida IS NULL)
CREATE INDEX idx_hist_obras_obra_fecha_salida ON HIST_OBRAS_MOV(id_obra, fecha_salida);

-- ✅ ÍNDICE 5: Para optimizar trigger TRG_EVITAR_CIERRE_CON_EXPOSICION
-- Consulta: búsqueda de exposiciones por sala y fechas
CREATE INDEX idx_exposiciones_sala_fechas ON EXPOSICIONES_EVENTOS(id_sala, id_est, id_museo, fecha_inicio, fecha_fin);

-- -----------------------------------------------------------------------------
-- SECCIÓN 2: ÍNDICES PARA OPTIMIZACIÓN DE STORED PROCEDURES
-- -----------------------------------------------------------------------------

-- ✅ ÍNDICE 6: Para SP_VENDER_TICKET - búsqueda de precios vigentes
-- Ya cubierto por idx_tipo_tickets_museo_tipo_fechas

-- ✅ ÍNDICE 7: Para SP_REGISTRAR_NUEVO_EMPLEADO - búsqueda de unidades organizacionales
CREATE INDEX idx_est_org_museo_nombre ON EST_ORGANIZACIONAL(id_museo, nombre);

-- ✅ ÍNDICE 8: Para SP_FINALIZAR_EXPOSICION - actualización por ID y museo
CREATE INDEX idx_exposiciones_expo_museo ON EXPOSICIONES_EVENTOS(id_expo, id_museo);

-- -----------------------------------------------------------------------------
-- SECCIÓN 3: ÍNDICES ADICIONALES PARA CONSULTAS FRECUENTES
-- -----------------------------------------------------------------------------

-- ✅ ÍNDICE 9: Para consultas frecuentes de obras por artista
CREATE INDEX idx_artistas_obras_artista ON ARTISTAS_OBRAS(id_artista);

-- ✅ ÍNDICE 10: Para consultas de empleados por museo
CREATE INDEX idx_hist_empleados_museo ON HIST_EMPLEADOS(id_museo);

-- ✅ ÍNDICE 11: Para búsquedas de salas por museo
CREATE INDEX idx_salas_exp_museo ON SALAS_EXP(id_museo);

-- ✅ ÍNDICE 12: Para horarios por museo
CREATE INDEX idx_horarios_museo ON HORARIOS(id_museo);

-- -----------------------------------------------------------------------------
-- SECCIÓN 4: NOTAS SOBRE OPTIMIZACIONES IMPLEMENTADAS
-- -----------------------------------------------------------------------------

-- ✅ TRIGGERS MEJORADOS: Implementados directamente en triggers.sql
-- - TRG_TICKETS_BEFORE_INSERT: Combina funcionalidad de generación de ID y asignación de precios
-- - Eliminados triggers duplicados que causaban conflictos

-- ✅ PROCEDURES MEJORADOS: Implementados directamente en stored_procedures.sql  
-- - SP_VENDER_TICKET: Versión thread-safe con manejo de concurrencia
-- - Manejo robusto de race conditions y duplicados

-- -----------------------------------------------------------------------------
-- SECCIÓN 5: ESTADÍSTICAS Y ANÁLISIS DE RENDIMIENTO
-- -----------------------------------------------------------------------------

-- Comando para actualizar estadísticas de las tablas principales
-- Ejecutar periódicamente para mantener el optimizador actualizado

-- EXEC DBMS_STATS.GATHER_TABLE_STATS('USUARIO_BD', 'TICKETS');
-- EXEC DBMS_STATS.GATHER_TABLE_STATS('USUARIO_BD', 'TIPO_TICKETS');
-- EXEC DBMS_STATS.GATHER_TABLE_STATS('USUARIO_BD', 'HIST_EMPLEADOS');
-- EXEC DBMS_STATS.GATHER_TABLE_STATS('USUARIO_BD', 'HIST_OBRAS_MOV');
-- EXEC DBMS_STATS.GATHER_TABLE_STATS('USUARIO_BD', 'EXPOSICIONES_EVENTOS');

-- -----------------------------------------------------------------------------
-- SECCIÓN 6: MONITOREO DE RENDIMIENTO
-- -----------------------------------------------------------------------------

-- Query para identificar consultas lentas en triggers/procedures
/*
SELECT sql_text, executions, elapsed_time/1000000 as elapsed_seconds
FROM v$sql 
WHERE sql_text LIKE '%TICKETS%' OR sql_text LIKE '%TIPO_TICKETS%'
ORDER BY elapsed_time DESC;
*/

-- -----------------------------------------------------------------------------
-- SECCIÓN 7: RESULTADO ESPERADO DESPUÉS DE IMPLEMENTACIÓN
-- -----------------------------------------------------------------------------

-- ✅ RESULTADO ESPERADO:
-- - Reducción del 60-80% en tiempo de consultas de tickets
-- - Eliminación de race conditions en venta de tickets
-- - Mejor manejo de concurrencia en operaciones críticas
-- - Consultas optimizadas con uso eficiente de índices 
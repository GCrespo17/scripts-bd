-- -----------------------------------------------------------------------------
-- OPTIMIZACIONES E ÍNDICES PARA BASE DE DATOS
-- -----------------------------------------------------------------------------
-- Descripción: Índices para optimizar triggers, stored procedures y consultas del backend
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- ÍNDICES PARA TRIGGERS
-- -----------------------------------------------------------------------------

-- Para consultas de generación de ID de tickets en backend
CREATE INDEX idx_tickets_museo_num_ticket ON TICKETS(id_museo, id_num_ticket);

-- Para consultas de precios de tickets
CREATE INDEX idx_tipo_tickets_museo_tipo_fechas ON TIPO_TICKETS(id_museo, tipo, fecha_inicio, fecha_fin);

-- Para validación de solapamiento de fechas por empleado
CREATE INDEX idx_hist_empleados_emp_fechas ON HIST_EMPLEADOS(id_empleado_prof, fecha_inicio, fecha_fin);

-- Para buscar movimientos activos de obra
CREATE INDEX idx_hist_obras_obra_fecha_salida ON HIST_OBRAS_MOV(id_obra, fecha_salida);

-- Para búsqueda de exposiciones por sala y fechas
CREATE INDEX idx_exposiciones_sala_fechas ON EXPOSICIONES_EVENTOS(id_sala, id_est, id_museo, fecha_inicio, fecha_fin);

-- Para buscar mantenimientos abiertos por obra
CREATE INDEX idx_mant_obras_catalogo_obra_fecha ON MANTENIMIENTOS_OBRAS_REALIZADOS(id_catalogo, id_obra, fecha_fin);

-- Para buscar cierres abiertos por sala
CREATE INDEX idx_cierres_sala_fecha_fin ON CIERRES_TEMPORALES(id_sala, id_est, id_museo, fecha_fin);

-- Para buscar precios abiertos por museo y tipo
CREATE INDEX idx_tipo_tickets_museo_tipo_fin ON TIPO_TICKETS(id_museo, tipo, fecha_fin);

-- -----------------------------------------------------------------------------
-- ÍNDICES PARA STORED PROCEDURES
-- -----------------------------------------------------------------------------

-- Para búsqueda de unidades organizacionales
CREATE INDEX idx_est_org_museo_nombre ON EST_ORGANIZACIONAL(id_museo, nombre);

-- Para actualización de exposiciones por ID y museo
CREATE INDEX idx_exposiciones_expo_museo ON EXPOSICIONES_EVENTOS(id_expo, id_museo);

-- Para buscar empleados por museo y cargo
CREATE INDEX idx_hist_empleados_museo_cargo_activo ON HIST_EMPLEADOS(id_museo, cargo, fecha_fin);

-- Para cálculo de ranking por visitas anuales
CREATE INDEX idx_tickets_museo_fecha ON TICKETS(id_museo, fecha_hora_emision);

-- -----------------------------------------------------------------------------
-- ÍNDICES PARA CONSULTAS DEL BACKEND
-- -----------------------------------------------------------------------------

-- Para consultas de obras activas por museo
CREATE INDEX idx_hist_obras_museo_activas ON HIST_OBRAS_MOV(id_museo, fecha_salida, id_obra);

-- Para obtener empleados por museo y cargo
CREATE INDEX idx_hist_empleados_museo_cargo ON HIST_EMPLEADOS(id_museo, cargo, fecha_fin);

-- Para consultas de salas por museo
CREATE INDEX idx_salas_exp_museo ON SALAS_EXP(id_museo);

-- Para consultas de estructura organizacional
CREATE INDEX idx_est_org_museo ON EST_ORGANIZACIONAL(id_museo);

-- Para consultas de estructura física
CREATE INDEX idx_est_fisica_museo ON EST_FISICA(id_museo);

-- Para consultas de exposiciones por fechas
CREATE INDEX idx_exposiciones_fechas_activas ON EXPOSICIONES_EVENTOS(fecha_inicio, fecha_fin, id_museo);

-- -----------------------------------------------------------------------------
-- ÍNDICES ADICIONALES
-- -----------------------------------------------------------------------------

-- Para consultas de obras por artista
CREATE INDEX idx_artistas_obras_artista ON ARTISTAS_OBRAS(id_artista);

-- Para horarios por museo
CREATE INDEX idx_horarios_museo ON HORARIOS(id_museo);

-- Para formaciones por empleado
CREATE INDEX idx_formaciones_empleado ON FORMACIONES(id_empleado_prof);

-- Para programas de mantenimiento
CREATE INDEX idx_programas_mant_catalogo_obra ON PROGRAMAS_MANT(id_catalogo, id_obra);

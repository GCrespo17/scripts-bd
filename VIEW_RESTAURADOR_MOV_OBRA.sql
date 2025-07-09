CREATE OR REPLACE VIEW HIST_MOV_OBR_REST AS
SELECT
    h.id_catalogo_museo,
    h.id_obra,
    h.id_coleccion,
    h.id_sala,
    h.id_empleado,
    h.id_est_org,
    h.id_museo,
    h.id_est_fis,
    h.fecha_entrada,
    h.tipo_adquisicion,
    h.destacada,
    h.fecha_salida,
    h.orden_recorrido
FROM
    HIST_OBRAS_MOV h

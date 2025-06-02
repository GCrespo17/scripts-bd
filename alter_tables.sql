ALTER TABLE LUGARES
    ADD CONSTRAINT fk_id_lugar_padre FOREIGN KEY(id_lugar_padre) REFERENCES LUGARES(id_lugar);

ALTER TABLE ARTISTAS
    ADD CONSTRAINT fk_id_lugar_artista FOREIGN KEY(id_lugar) REFERENCES LUGARES(id_lugar);

ALTER TABLE ARTISTAS_OBRAS
    ADD CONSTRAINT fk_obra_artista FOREIGN KEY(id_obra) REFERENCES OBRAS(id_obra);
ALTER TABLE ARTISTAS_OBRAS
    ADD CONSTRAINT fk_artista_obra FOREIGN KEY(id_artista) REFERENCES ARTISTAS(id_artista);

ALTER TABLE EMPLEADOS_IDIOMAS
    ADD CONSTRAINT fk_empleado_idioma FOREIGN KEY(id_empleado) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado);
ALTER TABLE EMPLEADOS_IDIOMAS
    ADD CONSTRAINT fk_idioma_empleado FOREIGN KEY(id_idioma) REFERENCES IDIOMAS(id_idioma);

ALTER TABLE FORMACIONES
    ADD CONSTRAINT fk_empleado_prof_formacion FOREIGN KEY(id_empleado_prof) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado);

ALTER TABLE MUSEOS
    ADD CONSTRAINT fk_lugar_museo FOREIGN KEY(id_lugar) REFERENCES LUGARES(id_lugar);

ALTER TABLE EST_FISICA
    ADD CONSTRAINT fk_museo_est_fisica FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo);
ALTER TABLE EST_FISICA
    ADD CONSTRAINT fk_est_fisica_padre FOREIGN KEY(id_est_padre, id_museo) REFERENCES EST_FISICA(id_est, id_museo);

ALTER TABLE ASIGNACIONES_MES
    ADD CONSTRAINT fk_est_museo_asignacion FOREIGN KEY(id_est, id_museo) REFERENCES EST_FISICA(id_est, id_museo);
ALTER TABLE ASIGNACIONES_MES
    ADD CONSTRAINT fk_vig_mant_asignacion FOREIGN KEY(id_vig_mant) REFERENCES EMPLEADOS_VIGILANTE_MANT(id_vig_mant);

ALTER TABLE SALAS_EXP
    ADD CONSTRAINT fk_est_museo_sala FOREIGN KEY(id_est, id_museo) REFERENCES EST_FISICA(id_est, id_museo);

ALTER TABLE EXPOSICIONES_EVENTOS
    ADD CONSTRAINT fk_sala_est_museo_exposicion FOREIGN KEY(id_sala, id_est, id_museo) REFERENCES SALAS_EXP(id_sala, id_est, id_museo);

ALTER TABLE CIERRES_TEMPORALES
    ADD CONSTRAINT fk_sala_est_museo_cierretemp FOREIGN KEY(id_sala, id_est, id_museo) REFERENCES SALAS_EXP(id_sala, id_est, id_museo);

ALTER TABLE EST_ORGANIZACIONAL
    ADD CONSTRAINT fk_museo_est_org FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo);
ALTER TABLE EST_ORGANIZACIONAL
    ADD CONSTRAINT fk_est_org_padre FOREIGN KEY(id_est_org_padre, id_museo) REFERENCES EST_ORGANIZACIONAL(id_est_org, id_museo);

ALTER TABLE COLECCIONES_PERMANENTES
    ADD CONSTRAINT fk_est_org_museo_coleccion FOREIGN KEY(id_est_org, id_museo) REFERENCES EST_ORGANIZACIONAL(id_est_org, id_museo);

ALTER TABLE SALAS_COLECCIONES
    ADD CONSTRAINT fk_sala_estfis_museo_sala FOREIGN KEY(id_sala, id_est_org, id_museo) REFERENCES SALAS_EXP(id_sala, id_est, id_museo);
ALTER TABLE SALAS_COLECCIONES
    ADD CONSTRAINT fk_coleccion_estorg_museo_coleccion FOREIGN KEY(id_coleccion, id_est_org, id_museo) REFERENCES COLECCIONES_PERMANENTES(id_coleccion, id_est_org, id_museo);

ALTER TABLE HIST_EMPLEADOS
    ADD CONSTRAINT fk_est_org_museo_hist_emp FOREIGN KEY(id_est_org, id_museo) REFERENCES EST_ORGANIZACIONAL(id_est_org, id_museo);
ALTER TABLE HIST_EMPLEADOS
    ADD CONSTRAINT fk_empleado_hist_emp FOREIGN KEY(id_empleado_prof) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado);

ALTER TABLE HIST_OBRAS_MOV
    ADD CONSTRAINT fk_obra_hist_obra FOREIGN KEY(id_obra) REFERENCES OBRAS(id_obra);
ALTER TABLE HIST_OBRAS_MOV
    ADD CONSTRAINT fk_coleccion_hist_obra FOREIGN KEY(id_coleccion, id_est_org, id_museo) REFERENCES COLECCIONES_PERMANENTES(id_coleccion, id_est_org, id_museo);
ALTER TABLE HIST_OBRAS_MOV
    ADD CONSTRAINT fk_sala_hist_obra FOREIGN KEY(id_sala, id_est_fis, id_museo) REFERENCES SALAS_EXP(id_sala, id_est, id_museo);
ALTER TABLE HIST_OBRAS_MOV
    ADD CONSTRAINT fk_empleado_hist_obra FOREIGN KEY(id_empleado) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado);

ALTER TABLE PROGRAMAS_MANT
    ADD CONSTRAINT fk_catalogo_mant FOREIGN KEY(id_catalogo, id_obra) REFERENCES HIST_OBRAS_MOV(id_catalogo_museo, id_obra);

ALTER TABLE MANTENIMIENTOS_OBRAS_REALIZADOS
    ADD CONSTRAINT fk_mantenimiento_mant_realizado FOREIGN KEY(id_mant, id_catalogo, id_obra) REFERENCES PROGRAMAS_MANT(id_mant, id_catalogo, id_obra);
ALTER TABLE MANTENIMIENTOS_OBRAS_REALIZADOS
    ADD CONSTRAINT fk_empleado_mant_realizado FOREIGN KEY(id_empleado) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado);

ALTER TABLE HORARIOS
    ADD CONSTRAINT fk_museo_horario FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo);

ALTER TABLE TICKETS
    ADD CONSTRAINT fk_museo_ticket FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo);

ALTER TABLE HIST_MUSEOS
    ADD CONSTRAINT fk_museo_hist_museo FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo);

ALTER TABLE TIPO_TICKETS
    ADD CONSTRAINT fk_museo_tipo_ticket FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo);



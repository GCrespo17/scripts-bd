ALTER TABLE LUGARES
    ADD CONSTRAINT fk_id_lugar_padre FOREIGN KEY(id_lugar_padre) REFERENCES LUGARES(id_lugar);

ALTER TABLE ARTISTAS
    ADD CONSTRAINT fk_id_lugar FOREIGN KEY(id_lugar) REFERENCES LUGARES(id_lugar);

ALTER TABLE ARTISTAS_OBRAS
    ADD CONSTRAINT fk_obra FOREIGN KEY(id_obra) REFERENCES OBRAS(id_obra)
    ADD CONSTRAINT fk_artista FOREIGN KEY(id_artista) REFERENCES ARTISTAS(id_artista);

ALTER TABLE EMPLEADOS_IDIOMAS
    ADD CONSTRAINT fk_empleado FOREIGN KEY(id_empleado) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado)
    ADD CONSTRAINT fk_idioma FOREIGN KEY(id_idioma) REFERENCES IDIOMAS(id_idioma);

ALTER TABLE FORMACIONES
    ADD CONSTRAINT fk_empleado_prof FOREIGN KEY(id_empleado_prof) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado);

ALTER TABLE MUSEOS
    ADD CONSTRAINT fk_lugar FOREIGN KEY(id_lugar) REFERENCES LUGARES(id_lugar);

ALTER TABLE EST_FISICA
    ADD CONSTRAINT fk_est_fisica_padre FOREIGN KEY(id_est_padre) REFERENCES EST_FISICA(id_est)
    ADD CONSTRAINT fk_museo FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo);

ALTER TABLE ASIGNACIONES_MES
    ADD CONSTRAINT fk_est_museo FOREIGN KEY(id_est, id_museo) REFERENCES EST_FISICA(id_est, id_museo)
    ADD CONSTRAINT fk_vig_mant FOREIGN KEY(id_vig_mant) REFERENCES EMPLEADOS_VIGILANTE_MANT(id_vig_mant);

ALTER TABLE SALAS_EXP
    ADD CONSTRAINT fk_est_museo FOREIGN KEY(id_est, id_museo) REFERENCES EST_FISICA(id_est, id_museo);

ALTER TABLE EXPOSICIONES_EVENTOS
    ADD CONSTRAINT fk_sala_est_museo FOREIGN KEY(id_sala, id_est, id_museo) REFERENCES SALAS_COLECCIONES(id_sala, id_est, id_museo);

ALTER TABLE CIERRES_TEMPORALES
    ADD CONSTRAINT fk_sala_est_museo FOREIGN KEY(id_sala, id_est, id_museo) REFERENCES SALAS_COLECCIONES(id_sala, id_est, id_museo);

ALTER TABLE EST_ORGANIZACIONAL
    ADD CONSTRAINT fk_est_org_padre FOREIGN KEY(id_est_org_padre) REFERENCES EST_ORGANIZACIONAL(id_est_org)
    ADD CONSTRAINT fk_museo FOREIGN KEY(id_museo) REFERENCES MUSEOS(id_museo);

ALTER TABLE COLECCIONES_PERMANENTES
    ADD CONSTRAINT fk_est_org_museo FOREIGN KEY(id_est_org, id_museo) REFERENCES EST_ORGANIZACIONAL(id_est_org, id_museo);

ALTER TABLE SALAS_COLECCIONES
    ADD CONSTRAINT fk_sala_estfis_museo FOREIGN KEY(id_sala, id_est_org, id_museo) REFERENCES SALAS_EXP(id_sala, id_est, id_museo)
    ADD CONSTRAINT fk_coleccion_estorg_museo FOREIGN KEY(id_coleccion, id_est_org, id_museo) REFERENCES COLECCIONES_PERMANENTES(id_coleccion, id_est_org, id_museo);

ALTER TABLE HIST_EMPLEADOS
    ADD CONSTRAINT fk_est_org_museo FOREIGN KEY(id_est_org, id_museo) REFERENCES EST_ORGANIZACIONAL(id_est_org, id_museo)
    ADD CONSTRAINT fk_empleado FOREIGN KEY(id_empleado) REFERENCES EMPLEADOS_PROFESIONALES(id_empleado);





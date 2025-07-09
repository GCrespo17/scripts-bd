CREATE OR REPLACE FUNCTION INGRESOS_TOTAL_EVENTO_EXPO(
    p_id_museo IN MUSEOS.id_museo%TYPE
) RETURN NUMBER
IS
    v_ingresos_totales NUMBER := 0 ;
BEGIN
    FOR selected_event_expo IN (SELECT e.costo_persona, e.cant_visitantes FROM EXPOSICIONES_EVENTOS e WHERE id_museo = p_id_museo)
    LOOP
        v_ingresos_totales:= v_ingresos_totales + (NVL(selected_event_expo.costo_persona, 0)*NVL(selected_event_expo.cant_visitantes,0));
    END LOOP;

    RETURN v_ingresos_totales;
END INGRESOS_TOTAL_EVENTO_EXPO;
/
CREATE OR REPLACE FUNCTION INGRESO_POR_EVENTO(
    p_id_museo IN MUSEOS.id_museo%TYPE,
    P_id_expo IN EXPOSICIONES_EVENTOS.id_expo%TYPE
) RETURN NUMBER
IS
    v_ingreso_evento NUMBER;
BEGIN
    SELECT NVL(e.costo_persona,0)*NVL(e.cant_visitantes,0)
    INTO v_ingreso_evento
    FROM EXPOSICIONES_EVENTOS e
    WHERE e.id_museo = p_id_museo
    AND e.id_expo = p_id_expo;

    RETURN v_ingreso_evento;
END INGRESO_POR_EVENTO;
/



CREATE OR REPLACE PROCEDURE SP_MOSTRAR_INGRESOS_TOTAL_EVENTO_EXPO(
    p_id_museo IN MUSEOS.id_museo%TYPE
)
IS
    v_nombre_museo  MUSEOS.nombre%TYPE;
    v_ingresos_totales NUMBER;
BEGIN
    SELECT m.nombre, INGRESOS_TOTAL_EVENTO_EXPO(m.id_museo)
    INTO v_nombre_museo, v_ingresos_totales
    FROM MUSEOS m
    WHERE m.id_museo = p_id_museo;

    DBMS_OUTPUT.PUT_LINE('ID DEL MUSEO: '|| p_id_museo);
    DBMS_OUTPUT.PUT_LINE('NOMBRE DEL MUSEO: ' || v_nombre_museo);
    DBMS_OUTPUT.PUT_LINE('INGRESOS TOTALES POR EVENTOS/EXPOSICIONES:'||TO_CHAR(v_ingresos_totales, '$999,999,999,990.999'));

END SP_MOSTRAR_INGRESOS_TOTAL_EVENTO_EXPO;
/


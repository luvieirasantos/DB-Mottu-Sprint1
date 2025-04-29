
-- Terceiro Bloco Anônimo: Mostrar linha anterior, atual e próxima
DECLARE
    CURSOR c_motos IS
        SELECT moto_id, placa
        FROM mottu_moto
        ORDER BY moto_id;
    
    v_placa_anterior mottu_moto.placa%TYPE := 'Vazio';
    v_placa_atual mottu_moto.placa%TYPE;
    v_placa_proxima mottu_moto.placa%TYPE;
    
    TYPE t_lista IS TABLE OF mottu_moto.placa%TYPE INDEX BY PLS_INTEGER;
    lista_placas t_lista;
    contador INTEGER := 0;
BEGIN
    -- Carregar as placas na memória
    FOR rec IN c_motos LOOP
        contador := contador + 1;
        lista_placas(contador) := rec.placa;
    END LOOP;

    -- Mostrar linha anterior, atual e próxima
    FOR i IN 1 .. contador LOOP
        v_placa_anterior := CASE WHEN i-1 >= 1 THEN lista_placas(i-1) ELSE 'Vazio' END;
        v_placa_atual := lista_placas(i);
        v_placa_proxima := CASE WHEN i+1 <= contador THEN lista_placas(i+1) ELSE 'Vazio' END;

        DBMS_OUTPUT.PUT_LINE('Anterior: ' || v_placa_anterior || ' | Atual: ' || v_placa_atual || ' | Próxima: ' || v_placa_proxima);
    END LOOP;
END;

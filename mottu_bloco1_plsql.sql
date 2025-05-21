set serveroutput ON
set verify off

-- Primeiro Bloco Anônimo: Consulta com JOIN, GROUP BY e ORDER BY
DECLARE
    CURSOR c_motos IS
        SELECT 
            sm.nome AS status_moto,
            COUNT(m.moto_id) AS total_motos
        FROM mottu_moto m
        JOIN mottu_status_moto sm ON m.status_id = sm.status_id
        JOIN mottu_zona z ON m.zona_id = z.zona_id
        GROUP BY sm.nome
        ORDER BY sm.nome;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Status da Moto         | Total de Motos');
    DBMS_OUTPUT.PUT_LINE('------------------------|----------------');
    
    FOR rec IN c_motos LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.status_moto, 24) || '| ' || rec.total_motos);
    END LOOP;
END;
/



-- Bloco Adicional 1: Quantidade de motos por zona
DECLARE
    CURSOR c_motos_zona IS
        SELECT 
            z.codigo AS zona,
            COUNT(m.moto_id) AS total_motos
        FROM mottu_moto m
        JOIN mottu_zona z ON m.zona_id = z.zona_id
        GROUP BY z.codigo
        ORDER BY z.codigo;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Zona     | Total de Motos');
    DBMS_OUTPUT.PUT_LINE('---------|----------------');

    FOR rec IN c_motos_zona LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.zona, 9) || '| ' || rec.total_motos);
    END LOOP;
END;
/



-- Bloco Adicional 2: Quantidade de movimentações por operador
DECLARE
    CURSOR c_mov_operador IS
        SELECT 
            o.nome AS operador,
            COUNT(mov.movimentacao_id) AS total_movimentacoes
        FROM mottu_movimentacao mov
        JOIN mottu_operador o ON mov.operador_id = o.operador_id
        GROUP BY o.nome
        ORDER BY total_movimentacoes DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Operador            | Total de Movimentações');
    DBMS_OUTPUT.PUT_LINE('--------------------|------------------------');

    FOR rec IN c_mov_operador LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.operador, 20) || '| ' || rec.total_movimentacoes);
    END LOOP;
END;
/

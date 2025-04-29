
-- Segundo Bloco Anônimo: Consulta com JOIN, GROUP BY e ORDER BY
DECLARE
    CURSOR c_movimentacoes IS
        SELECT 
            m.placa AS placa_moto,
            zo.codigo AS zona_origem,
            zd.codigo AS zona_destino,
            mo.data_movimentacao
        FROM mottu_movimentacao mo
        JOIN mottu_moto m ON mo.moto_id = m.moto_id
        JOIN mottu_zona zo ON mo.zona_origem_id = zo.zona_id
        JOIN mottu_zona zd ON mo.zona_destino_id = zd.zona_id
        ORDER BY mo.data_movimentacao DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Placa    | Zona Origem | Zona Destino | Data da Movimentacao');
    DBMS_OUTPUT.PUT_LINE('---------|--------------|--------------|---------------------');
    
    FOR rec IN c_movimentacoes LOOP
        DBMS_OUTPUT.PUT_LINE(
            RPAD(rec.placa_moto, 10) || '| ' ||
            RPAD(rec.zona_origem, 13) || '| ' ||
            RPAD(rec.zona_destino, 13) || '| ' ||
            TO_CHAR(rec.data_movimentacao, 'DD/MM/YYYY HH24:MI:SS')
        );
    END LOOP;
END;

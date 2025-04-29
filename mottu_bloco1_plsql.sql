
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

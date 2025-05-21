set serveroutput on;
set verify off;

-- Criação das tabelas para o projeto Mottu

-- Tabela de zonas
CREATE TABLE mottu_zona (
    zona_id NUMBER PRIMARY KEY,
    codigo VARCHAR2(5) NOT NULL UNIQUE,
    descricao VARCHAR2(50)
);

-- Tabela de status da moto
CREATE TABLE mottu_status_moto (
    status_id NUMBER PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL UNIQUE
);

-- Tabela de operadores
CREATE TABLE mottu_operador (
    operador_id NUMBER PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    cargo VARCHAR2(50)
);

-- Tabela de motos
CREATE TABLE mottu_moto (
    moto_id NUMBER PRIMARY KEY,
    placa VARCHAR2(10) NOT NULL UNIQUE,
    zona_id NUMBER NOT NULL,
    status_id NUMBER NOT NULL,
    observacoes VARCHAR2(255),
    data_criacao DATE DEFAULT SYSDATE,
    data_atualizacao DATE,
    CONSTRAINT fk_moto_zona FOREIGN KEY (zona_id) REFERENCES mottu_zona(zona_id),
    CONSTRAINT fk_moto_status FOREIGN KEY (status_id) REFERENCES mottu_status_moto(status_id)
);

-- Tabela de movimentações
CREATE TABLE mottu_movimentacao (
    movimentacao_id NUMBER PRIMARY KEY,
    moto_id NUMBER NOT NULL,
    operador_id NUMBER NOT NULL,
    zona_origem_id NUMBER NOT NULL,
    zona_destino_id NUMBER NOT NULL,
    data_movimentacao DATE DEFAULT SYSDATE,
    CONSTRAINT fk_mov_moto FOREIGN KEY (moto_id) REFERENCES mottu_moto(moto_id),
    CONSTRAINT fk_mov_operador FOREIGN KEY (operador_id) REFERENCES mottu_operador(operador_id),
    CONSTRAINT fk_mov_zona_origem FOREIGN KEY (zona_origem_id) REFERENCES mottu_zona(zona_id),
    CONSTRAINT fk_mov_zona_destino FOREIGN KEY (zona_destino_id) REFERENCES mottu_zona(zona_id)
);




-- Inserts para mottu_zona
INSERT INTO mottu_zona (zona_id, codigo, descricao) VALUES (1, 'A1', 'Zona A1 perto do portão principal');
INSERT INTO mottu_zona (zona_id, codigo, descricao) VALUES (2, 'A2', 'Zona A2 ao lado da recepção');
INSERT INTO mottu_zona (zona_id, codigo, descricao) VALUES (3, 'B1', 'Zona B1 - corredor central');
INSERT INTO mottu_zona (zona_id, codigo, descricao) VALUES (4, 'B2', 'Zona B2 - fundos do pátio');
INSERT INTO mottu_zona (zona_id, codigo, descricao) VALUES (5, 'C1', 'Zona C1 próxima ao estacionamento');

-- Inserts para mottu_status_moto
INSERT INTO mottu_status_moto (status_id, nome) VALUES (1, 'Ativa');
INSERT INTO mottu_status_moto (status_id, nome) VALUES (2, 'Em Manutenção');
INSERT INTO mottu_status_moto (status_id, nome) VALUES (3, 'Inativa');
INSERT INTO mottu_status_moto (status_id, nome) VALUES (4, 'Reservada');
INSERT INTO mottu_status_moto (status_id, nome) VALUES (5, 'Aguardando Reparos');

-- Inserts para mottu_operador
INSERT INTO mottu_operador (operador_id, nome, email, cargo) VALUES (1, 'João Silva', 'joao.silva@mottu.com', 'Supervisor');
INSERT INTO mottu_operador (operador_id, nome, email, cargo) VALUES (2, 'Maria Oliveira', 'maria.oliveira@mottu.com', 'Técnica de Pátio');
INSERT INTO mottu_operador (operador_id, nome, email, cargo) VALUES (3, 'Carlos Souza', 'carlos.souza@mottu.com', 'Auxiliar');
INSERT INTO mottu_operador (operador_id, nome, email, cargo) VALUES (4, 'Fernanda Lima', 'fernanda.lima@mottu.com', 'Gerente');
INSERT INTO mottu_operador (operador_id, nome, email, cargo) VALUES (5, 'Ricardo Mendes', 'ricardo.mendes@mottu.com', 'Operador de Logística');

-- Inserts para mottu_moto
INSERT INTO mottu_moto (moto_id, placa, zona_id, status_id, observacoes, data_criacao) VALUES (1, 'ABC1D23', 1, 1, 'Moto nova, sem avarias', SYSDATE);
INSERT INTO mottu_moto (moto_id, placa, zona_id, status_id, observacoes, data_criacao) VALUES (2, 'XYZ9F87', 2, 2, 'Moto aguardando troca de óleo', SYSDATE);
INSERT INTO mottu_moto (moto_id, placa, zona_id, status_id, observacoes, data_criacao) VALUES (3, 'JKL3B21', 3, 1, 'Moto pronta para entrega', SYSDATE);
INSERT INTO mottu_moto (moto_id, placa, zona_id, status_id, observacoes, data_criacao) VALUES (4, 'QWE7P65', 4, 5, 'Moto sofreu leve avaria', SYSDATE);
INSERT INTO mottu_moto (moto_id, placa, zona_id, status_id, observacoes, data_criacao) VALUES (5, 'MNB5T43', 5, 3, 'Moto desativada', SYSDATE);

-- Inserts para mottu_movimentacao
INSERT INTO mottu_movimentacao (movimentacao_id, moto_id, operador_id, zona_origem_id, zona_destino_id, data_movimentacao) VALUES (1, 1, 1, 1, 2, SYSDATE);
INSERT INTO mottu_movimentacao (movimentacao_id, moto_id, operador_id, zona_origem_id, zona_destino_id, data_movimentacao) VALUES (2, 2, 2, 2, 3, SYSDATE);
INSERT INTO mottu_movimentacao (movimentacao_id, moto_id, operador_id, zona_origem_id, zona_destino_id, data_movimentacao) VALUES (3, 3, 3, 3, 1, SYSDATE);
INSERT INTO mottu_movimentacao (movimentacao_id, moto_id, operador_id, zona_origem_id, zona_destino_id, data_movimentacao) VALUES (4, 4, 4, 4, 5, SYSDATE);
INSERT INTO mottu_movimentacao (movimentacao_id, moto_id, operador_id, zona_origem_id, zona_destino_id, data_movimentacao) VALUES (5, 5, 5, 5, 2, SYSDATE);


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

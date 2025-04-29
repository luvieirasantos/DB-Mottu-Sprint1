
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

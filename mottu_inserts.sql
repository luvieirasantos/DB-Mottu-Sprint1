
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

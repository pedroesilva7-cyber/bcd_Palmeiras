DROP DATABASE IF EXISTS palmeiras_elenco;
CREATE DATABASE palmeiras_elenco CHARACTER SET utf8mb4;
USE palmeiras_elenco;
 

CREATE TABLE posicoes (
    id_posicao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL
);
 
CREATE TABLE jogadores (
    id_jogador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    idade INT,
    numero_camisa INT,
    nacionalidade VARCHAR(30),
    id_posicao INT NOT NULL,
    FOREIGN KEY (id_posicao) REFERENCES posicoes(id_posicao)
);
 
CREATE TABLE contratos (
    id_contrato INT PRIMARY KEY AUTO_INCREMENT,
    id_jogador INT NOT NULL UNIQUE,
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (id_jogador) REFERENCES jogadores(id_jogador)
);
 
CREATE TABLE competicoes (
    id_competicao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40) NOT NULL,
    ano INT
);
 
CREATE TABLE estatisticas (
    id_estatistica INT PRIMARY KEY AUTO_INCREMENT,
    id_jogador INT NOT NULL,
    id_competicao INT NOT NULL,
    jogos INT,
    gols INT,
    FOREIGN KEY (id_jogador) REFERENCES jogadores(id_jogador),
    FOREIGN KEY (id_competicao) REFERENCES competicoes(id_competicao)
);
 
-- Popular as tabelas
INSERT INTO posicoes (nome) VALUES
('Goleiro'), ('Zagueiro'), ('Lateral'), ('Meio-campo'), ('Atacante');
 
INSERT INTO jogadores (nome, idade, numero_camisa, nacionalidade, id_posicao) VALUES
('Weverton', 38, 21, 'Brasil', 1),
('Marcelo Lomba', 39, 24, 'Brasil', 1),
('Gustavo Gómez', 33, 15, 'Paraguai', 2),
('Murilo', 28, 26, 'Brasil', 2),
('Bruno Fuchs', 27, 4, 'Brasil', 2),
('Piquerez', 28, 22, 'Uruguai', 3),
('Giay', 32, 2, 'Argentina', 3),
('Mayke', 33, 12, 'Brasil', 3),
('Richard Ríos', 26, 27, 'Colômbia', 4),
('Allan', 29, 40, 'Brasil', 4),
('Raphael Veiga', 31, 23, 'Brasil', 4),
('Facundo Torres', 26, 7, 'Uruguai', 4),
('Ramón Sosa', 26, 17, 'Paraguai', 5),
('Vitor Roque', 21, 9, 'Brasil', 5),
('Flaco López', 25, 42, 'Argentina', 5),
('Paulinho', 22, 20, 'Brasil', 5);
 
INSERT INTO contratos (id_jogador, data_inicio, data_fim) VALUES
(1, '2015-01-01', '2026-12-31'),
(3, '2019-01-01', '2027-12-31'),
(4, '2023-01-01', '2027-12-31'),
(6, '2021-01-01', '2026-12-31'),
(9, '2024-01-01', '2028-12-31'),
(12, '2024-01-01', '2028-12-31'),
(14, '2025-01-01', '2030-12-31'),
(15, '2024-01-01', '2029-12-31');
 
INSERT INTO competicoes (nome, ano) VALUES
('Paulistão', 2026), ('Brasileirão', 2026), ('Libertadores', 2026),
('Copa do Brasil', 2026), ('Recopa Sul-Americana', 2026);
 
INSERT INTO estatisticas (id_jogador, id_competicao, jogos, gols) VALUES
(15, 2, 30, 12), (15, 3, 8, 4), (15, 1, 14, 6),
(14, 2, 28, 10), (14, 3, 7, 3),
(16, 2, 25, 8), (16, 1, 12, 5),
(12, 2, 27, 6), (12, 3, 8, 2),
(11, 2, 26, 7), (11, 4, 5, 2),
(3, 2, 29, 3), (3, 3, 8, 1),
(13, 2, 20, 4), (9, 2, 31, 2), (1, 2, 34, 0);
 

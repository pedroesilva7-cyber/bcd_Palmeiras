-- Atividade III - SEDUC DEST2 - 15 consultas (banco: palmeiras_elenco)
USE palmeiras_elenco;

-- 1) Quais sao todos os jogadores do elenco, em ordem alfabetica? (ORDER BY)
SELECT nome FROM jogadores ORDER BY nome;
-- Resposta: 16 jogadores, de Allan ate Weverton.

-- 2) Qual a posicao de cada jogador? (INNER JOIN)
SELECT j.nome, p.nome AS posicao
FROM jogadores j
INNER JOIN posicoes p ON j.id_posicao = p.id_posicao;
-- Resposta: 16 linhas. Ex.: Weverton - Goleiro, Gustavo Gomez - Zagueiro, Vitor Roque - Atacante.

-- 3) Quais jogadores tem mais de 30 anos? (WHERE)
SELECT nome, idade FROM jogadores WHERE idade > 30;
-- Resposta: Weverton (38), Marcelo Lomba (39), Gustavo Gomez (33), Giay (32), Mayke (33), Raphael Veiga (31).

-- 4) Quais jogadores tem o nome comecando com R? (LIKE)
SELECT nome FROM jogadores WHERE nome LIKE 'R%';
-- Resposta: Richard Rios, Raphael Veiga, Ramon Sosa.

-- 5) Quais jogadores tem entre 25 e 28 anos? (BETWEEN)
SELECT nome, idade FROM jogadores WHERE idade BETWEEN 25 AND 28;
-- Resposta: Murilo (28), Bruno Fuchs (27), Piquerez (28), Richard Rios (26),
-- Facundo Torres (26), Ramon Sosa (26), Flaco Lopez (25).

-- 6) Quantos jogadores ha em cada posicao? (GROUP BY + COUNT)
SELECT p.nome AS posicao, COUNT(*) AS quantidade
FROM jogadores j
INNER JOIN posicoes p ON j.id_posicao = p.id_posicao
GROUP BY p.nome;
-- Resposta: Goleiro 2, Zagueiro 3, Lateral 3, Meio-campo 4, Atacante 4.

-- 7) Quantos jogadores existem de cada nacionalidade? (GROUP BY + ORDER BY)
SELECT nacionalidade, COUNT(*) AS quantidade
FROM jogadores
GROUP BY nacionalidade
ORDER BY quantidade DESC;
-- Resposta: Brasil 9, Paraguai 2, Uruguai 2, Argentina 2, Colombia 1.

-- 8) Quantos gols o elenco fez em cada competicao? (SUM + INNER JOIN)
SELECT c.nome AS competicao, SUM(e.gols) AS total_gols
FROM estatisticas e
INNER JOIN competicoes c ON e.id_competicao = c.id_competicao
GROUP BY c.nome
ORDER BY total_gols DESC;
-- Resposta: Brasileirao 52, Paulistao 11, Libertadores 10, Copa do Brasil 2.

-- 9) Quais sao os 3 maiores artilheiros do ano? (SUM + ORDER BY + LIMIT)
SELECT j.nome, SUM(e.gols) AS total_gols
FROM jogadores j
INNER JOIN estatisticas e ON j.id_jogador = e.id_jogador
GROUP BY j.nome
ORDER BY total_gols DESC, j.nome
LIMIT 3;
-- Resposta: Flaco Lopez 22, Paulinho 13, Vitor Roque 13.

-- 10) Qual a idade media do elenco? (AVG)
SELECT AVG(idade) AS idade_media FROM jogadores;
-- Resposta: 29.0 anos.

-- 11) Quem e o jogador mais velho e o mais novo? (MAX e MIN)
SELECT MAX(idade) AS mais_velho, MIN(idade) AS mais_novo FROM jogadores;
-- Resposta: mais velho 39 anos (Marcelo Lomba), mais novo 21 anos (Vitor Roque).

-- 12) Quais jogadores tem contrato terminando em 2026? (INNER JOIN + WHERE)
SELECT j.nome, c.data_fim
FROM jogadores j
INNER JOIN contratos c ON j.id_jogador = c.id_jogador
WHERE c.data_fim <= '2026-12-31';
-- Resposta: Weverton e Piquerez (2026-12-31).

-- 13) Quais sao os 2 contratos mais longos? (INNER JOIN + ORDER BY + LIMIT)
SELECT j.nome, c.data_fim
FROM jogadores j
INNER JOIN contratos c ON j.id_jogador = c.id_jogador
ORDER BY c.data_fim DESC
LIMIT 2;
-- Resposta: Vitor Roque (2030-12-31) e Flaco Lopez (2029-12-31).

-- 14) Quais posicoes tem mais de 3 jogadores? (GROUP BY + HAVING)
SELECT p.nome AS posicao, COUNT(*) AS quantidade
FROM jogadores j
INNER JOIN posicoes p ON j.id_posicao = p.id_posicao
GROUP BY p.nome
HAVING COUNT(*) > 3;
-- Resposta: Meio-campo (4) e Atacante (4).

-- 15) Quais jogadores atuaram em mais de 25 jogos no Brasileirao? (3 tabelas)
SELECT j.nome, e.jogos
FROM jogadores j
INNER JOIN estatisticas e ON j.id_jogador = e.id_jogador
INNER JOIN competicoes c ON e.id_competicao = c.id_competicao
WHERE c.nome = 'Brasileirão' AND e.jogos > 25
ORDER BY e.jogos DESC;
-- Resposta: Weverton 34, Richard Rios 31, Flaco Lopez 30, Gustavo Gomez 29,
-- Vitor Roque 28, Facundo Torres 27, Raphael Veiga 26.

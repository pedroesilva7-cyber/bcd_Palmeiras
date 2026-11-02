1. Domínio do Banco de Dados

Escolhi o elenco atual do Palmeiras. O banco guarda os jogadores, as posições em que jogam, os contratos e as estatísticas (jogos e gols) em cada competição.

2. Contextualização

Imagine que o departamento de futebol do Palmeiras controla o elenco só com planilhas e papéis. Isso causa vários problemas:

O mesmo jogador é digitado várias vezes, então os dados ficam repetidos.
Se alguém muda a idade ou o contrato em uma planilha, as outras ficam desatualizadas.
É difícil responder perguntas como "quem fez mais gols?" ou "quais contratos acabam este ano?".
Qualquer pessoa pode apagar ou alterar dados sem ninguém perceber.
Quando tem muita planilha, a busca fica lenta e aparecem erros.
3. Proposta de melhoria

Minha proposta é usar um SGBD relacional (MySQL), que guarda tudo em tabelas ligadas entre si. Com isso:

Cada informação fica guardada uma vez só.
Com SQL, dá para responder as perguntas em segundos.
As chaves primárias e estrangeiras evitam dados errados.
É possível controlar quem acessa o banco e fazer cópia de segurança (dump).
4. Modelagem lógica

Modelagem do banco

Tabelas, campos e tipos

posicoes

Campo	Tipo	Observação
id_posicao	INT	PK, auto incremento
nome	VARCHAR(30)	não nulo

jogadores

Campo	Tipo	Observação
id_jogador	INT	PK, auto incremento
nome	VARCHAR(50)	não nulo
idade	INT	
numero_camisa	INT	
nacionalidade	VARCHAR(30)	
id_posicao	INT	FK para posicoes

contratos

Campo	Tipo	Observação
id_contrato	INT	PK, auto incremento
id_jogador	INT	FK para jogadores, UNIQUE
data_inicio	DATE	
data_fim	DATE	

competicoes

Campo	Tipo	Observação
id_competicao	INT	PK, auto incremento
nome	VARCHAR(40)	não nulo
ano	INT	

estatisticas

Campo	Tipo	Observação
id_estatistica	INT	PK, auto incremento
id_jogador	INT	FK para jogadores
id_competicao	INT	FK para competicoes
jogos	INT	
gols	INT	
Relacionamentos e cardinalidade
Relação	Tipo	Explicação
posicoes e jogadores	1 para muitos (1:N)	Uma posição tem vários jogadores, mas cada jogador tem só uma posição.
jogadores e contratos	1 para 1 (1:1)	Cada jogador tem um contrato e cada contrato é de um jogador.
jogadores e competicoes	muitos para muitos (N:N)	Um jogador disputa várias competições e cada competição tem vários jogadores. Resolvi isso com a tabela estatisticas, que fica no meio.
5. Formas Normais

1FN: cada campo guarda um valor só e cada linha tem uma chave primária. Eu não coloquei "Brasileirão, Libertadores" na mesma célula. Isso é importante porque, sem isso, não dá para somar gols nem filtrar por competição.

2FN: além de estar na 1FN, nenhum campo pode depender só de uma parte da chave. Na tabela estatisticas, jogos e gols dependem do jogador e da competição juntos. Os dados que são só do jogador (nome, idade) ficaram em jogadores, e os que são só da competição (nome, ano) ficaram em competicoes. Assim o nome do jogador não se repete em cada competição.

3FN: além de estar na 2FN, um campo não pode depender de outro campo que não seja a chave. O nome da posição não fica em jogadores, fica em posicoes, e o jogador guarda só o id_posicao. Se o nome de uma posição mudar, eu altero em um lugar só.

4FN: além de estar na 3FN, não pode ter informações independentes misturadas na mesma tabela. O contrato do jogador e as competições que ele disputa não têm relação entre si. Por isso separei em contratos e estatisticas, em vez de fazer uma tabela gigante com combinações repetidas.

6. Instruções SQL
estrutura_dados.sql: cria o banco palmeiras_elenco, cria as 5 tabelas e popula todas (mínimo de 5 registros em cada).
consultas.sql: 15 consultas contextualizadas, cada uma com a resposta em comentário. Usei INNER JOIN, WHERE, LIKE, GROUP BY, ORDER BY, BETWEEN, SUM, AVG, MAX, MIN, HAVING e LIMIT.

Quantidade de registros: posicoes (5), jogadores (16), contratos (8), competicoes (5) e estatisticas (16).

7. Passo a passo para fazer o dump (estrutura e dados)

Pelo terminal:

Abrir o terminal (ou Prompt de Comando).
Rodar o comando abaixo e digitar a senha quando pedir:
   mysqldump -u root -p palmeiras_elenco > palmeiras_elenco_dump.sql

Isso salva a estrutura e os dados no arquivo. 3. Se quiser só a estrutura (sem dados): mysqldump -u root -p --no-data palmeiras_elenco > estrutura.sql 4. Para restaurar o banco em outro computador: mysql -u root -p < palmeiras_elenco_dump.sql

Pelo MySQL Workbench:

Ir no menu Server e clicar em Data Export.
Marcar o banco palmeiras_elenco.
Escolher Export to Self-Contained File e o local para salvar.
Deixar marcado Dump Structure and Data.
Clicar em Start Export.

O arquivo palmeiras_elenco_dump.sql deste repositório contém a estrutura e os dados do banco.

8. Arquivos do repositório
Arquivo	O que tem
README.md	Este documento, com toda a parte escrita
modelagem.png	Print da modelagem do banco
estrutura_dados.sql	Criação do banco, das tabelas e inserção dos dados
consultas.sql	As 15 consultas com as respostas
palmeiras_elenco_dump.sql	Dump com estrutura e dados





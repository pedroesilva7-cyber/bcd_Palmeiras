1. Domínio

Elenco atual do Palmeiras: jogadores, posições, contratos e estatísticas nas competições.

2. Contextualização

O departamento de futebol do Palmeiras controla o elenco em planilhas e papéis soltos. Os problemas:

O mesmo jogador é digitado várias vezes e os dados ficam repetidos.
Se alguém muda a idade ou o contrato em uma planilha, as outras ficam desatualizadas.
É difícil responder perguntas como "quem fez mais gols?" ou "quais contratos acabam este ano?".
Qualquer pessoa pode apagar ou alterar dados sem controle.
Com muitas planilhas, a busca fica lenta e dá erro.
3. Proposta de melhoria

Usar um SGBD relacional (MySQL) para guardar tudo em tabelas ligadas entre si:

Cada informação é guardada uma vez só.
As consultas em SQL respondem perguntas em segundos.
Chaves primárias e estrangeiras evitam dados errados.
Dá para controlar o acesso e fazer cópias de segurança (dump).
4. Modelagem lógica

Print do diagrama: modelagem.png

Modelagem

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
posicoes e jogadores	1 para muitos (1:N)	Uma posição tem vários jogadores, mas cada jogador tem uma posição.
jogadores e contratos	1 para 1 (1:1)	Cada jogador tem um contrato atual.
jogadores e competicoes	muitos para muitos (N:N)	Um jogador disputa várias competições e cada competição tem vários jogadores. A tabela estatisticas resolve isso.
5. Formas Normais

1FN: cada campo guarda um valor só e cada linha tem chave primária. Não colocamos "Brasileirão, Libertadores" em uma célula. Sem isso, não dá para somar gols nem filtrar por competição.

2FN: estar na 1FN e não ter dependência parcial da chave. Em estatisticas, jogos e gols dependem do jogador e da competição juntos. Dados só do jogador ficam em jogadores e dados só da competição ficam em competicoes. Assim o nome do jogador não se repete em cada competição.

3FN: estar na 2FN e não ter dependência transitiva. O nome da posição não fica em jogadores, fica em posicoes, e o jogador guarda só o id_posicao. Se o nome de uma posição mudar, a alteração é feita em um lugar só.

4FN: estar na 3FN e não ter dependências multivaloradas. Um jogador tem contrato e várias competições, que são informações independentes. Por isso separamos em contratos e estatisticas, em vez de misturar tudo em uma tabela gigante. Isso evita combinações repetidas e inúteis.

6. Scripts SQL
estrutura_dados.sql: cria o banco, as tabelas e popula os dados (mínimo de 5 registros em cada tabela).
consultas.sql: 15 consultas contextualizadas, com as respostas em comentário (INNER JOIN, WHERE, LIKE, GROUP BY, ORDER BY, BETWEEN, SUM, AVG, MAX, MIN, HAVING, LIMIT).
7. Passo a passo do dump (estrutura e dados)

Pelo terminal:

Abra o terminal (ou Prompt de Comando).
Rode o comando e digite a senha quando pedir:
   mysqldump -u root -p palmeiras_elenco > palmeiras_elenco_dump.sql
Só a estrutura, sem dados: mysqldump -u root -p --no-data palmeiras_elenco > estrutura.sql
Para restaurar em outro computador: mysql -u root -p < palmeiras_elenco_dump.sql

Pelo MySQL Workbench:

Menu Server, depois Data Export.
Marque o banco palmeiras_elenco.
Escolha "Export to Self-Contained File" e o local do arquivo.
Deixe marcado "Dump Structure and Data".
Clique em Start Export.

O arquivo palmeiras_elenco_dump.sql deste repositório é o resultado desse processo.

Observação

Os nomes dos jogadores são do elenco de 2026. Idades, números de camisa, gols, jogos e datas de contrato são dados de exemplo para fins de estudo.

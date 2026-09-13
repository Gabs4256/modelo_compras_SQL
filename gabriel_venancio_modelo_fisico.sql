-- ETAPA 1 CRIACAO DO BANCO DE DADOS
CREATE DATABASE loja_pedidos;

-- ETAPA 2: CONVERSAO DO MER PARA O MODELO RELACIONAL
-- CAMPOS NOT NULL PARA SER OBRIGATORIO, SERIAL NO CODIGO PARA GERAR DIRETO, TELEFONE COMO STRING PARA ACEITAR FORMATOS COM () -.
CREATE TABLE cliente(
	codigo SERIAL primary key,
	nome varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	telefone varchar(15) NOT NULL
);
ALTER TABLE cliente ALTER COLUMN telefone DROP NOT NULL;

-- campos not null, default 0 para o desconto nao entrar como null, validações para o desconto nem o valor total serem negativos
-- referencição com a tabela clientes pela chave estrangeira
CREATE TABLE pedido(
	codigo SERIAL PRIMARY KEY,
	dt_entrada DATE NOT NULL,
	
	valor_total DECIMAL (15,2) NOT NULL,
	CONSTRAINT chk_valor_total_nao_negativo CHECK (valor_total >= 0),
	
	dt_embarque DATE,
	
	desconto INTEGER DEFAULT 0,
	CONSTRAINT chk_desconto_nao_negativo CHECK (desconto >= 0),
	
	tipo varchar(50),
	cliente_fk INTEGER NOT NULL,



	FOREIGN KEY (cliente_fk)
		REFERENCES cliente(codigo)
);
ALTER TABLE pedido RENAME COLUMN codigo TO codigo_pedido;
ALTER TABLE pedido ALTER COLUMN desconto TYPE DECIMAL(3,2);

-- CRIACAO DA TABELA PRODUTO COM VALIDAÇÃO NO PRECO, NOT NULL EM CAMPOS OBRIGATORIOS E UMA CHAVE PRIMARIA

CREATE TABLE produto(
	codigo_produto SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	unidade_medida VARCHAR(50) NOT NULL,

	preco decimal(15,2) NOT NULL,
	CONSTRAINT chk_preco_nao_negativo CHECK (preco >= 0)
	
);

-- CRIACAO DA TABELA ASSOCIATIVA, CARREGA AS FOREIGN KEY, CRIA COMO CHAVE PRIMARIA COMPOSTA, VALIDA OS PREÇOS PARA NAO SEREM NEGATIVOS

CREATE TABLE item_pedido(
	pedido_fk INTEGER NOT NULL,
	produto_fk INTEGER NOT NULL,
	
	quantidade INTEGER NOT NULL,
	CONSTRAINT quantidade_nao_defenida CHECK (quantidade >= 0),
	
	subtotal decimal(15,2) NOT NULL,
	CONSTRAINT subtotal_nao_negativo CHECK (subtotal >= 0),

	PRIMARY KEY (pedido_fk, produto_fk),

	FOREIGN KEY (pedido_fk) REFERENCES pedido(codigo_pedido),
	FOREIGN KEY (produto_fk) REFERENCES produto(codigo_produto)
);

-- ETAPA 3 CADASTRO DOS DADOS

-- CADASTRANDO 5 CLIENTES

INSERT INTO cliente(nome, email, telefone)
VALUES('GABRIEL', 'teste01@gmail.com', '(11)98135-4958'),
('ANTHONY', 'antdeleon@outlook.com', '(11)98541-3807'),
('DANILA', 'danilateste07@gmail.com', '(11)97584-8598')

INSERT INTO cliente(nome,email)
VALUES('ISABELLE', 'isateste02@gmail.com'),
('CAROLINE', 'carolteste03@gmail.com')

SELECT * FROM cliente;

-- CADASTRANDO PRODUTOS 8
--Produtos com diferentes preços;
--Diferentes unidades de medida, como UN, KG, L e CX;

INSERT INTO produto(nome, unidade_medida, preco)
VALUES
('computador', 'UN', '4500'),
('mouse', 'UN', '129.56'),
('talheres', 'CX', '1200'),
('pratos', 'CX', '99.99'),
('carne', 'KG', '32.20'),
('arroz', 'KG', '29.99'),
('leite', 'L', '8.99'),
('suco laranja', 'L', '12.28')

TRUNCATE TABLE produto CASCADE;
SELECT * FROM produto;

-- CADASTANDO 6 pedidos COM E SEM DESCONTOS
INSERT INTO pedido(dt_entrada, valor_total, dt_embarque, desconto, tipo, cliente_fk)
VALUES
('2026-11-25', '4629.56', '2026-11-30', 0.1, 'PIX', '2'),
('2026-08-05', '42.27', '2026-08-10', NULL, 'CREDITO', '1'),
('2026-08-15', '62.19', '2026-08-22', 0.2, 'DEBITO', '5'),
('2026-09-08', '132.19', '2026-09-11', NULL, 'PIX', '3'),
('2026-10-13', '108.98', '2026-10-22', 0.15, 'PARCELADO', '1'),
('2026-06-03', '141.84', '2026-06-06', 0.1, 'PIX', '4')

UPDATE pedido
SET dt_embarque = NULL
WHERE codigo_pedido = 13;

SELECT * FROM pedido;
TRUNCATE TABLE pedido CASCADE;

-- CADASTRANDO 12 itens de pedidos
SELECT * FROM pedido;
SELECT * FROM produto;

INSERT INTO item_pedido(pedido_fk, produto_fk, quantidade, subtotal)
VALUES
(13, 9, 1, 4500.00),
(13, 10, 1, 129.56),
(14,16,1,12.28),
(14,14,1,29.99),
(15,14,1,29.99),
(15,13,1,32.20),
(16,12,1,99.99),
(16,13,1,32.20),
(17,15,1,8.99),
(17,12,1,99.99),
(18,16,1,12.28),
(18,10,1,129.56)

SELECT * FROM item_pedido;

-- ETAPA 4 CONSULTAS (CONSULTAR APENAS UMA TABELA)
-- 1 LISTE TODOS OS CLIENTES
SELECT * FROM cliente;

-- 2 Mostre o nome e o telefone dos clientes.
SELECT nome, telefone FROM cliente;

-- 3 Liste os clientes em ordem alfabética
SELECT * FROM cliente
order by nome;

-- 4 Localize os clientes cujo nome começa com A.
SELECT * FROM cliente
WHERE nome LIKE 'A%';

-- 5 Localize os clientes cujo nome contém Silva.
SELECT * FROM cliente
WHERE nome LIKE 'SILVA';

-- 6 Mostre os clientes sem telefone cadastrado
SELECT * FROM cliente
WHERE telefone IS NULL ;

-- 7 Liste todos os produtos.
SELECT * FROM produto;

-- 8 Mostre o nome e o preço dos produtos.
SELECT nome, preco FROM produto;

-- 9 Liste os produtos em ordem crescente de preço.
SELECT * FROM produto
ORDER BY preco;

-- 10 Mostre os produtos com preço superior a R$ 50,00.
SELECT * FROM produto
WHERE preco > 50.00;

-- 11 Mostre os produtos com preço entre R$ 10,00 e R$ 100,00.
SELECT * FROM produto
WHERE preco > 10.00 AND preco < 100.00;

-- 12 Mostre os produtos cuja unidade de medida é UN
SELECT * FROM produto
WHERE unidade_medida = 'UN';

-- 13 Mostre os produtos cuja unidade de medida é KG ou L
SELECT * FROM produto
WHERE unidade_medida IN ('KG', 'L');

-- 14 Liste todos os pedidos
SELECT * FROM pedido;

-- 15 Mostre os pedidos com desconto maior que zero.
SELECT * FROM pedido
WHERE desconto > 0;

-- 16 Mostre os pedidos que ainda não foram embarcados.
SELECT * FROM pedido
WHERE dt_embarque IS NULL;

-- 17 Mostre os pedidos que já foram embarcados
SELECT * FROM pedido
WHERE dt_embarque IS NOT NULL;

-- 18 Mostre os pedidos realizados em uma data específica.
SELECT * FROM pedido
WHERE dt_entrada = '2026-08-05';

-- 19 Mostre os pedidos realizados entre duas datas.
SELECT * FROM pedido
WHERE dt_entrada BETWEEN '2026-08-01' AND '2026-10-30';

-- 20 Liste os pedidos em ordem decrescente de valor total.
SELECT * FROM pedido
ORDER BY valor_total DESC;

-- 21 Mostre os pedidos com valor total superior a R$ 500,00.
SELECT * FROM pedido
WHERE valor_total > 500.00

-- 22 Mostre os itens cuja quantidade seja maior que três
SELECT * FROM item_pedido
WHERE quantidade > 3;

-- 23 Mostre os itens com subtotal superior a R$ 100,00.
SELECT * FROM item_pedido
WHERE subtotal > 100.00;

-- 24 Conte quantos clientes estão cadastrados.
SELECT COUNT(nome) FROM CLIENTE;


-- 25 Conte quantos produtos estão cadastrados.
SELECT COUNT(nome) FROM produto;

-- 26 Mostre o maior preço dos produtos.
SELECT MAX(preco) FROM produto;

-- 27 Mostre o menor preço dos produtos
SELECT MIN(preco) FROM produto;

-- 28 Calcule a média dos preços.
SELECT AVG(preco) FROM produto;

-- 29 Calcule a soma dos valores dos pedidos.
SELECT * FROM pedido;
SELECT SUM(valor_total) FROM pedido;

-- 30 Conte quantos pedidos ainda não foram embarcados.
SELECT COUNT(codigo_pedido) FROM pedido
WHERE dt_embarque IS NOT NULL;

-- Etapa 5 — Alteração e exclusão de dados Utilizando UPDATE:
-- 1 Altere o telefone de um cliente.
UPDATE cliente
SET telefone = '(11)xxxxx-xxxx'
WHERE codigo = 1;
SELECT * FROM cliente;

-- 2 Aumente o preço de um produto em 10%
UPDATE produto
SET preco = preco + (preco * 0.1)
WHERE codigo_produto = 15;
SELECT * FROM produto;

-- 3 Registre a data de embarque de um pedido
UPDATE pedido
SET dt_embarque = '2026-11-30'
WHERE codigo_pedido = 13;
SELECT * FROM pedido;

-- 4 Altere o desconto de um pedido.
UPDATE pedido
SET desconto = 0.3
WHERE codigo_pedido = 16;
SELECT * FROM pedido

-- ETAPA 5.1 USANDO DELETE
-- 1 Cadastre um produto de teste que não esteja relacionado a nenhum pedido.
-- 2 Consulte o produto para confirmar seu cadastro.
--3. Exclua o produto utilizando sua chave primária.
-- 4. Consulte novamente para confirmar a exclusão.


INSERT INTO produto(nome, unidade_medida, preco)
VALUES('PRODUTO_TESTE', 'KG', 65.5);

SELECT * FROM produto;

DELETE FROM produto
WHERE codigo_produto = 17;

SELECT * FROM produto;
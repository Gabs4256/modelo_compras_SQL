# Modelo Físico de Banco de Dados — Loja de Pedidos

## 📌 Sobre o projeto

Este repositório contém uma atividade prática desenvolvida para a disciplina de **Modelagem de Dados** da faculdade, com o objetivo de aprofundar o conhecimento sobre:

- Conversão de um **Modelo Entidade-Relacionamento (MER)** para o **Modelo Físico** (modelo relacional);
- Criação de tabelas com **PostgreSQL**, utilizando `CREATE TABLE`;
- Definição de **chaves primárias**, **chaves estrangeiras** e **restrições de integridade** (`NOT NULL`, `CHECK`, `UNIQUE`);
- Relacionamentos entre tabelas (1:1, 1:N e N:N, incluindo entidades associativas);
- Escrita de **consultas SQL** (`SELECT`, `WHERE`, `ORDER BY`, funções de agregação como `MAX`, `MIN`, `AVG`, `SUM`, `COUNT`);
- Manipulação de dados com `INSERT`, `UPDATE` e `DELETE`.

## 🗂️ Contexto do sistema

O banco de dados `loja_pedidos` representa o controle de **clientes**, **pedidos** e **produtos** de uma loja, contemplando:

- **Cliente**: pode realizar vários pedidos;
- **Produto**: pode estar presente em vários pedidos, com quantidade e subtotal variáveis;
- **Pedido**: pertence a um único cliente e pode conter vários produtos;
- **Item de Pedido**: entidade associativa que resolve o relacionamento N:N entre `Pedido` e `Produto`.

## 🏗️ Estrutura das tabelas

| Tabela | Descrição |
|---|---|
| `cliente` | Dados dos clientes (nome, email, telefone) |
| `produto` | Catálogo de produtos (nome, preço, unidade de medida) |
| `pedido` | Pedidos realizados, vinculados a um cliente |
| `item_pedido` | Tabela associativa entre `pedido` e `produto`, com quantidade e subtotal |

## ⚙️ O que o script `.sql` contempla

1. Criação do banco de dados;
2. Criação das tabelas com chaves primárias e estrangeiras;
3. Cadastro de dados de teste (clientes, produtos, pedidos e itens);
4. Consultas simples explorando filtros, ordenações e funções de agregação;
5. Operações de atualização (`UPDATE`) e exclusão (`DELETE`) de registros.

## 🗺️ Modelo Entidade-Relacionamento (MER)

O diagrama abaixo representa o MER que serviu de base para a construção do modelo físico:

![MER do sistema de clientes, pedidos e produtos](./mer.png)

**Principais pontos do modelo:**

- O relacionamento **efetuar/efetuado** entre `Cliente` e `Pedido` tem cardinalidade **(1,1)** do lado de `Cliente` e **(0,N)** do lado de `Pedido` — ou seja, um cliente pode ter vários pedidos, mas cada pedido pertence a exatamente um cliente.
- O relacionamento entre `Pedido` e `Produto` é do tipo **N:N**, resolvido pela entidade associativa **ItemPedido (Conter/Contido)**, que carrega os atributos `id_pedidofk`, `id_produtofk`, `Quantidade` e `SubTotal`.
- O lado de `Produto` nesse relacionamento tem cardinalidade **(1,N)**.

## 🎓 Finalidade

Projeto **exclusivamente acadêmico**, desenvolvido como exercício de fixação sobre modelagem de dados e SQL, sem finalidade comercial.

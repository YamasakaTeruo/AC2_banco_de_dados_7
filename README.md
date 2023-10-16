# Atividade individual - Tema: Base de Dados Empresa (VIEW)
## Descrição:
Atividade com foco na ultilização do comando VIEW

## Atividade:
Reproduza a base de dados apresentada no slide 21 desta tarefa  execute os seguintes itens:


Crie uma view que mostra todos os produtos e suas respectivas marcas;
```
CREATE VIEW produto_marca AS
    SELECT 
        produtos.prd_nome AS produto, marcas.mrc_nome AS marca
    FROM
        produtos
            JOIN
        marcas ON produtos.id_prd_marca = marcas.mrc_id;
```
![image](https://github.com/YamasakaTeruo/AC2_banco_de_dados_6/assets/144747935/12861429-26bf-42e8-b573-8f5f684a11c2)


Crie uma view que mostra todos os produtos e seus respectivos fornecedores;
```
CREATE VIEW produto_fornecedor_view AS
    SELECT 
        produtos.prd_nome AS produto,
        fornecedores.frn_nome AS fornecedor
    FROM
        produtos
            JOIN
        produto_fornecedor ON produtos.id_prd = produto_fornecedor.pf_prod_id
            JOIN
        fornecedores ON produto_fornecedor.pf_forn_id = fornecedores.frn_id;
```

![image](https://github.com/YamasakaTeruo/AC2_banco_de_dados_6/assets/144747935/c9702ad5-419f-4215-8246-50a2aead1468)

Crie uma view que mostra todos os produtos e seus respectivos fornecedores e marcas;
```
CREATE VIEW produto_fornecedor_marca AS
    SELECT 
        produtos.prd_nome AS produto,
        fornecedores.frn_nome AS fornecedor,
        marcas.mrc_nome AS marcas
    FROM
        produtos
            JOIN
        produto_fornecedor ON produtos.id_prd = produto_fornecedor.pf_prod_id
            JOIN
        fornecedores ON produto_fornecedor.pf_forn_id = fornecedores.frn_id
            JOIN
        marcas ON produtos.id_prd_marca = marcas.mrc_id;
```
![image](https://github.com/YamasakaTeruo/AC2_banco_de_dados_6/assets/144747935/07f862ed-6842-4b1b-9f35-7266a27b3f71)


Crie uma view que mostra todos os produtos com estoque abaixo do mínimo;
```
CREATE view ProdutosEstoqueBaixo as
SELECT prd_nome, prd_qnt_estoque, prd_estoque_min from produtos WHERE (prd_qnt_estoque < prd_estoque_min);
```
![image](https://github.com/YamasakaTeruo/AC2_banco_de_dados_6/assets/144747935/0465535b-d261-4ca4-83d2-46969a00769c)


Adicione o campo data de validade. Insira novos produtos com essa informação;
```
ALTER TABLE produtos
 add COLUMN prd_data_validade DATE;

INSERT into produtos (prd_nome, prd_qnt_estoque, prd_estoque_min, 
prd_perecivel, prd_valor, prd_data_validade, id_prd_marca) values

('Creme de Leite', 30, 5, 1, 2.99,'2022-10-31',1),
('Pão de Milho', 50, 10, 1, 3.49,'2023-11-15',2),
('Frutas Variadas', 40, 15, 1, 15.99,'2022-11-10',3),
('Iogurte de chocolate', 40, 10, 1, 5.99,'2023-11-05',1),
('Queijo Cheddar', 25, 5, 1, 25.49,'2022-11-20',2),
('Salada Pronta', 30, 5, 1, 4.99,'2023-10-28',3),
('Salmão Fresco', 15, 3, 1, 45.99,'2022-11-12',1);

INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES
    (16,1),
    (17,2),
    (18,3),
    (19,1),
    (20,2),
    (21,3),
    (22,1);

```


Crie uma view que mostra todos os produtos e suas respectivas marcas com validade vencida;
```
CREATE view produtos_vencidos as
SELECT
    produtos.prd_nome AS produto,
    produtos.prd_data_validade AS data_validade
FROM
    produtos
WHERE
    produtos.prd_perecivel = 1
    AND produtos.prd_data_validade IS NOT NULL
    AND produtos.prd_data_validade < CURDATE();
```
![image](https://github.com/YamasakaTeruo/AC2_banco_de_dados_6/assets/144747935/7e1a3c35-6673-48fa-8455-a2c356953379)


Selecionar os produtos com preço acima da média.
```
SELECT prd_nome, prd_valor, (SELECT AVG(prd_valor) FROM produtos) as media_geral
FROM produtos
WHERE prd_valor > (SELECT AVG(prd_valor) FROM produtos);
```
![image](https://github.com/YamasakaTeruo/AC2_banco_de_dados_6/assets/144747935/c1b560e3-bbfa-4434-a310-dd0cded510c0)

CREATE table marcas(
mrc_id int(11) PRIMARY KEY AUTO_INCREMENT,
mrc_nome VARCHAR(50) not null,
mrc_nacionalidade VARCHAR(50)
);


CREATE TABLE produtos (
    id_prd INT PRIMARY KEY AUTO_INCREMENT,
    prd_nome VARCHAR(50) NOT NULL, 
    prd_qnt_estoque INT(11) NOT NULL DEFAULT 0, 
    prd_estoque_min INT(11) NOT NULL DEFAULT 0,
    prd_data_fabri TIMESTAMP DEFAULT NOW(),
    prd_perecivel TINYINT(1),
    prd_valor DECIMAL(10,2),
    id_prd_marca INT(11),
    CONSTRAINT fk_marcas FOREIGN KEY (id_prd_marca) REFERENCES marcas (mrc_id)
);

create table fornecedores(
frn_id int PRIMARY KEY AUTO_INCREMENT,
frn_nome VARCHAR(50) not null,
frn_email varchar(50)
);

CREATE TABLE produto_fornecedor (
    pf_prod_id INT(11),
    pf_forn_id INT(11),
    FOREIGN KEY (pf_prod_id) REFERENCES produtos (id_prd),
    FOREIGN KEY (pf_forn_id) REFERENCES fornecedores (frn_id)
);


INSERT INTO marcas (mrc_nome, mrc_nacionalidade) VALUES
    ('BRALIMENTOS', 'Brasil'),
    ('LA_COCINA', 'Argentina'),
    ('TABE NIHON', 'Japão');


INSERT INTO fornecedores (frn_nome, frn_email) VALUES
    ('Fornecedor BR', 'form_br@form.com'),
    ('Fornecedor AR ', 'form_ag@form.com'),
    ('Fornecedor JP', 'form_jp@form.com');


INSERT INTO produtos (prd_nome, prd_qnt_estoque, prd_estoque_min, prd_perecivel, prd_valor, id_prd_marca) VALUES
    ('Maçãs', 5, 10, 1, 2.99, 1),
    ('Pão Integral', 100, 20, 1, 15.49, 2),
    ('Leite Fresco', 3, 5, 1, 6.99, 3),
    ('Arroz', 13, 15, 0, 4.99, 1),
    ('Frango Congelado', 3, 10, 1, 12.99, 2),
    ('Macarrão', 60, 10, 0, 3.49, 3),
    ('Iogurte de Morango', 25, 5, 1, 3.99, 1),
    ('Cenouras', 9, 10, 1, 3.49, 2),
    ('Alface', 20, 5, 1, 2.49, 3),
    ('Tomates', 7, 8, 1, 3.99, 1),
    ('Peixe Fresco', 15, 3, 1, 9.99, 2),
    ('Sal', 8, 10, 0, 5.99, 3),
    ('Açucar', 50, 10, 0, 1.99, 1),
    ('Queijo Parmesão', 12, 5, 1, 8.99, 2),
    ('Bananas', 9, 10, 1, 2.29, 3);


-- Inserir dados na tabela 'produto_fornecedor'
INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 1),
    (5, 2),
    (6, 3),
    (7, 1),
    (8, 2),
    (9, 3),
    (10, 1),
    (11, 2),
    (12, 3),
    (13, 1),
    (14, 2),
    (15, 3);
  
    
    
CREATE VIEW produto_marca AS
    SELECT 
        produtos.prd_nome AS produto, marcas.mrc_nome AS marca
    FROM
        produtos
            JOIN
        marcas ON produtos.id_prd_marca = marcas.mrc_id;
        

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

CREATE view ProdutosEstoqueBaixo as
SELECT prd_nome, prd_qnt_estoque, prd_estoque_min from produtos WHERE (prd_qnt_estoque < prd_estoque_min);


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
    
 
SELECT prd_nome, prd_valor, (SELECT AVG(prd_valor) FROM produtos) as media_geral
FROM produtos
WHERE prd_valor > (SELECT AVG(prd_valor) FROM produtos);

SELECT prd_nome, prd_valor, (SELECT AVG(prd_valor) FROM produtos) as media_geral FROM produtos WHERE prd_valor > (SELECT AVG(prd_valor) FROM produtos) LIMIT 0, 50000

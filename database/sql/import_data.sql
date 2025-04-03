-- =============================================
-- Script: importar_dados.sql
-- Tarefa: 3.4 - Importar dados dos CSVs
-- Banco: PostgreSQL >= 10.0
-- =============================================

-- Tabela temporária para importar os dados brutos das demonstrações contábeis
DROP TABLE IF EXISTS temp_demonstracoes;
CREATE TABLE temp_demonstracoes (
    DATA DATE,
    REG_ANS INT,
    CD_CONTA_CONTABIL VARCHAR(50),
    DESCRICAO VARCHAR(255),
    VL_SALDO_INICIAL TEXT,  -- Usamos TEXT para aceitar vírgulas
    VL_SALDO_FINAL TEXT     -- Usamos TEXT para aceitar vírgulas
);

-- Importação da tabela de operadoras (não afetada pelo erro de formato numérico)
COPY operadoras (
    Registro_ANS, CNPJ, Razao_Social, Nome_Fantasia, Modalidade, Logradouro, Numero, Complemento, Bairro, Cidade, UF, CEP, DDD, Telefone, Fax, Endereco_eletronico, Representante, Cargo_Representante, Regiao_de_Comercializacao, Data_Registro_ANS
)
FROM '/dados_ans/dados_cadastrais/Relatorio_cadop.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';',
    ENCODING 'UTF8'
);
SELECT 'Dados de operadoras importados.' AS mensagem;

-- Importação das demonstrações contábeis (1T2023)
COPY temp_demonstracoes (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
FROM '/dados_ans/csv_demonstracoes/1T2023.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';',
    ENCODING 'UTF8'
);
INSERT INTO demonstracoes_contabeis (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
SELECT 
    DATA,
    REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    REPLACE(VL_SALDO_INICIAL, ',', '.')::NUMERIC AS VL_SALDO_INICIAL,
    REPLACE(VL_SALDO_FINAL, ',', '.')::NUMERIC AS VL_SALDO_FINAL
FROM temp_demonstracoes;
SELECT 'Importado 1T2023.csv' AS mensagem;
TRUNCATE temp_demonstracoes;

-- Importação das demonstrações contábeis (2T2023)
COPY temp_demonstracoes (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
FROM '/dados_ans/csv_demonstracoes/2T2023.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';',
    ENCODING 'UTF8'
);
INSERT INTO demonstracoes_contabeis (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
SELECT 
    DATA,
    REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    REPLACE(VL_SALDO_INICIAL, ',', '.')::NUMERIC AS VL_SALDO_INICIAL,
    REPLACE(VL_SALDO_FINAL, ',', '.')::NUMERIC AS VL_SALDO_FINAL
FROM temp_demonstracoes;
SELECT 'Importado 2T2023.csv' AS mensagem;
TRUNCATE temp_demonstracoes;

-- Importação das demonstrações contábeis (3T2023)
COPY temp_demonstracoes (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
FROM '/dados_ans/csv_demonstracoes/3T2023.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';',
    ENCODING 'UTF8'
);
INSERT INTO demonstracoes_contabeis (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
SELECT 
    DATA,
    REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    REPLACE(VL_SALDO_INICIAL, ',', '.')::NUMERIC AS VL_SALDO_INICIAL,
    REPLACE(VL_SALDO_FINAL, ',', '.')::NUMERIC AS VL_SALDO_FINAL
FROM temp_demonstracoes;
SELECT 'Importado 3T2023.csv' AS mensagem;
TRUNCATE temp_demonstracoes;

-- Importação das demonstrações contábeis (4T2023)
COPY temp_demonstracoes (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
FROM '/dados_ans/csv_demonstracoes/4T2023.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';',
    ENCODING 'UTF8'
);
INSERT INTO demonstracoes_contabeis (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
SELECT 
    DATA,
    REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    REPLACE(VL_SALDO_INICIAL, ',', '.')::NUMERIC AS VL_SALDO_INICIAL,
    REPLACE(VL_SALDO_FINAL, ',', '.')::NUMERIC AS VL_SALDO_FINAL
FROM temp_demonstracoes;
SELECT 'Importado 4T2023.csv' AS mensagem;
TRUNCATE temp_demonstracoes;

-- Importação das demonstrações contábeis (1T2024)
COPY temp_demonstracoes (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
FROM '/dados_ans/csv_demonstracoes/1T2024.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';',
    ENCODING 'UTF8'
);
INSERT INTO demonstracoes_contabeis (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
SELECT 
    DATA,
    REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    REPLACE(VL_SALDO_INICIAL, ',', '.')::NUMERIC AS VL_SALDO_INICIAL,
    REPLACE(VL_SALDO_FINAL, ',', '.')::NUMERIC AS VL_SALDO_FINAL
FROM temp_demonstracoes;
SELECT 'Importado 1T2024.csv' AS mensagem;
TRUNCATE temp_demonstracoes;

-- Importação das demonstrações contábeis (2T2024)
COPY temp_demonstracoes (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
FROM '/dados_ans/csv_demonstracoes/2T2024.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';',
    ENCODING 'UTF8'
);
INSERT INTO demonstracoes_contabeis (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
SELECT 
    DATA,
    REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    REPLACE(VL_SALDO_INICIAL, ',', '.')::NUMERIC AS VL_SALDO_INICIAL,
    REPLACE(VL_SALDO_FINAL, ',', '.')::NUMERIC AS VL_SALDO_FINAL
FROM temp_demonstracoes;
SELECT 'Importado 2T2024.csv' AS mensagem;
TRUNCATE temp_demonstracoes;

-- Importação das demonstrações contábeis (3T2024)
COPY temp_demonstracoes (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
FROM '/dados_ans/csv_demonstracoes/3T2024.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';',
    ENCODING 'UTF8'
);
INSERT INTO demonstracoes_contabeis (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
SELECT 
    DATA,
    REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    REPLACE(VL_SALDO_INICIAL, ',', '.')::NUMERIC AS VL_SALDO_INICIAL,
    REPLACE(VL_SALDO_FINAL, ',', '.')::NUMERIC AS VL_SALDO_FINAL
FROM temp_demonstracoes;
SELECT 'Importado 3T2024.csv' AS mensagem;
TRUNCATE temp_demonstracoes;

-- Importação das demonstrações contábeis (4T2024)
COPY temp_demonstracoes (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
FROM '/dados_ans/csv_demonstracoes/4T2024.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ';',
    ENCODING 'UTF8'
);
INSERT INTO demonstracoes_contabeis (
    DATA, REG_ANS, CD_CONTA_CONTABIL, DESCRICAO, VL_SALDO_INICIAL, VL_SALDO_FINAL
)
SELECT 
    DATA,
    REG_ANS,
    CD_CONTA_CONTABIL,
    DESCRICAO,
    REPLACE(VL_SALDO_INICIAL, ',', '.')::NUMERIC AS VL_SALDO_INICIAL,
    REPLACE(VL_SALDO_FINAL, ',', '.')::NUMERIC AS VL_SALDO_FINAL
FROM temp_demonstracoes;
SELECT 'Importado 4T2024.csv' AS mensagem;
TRUNCATE temp_demonstracoes;

-- Preenche as colunas ANO e TRIMESTRE
ALTER TABLE demonstracoes_contabeis
    ADD COLUMN IF NOT EXISTS ANO INT,
    ADD COLUMN IF NOT EXISTS TRIMESTRE INT;

UPDATE demonstracoes_contabeis
SET ANO = EXTRACT(YEAR FROM DATA),
    TRIMESTRE = EXTRACT(QUARTER FROM DATA)
WHERE ANO IS NULL OR TRIMESTRE IS NULL;

SELECT 'Dados das demonstrações contábeis importados e colunas ANO/TRIMESTRE atualizadas.' AS mensagem;

-- Remove a tabela temporária no final
DROP TABLE temp_demonstracoes;
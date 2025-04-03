-- =============================================
-- Script: criar_tabelas.sql
-- Tarefa: 3.3 - Criar estruturas das tabelas
-- Banco: PostgreSQL >= 10.0
-- =============================================

-- Remove tabelas existentes para evitar erros (cuidado em ambiente de produção!)
DROP TABLE IF EXISTS demonstracoes_contabeis;
DROP TABLE IF EXISTS operadoras;

-- Tabela para armazenar os dados cadastrais das operadoras
-- >>> VERIFIQUE E AJUSTE AS COLUNAS ABAIXO CONFORME O SEU CSV 'Relatorio_cadop.csv' <<<
CREATE TABLE operadoras (
    Registro_ANS INT PRIMARY KEY, -- Chave primária, identificador único da operadora
    CNPJ VARCHAR(20),
    Razao_Social VARCHAR(255),
    Nome_Fantasia VARCHAR(255),
    Modalidade VARCHAR(100),
    Logradouro VARCHAR(255),
    Numero VARCHAR(50),
    Complemento VARCHAR(100),
    Bairro VARCHAR(100),
    Cidade VARCHAR(100),
    UF VARCHAR(2),
    CEP VARCHAR(10),
    DDD VARCHAR(3),
    Telefone VARCHAR(20),
    Fax VARCHAR(20),
    Endereco_eletronico VARCHAR(255),
    Representante VARCHAR(255),
    Cargo_Representante VARCHAR(100),
    Regiao_de_Comercializacao VARCHAR(100),
    Data_Registro_ANS DATE
);

-- Tabela para armazenar os dados das demonstrações contábeis
-- >>> VERIFIQUE E AJUSTE AS COLUNAS ABAIXO CONFORME OS SEUS CSVs TRIMESTRAIS <<<
CREATE TABLE demonstracoes_contabeis (
    ID SERIAL PRIMARY KEY,          -- Chave primária autoincremental (útil mas não essencial)
    DATA DATE,                      -- Data referente ao fim do trimestre (ex: '2023-03-31')
    REG_ANS INT,                    -- Chave estrangeira ligando à tabela operadoras
    CD_CONTA_CONTABIL VARCHAR(50),  -- Código da conta contábil (ex: '41111')
    DESCRICAO VARCHAR(255),         -- Descrição da conta contábil
    VL_SALDO_INICIAL NUMERIC(18, 2),-- Valor do saldo inicial
    VL_SALDO_FINAL NUMERIC(18, 2)  -- Valor do saldo final (assumido como valor da despesa/receita no período)
    -- Considere adicionar FOREIGN KEY após a importação dos dados:
    -- CONSTRAINT fk_operadora FOREIGN KEY (REG_ANS) REFERENCES operadoras(Registro_ANS)
);

-- Criação de Índices para otimizar consultas futuras
CREATE INDEX idx_operadoras_razao_social ON operadoras (Razao_Social);
CREATE INDEX idx_demonstracoes_reg_ans ON demonstracoes_contabeis (REG_ANS);
CREATE INDEX idx_demonstracoes_data ON demonstracoes_contabeis (DATA);
CREATE INDEX idx_demonstracoes_descricao ON demonstracoes_contabeis (DESCRICAO);
CREATE INDEX idx_demonstracoes_conta ON demonstracoes_contabeis (CD_CONTA_CONTABIL);

-- Mensagem de conclusão (opcional, funciona bem no psql)
-- \echo 'Tabelas operadoras e demonstracoes_contabeis criadas com sucesso (ou já existiam e foram recriadas).'
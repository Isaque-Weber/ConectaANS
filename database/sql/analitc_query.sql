-- =============================================
-- Script: consultas_analiticas.sql
-- Tarefa: 3.5 - Consultas analíticas
-- Banco: PostgreSQL >= 10.0
-- Data atual: 31 de março de 2025 (base para "último trimestre" e "último ano")
-- Descrição da despesa: EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR
-- =============================================

-- Consulta 1: Top 10 operadoras com maiores despesas no último trimestre
-- Último trimestre completo: 4T2024 (01/10/2024 a 31/12/2024), já que estamos em 31/03/2025
SELECT
    op.Razao_Social,
    op.Registro_ANS,
    SUM(dc.VL_SALDO_FINAL) AS Despesa_Total_Ultimo_Trimestre
FROM
    demonstracoes_contabeis dc
JOIN
    operadoras op ON dc.REG_ANS = op.Registro_ANS
WHERE
    -- Filtro dinâmico para o último trimestre completo (3 meses antes do trimestre atual)
    dc.DATA BETWEEN 
        DATE_TRUNC('quarter', CURRENT_DATE - INTERVAL '3 months') 
        AND DATE_TRUNC('quarter', CURRENT_DATE - INTERVAL '3 months') + INTERVAL '3 months - 1 day'
    -- Para 31/03/2025: 01/10/2024 a 31/12/2024 (4T2024)

    -- Filtro pela conta de despesa
    AND dc.DESCRICAO = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTENCIA A SAUDE MEDICO HOSPITALAR'
    -- Alternativa com código, se preferir: AND dc.CD_CONTA_CONTABIL LIKE '41111%'

GROUP BY
    op.Razao_Social, op.Registro_ANS
ORDER BY
    Despesa_Total_Ultimo_Trimestre DESC NULLS LAST
LIMIT 10;

-- Mensagem de conclusão
SELECT 'Consulta 1: Top 10 Despesas Último Trimestre concluída.' AS mensagem;

-- Consulta 2: Top 10 operadoras com maiores despesas no último ano
-- Último ano: Últimos 12 meses a partir de 31/03/2025 (01/04/2024 a 31/03/2025)
SELECT
    op.Razao_Social,
    op.Registro_ANS,
    SUM(dc.VL_SALDO_FINAL) AS Despesa_Total_Ultimo_Ano
FROM
    demonstracoes_contabeis dc
JOIN
    operadoras op ON dc.REG_ANS = op.Registro_ANS
WHERE
    -- Filtro dinâmico para os últimos 12 meses
    dc.DATA BETWEEN (CURRENT_DATE - INTERVAL '1 year') AND CURRENT_DATE
    -- Para 31/03/2025: 01/04/2024 a 31/03/2025

    -- Filtro pela conta de despesa
    AND dc.DESCRICAO = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTENCIA A SAUDE MEDICO HOSPITALAR'
    -- Alternativa com código, se preferir: AND dc.CD_CONTA_CONTABIL LIKE '41111%'

GROUP BY
    op.Razao_Social, op.Registro_ANS
ORDER BY
    Despesa_Total_Ultimo_Ano DESC NULLS LAST
LIMIT 10;

-- Mensagem de conclusão
SELECT 'Consulta 2: Top 10 Despesas Último Ano concluída.' AS mensagem;
-- SELECT DISTINCT descricao
-- FROM demonstracoes_contabeis; -- Utilizei para descobrir as descrições disponíveis na tabela.

-- identifiquei os principais itens de despesa relacionados a saúde, médico, hospitalar, sinistro e assistência.
-- SELECT DISTINCT descricao
-- FROM demonstracoes_contabeis
-- WHERE descricao LIKE '%SAÚDE%'
--    OR descricao LIKE '%MEDICO%'
--    OR descricao LIKE '%HOSPITALAR%'
--    OR descricao LIKE '%SINISTRO%'
--    OR descricao LIKE '%ASSISTENCIA%';

-- A consulta abaixo retorna as 10 operadoras com maior despesa total no último ano (2024) para os itens de despesa relacionados a saúde, médico, hospitalar, sinistro e assistência.
SELECT op.Razao_Social,
    op.Registro_ANS,
    SUM(dc.VL_SALDO_FINAL) AS Despesa_Total_Ultimo_Ano
FROM demonstracoes_contabeis dc
    JOIN operadoras op ON dc.REG_ANS = op.Registro_ANS
WHERE dc.DATA BETWEEN '2024-01-01' AND '2024-12-31' -- Filtra para o ano de 2024
    AND (
        descricao LIKE '%SAÚDE%'
        OR descricao LIKE '%MEDICO%'
        OR descricao LIKE '%HOSPITALAR%'
        OR descricao LIKE '%SINISTRO%'
        OR descricao LIKE '%ASSISTENCIA%'
        OR descricao LIKE '%EVENTOS%'
        OR descricao LIKE '%SINISTROS%')
GROUP BY op.Razao_Social,
    op.Registro_ANS
ORDER BY Despesa_Total_Ultimo_Ano DESC
LIMIT 10;

-- A consulta abaixo retorna as 10 operadoras com maior despesa total no último trimestre (2024) para os itens de despesa relacionados a saúde, médico, hospitalar, sinistro e assistência.
SELECT op.Razao_Social,
    op.Registro_ANS,
    SUM(dc.VL_SALDO_FINAL) AS Despesa_Total_Ultimo_Trimestre
FROM demonstracoes_contabeis dc
    JOIN operadoras op ON dc.REG_ANS = op.Registro_ANS
WHERE dc.DATA BETWEEN '2024-10-01' AND '2024-12-31' -- Filtra para o último trimestre de 2024
    AND (
        descricao LIKE '%SAÚDE%'
        OR descricao LIKE '%MEDICO%'
        OR descricao LIKE '%HOSPITALAR%'
        OR descricao LIKE '%SINISTRO%'
        OR descricao LIKE '%ASSISTENCIA%'
        OR descricao LIKE '%EVENTOS%'
        OR descricao LIKE '%SINISTROS%')
GROUP BY op.Razao_Social,
    op.Registro_ANS
ORDER BY Despesa_Total_Ultimo_Trimestre DESC
LIMIT 10;
-- Análise 1: Taxa geral de faltas
SELECT 
    COUNT(*) AS total_consultas,
    COUNT(*) FILTER (WHERE compareceu = false) AS faltas,
    ROUND(COUNT(*) FILTER (WHERE compareceu = false) * 100.0 / COUNT(*), 1) AS taxa_faltas_pct
FROM consultas;

-- Análise 2: Faltas por médico
SELECT 
    m.nome AS medico,
    COUNT(*) AS total_consultas,
    COUNT(*) FILTER (WHERE c.compareceu = false) AS faltas,
    ROUND(COUNT(*) FILTER (WHERE c.compareceu = false) * 100.0 / COUNT(*), 1) AS taxa_faltas_pct
FROM consultas c
JOIN medicos m ON c.medico_id = m.id
GROUP BY m.nome
ORDER BY taxa_faltas_pct DESC;


-- Análise 3: Consultas e faltas por cidade do paciente
SELECT 
    p.cidade,
    COUNT(*) AS total_consultas,
    COUNT(*) FILTER (WHERE c.compareceu = false) AS faltas,
    ROUND(COUNT(*) FILTER (WHERE c.compareceu = false) * 100.0 / COUNT(*), 1) AS taxa_faltas_pct
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id
GROUP BY p.cidade
ORDER BY total_consultas DESC;

-- Análise 4: Faltas por faixa etária do paciente
SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(p.data_nascimento)) < 18 THEN 'Menor de 18'
        WHEN EXTRACT(YEAR FROM AGE(p.data_nascimento)) BETWEEN 18 AND 39 THEN '18 a 39'
        WHEN EXTRACT(YEAR FROM AGE(p.data_nascimento)) BETWEEN 40 AND 59 THEN '40 a 59'
        ELSE '60 ou mais'
    END AS faixa_etaria,
    COUNT(*) AS total_consultas,
    COUNT(*) FILTER (WHERE c.compareceu = false) AS faltas,
    ROUND(COUNT(*) FILTER (WHERE c.compareceu = false) * 100.0 / COUNT(*), 1) AS taxa_faltas_pct
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id
GROUP BY faixa_etaria
ORDER BY faixa_etaria;

-- Análise 5: Volume de consultas por mês
SELECT 
    TO_CHAR(data_consulta, 'YYYY-MM') AS mes,
    COUNT(*) AS total_consultas,
    COUNT(*) FILTER (WHERE compareceu = false) AS faltas,
    ROUND(COUNT(*) FILTER (WHERE compareceu = false) * 100.0 / COUNT(*), 1) AS taxa_faltas_pct
FROM consultas
GROUP BY mes
ORDER BY mes;

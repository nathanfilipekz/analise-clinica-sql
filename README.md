# Análise de Dados de uma Clínica Médica com SQL

Projeto de análise de dados utilizando **PostgreSQL** para explorar o funcionamento de uma clínica médica, com foco em entender padrões de faltas de pacientes e gerar insights que apoiem decisões de gestão.

## Objetivo

Simular a base de dados de uma clínica e, a partir de consultas SQL, responder perguntas de negócio relevantes, como quem falta mais, de onde vêm os pacientes e como o volume de atendimentos varia ao longo do tempo.

## Tecnologias utilizadas

- **PostgreSQL**: banco de dados relacional
- **pgAdmin 4**: interface de administração e execução das consultas
- **SQL**: modelagem, inserção de dados e análises

## Estrutura do banco de dados

O banco `clinica_db` é composto por 4 tabelas relacionadas:

| Tabela | Descrição |
|---|---|
| `especialidades` | Especialidades médicas (Cardiologia, Pediatria, etc.) |
| `medicos` | Médicos e sua especialidade |
| `pacientes` | Pacientes, data de nascimento e cidade |
| `consultas` | Consultas agendadas, com data e indicador de comparecimento |

**Volume de dados:** 10 especialidades, 15 médicos, 50 pacientes e 200 consultas.

## Arquivos do projeto

- `01_criar_tabelas.sql`: criação das tabelas e relacionamentos
- `02_inserir_dados.sql`: inserção dos dados
- `03_consultas.sql`: consultas analíticas

## Análises realizadas

### 1. Taxa geral de faltas
Calcula o percentual total de consultas em que o paciente não compareceu.

**Resultado:** das 200 consultas, 43 resultaram em falta, uma **taxa de 21,5%**.

> **Insight de negócio:** mais de 1 em cada 5 consultas é perdida por falta. Isso representa perda de receita e de capacidade de atendimento, e indica uma oportunidade clara de implementar lembretes automáticos.

### 2. Faltas por médico
Usa `JOIN` para cruzar consultas com os médicos e ranquear a taxa de faltas de cada um.

> **Insight de negócio:** taxas muito altas aparecem em médicos com poucas consultas, onde o número pequeno distorce o percentual. Já os médicos com maior volume de atendimentos oferecem um retrato mais confiável do padrão real de faltas.

### 3. Faltas por cidade do paciente
Cruza consultas com o cadastro dos pacientes para analisar as faltas por região.

> **Insight de negócio:** Guarulhos (34,4%) e São Paulo (32,0%) concentram as maiores taxas de ausência, tornando-se regiões prioritárias para ações de confirmação e lembrete de consulta.

### 4. Faltas por faixa etária
Calcula a idade dos pacientes a partir da data de nascimento (`AGE` + `EXTRACT`) e os agrupa em faixas com lógica condicional (`CASE WHEN`).

> **Insight de negócio:** pacientes de 40 a 59 anos (27,8%) e de 60 anos ou mais (25,7%) apresentam as maiores taxas de falta, enquanto menores de 18 faltam bem menos (9,1%). Campanhas de lembrete podem ser direcionadas especialmente aos grupos de maior risco.

### 5. Volume de consultas por mês
Formata e agrupa as consultas por período (`TO_CHAR`) para visualizar a evolução temporal.

> **Insight de negócio:** o volume de atendimentos varia ao longo do ano, com meses de pico. Esse padrão ajuda a clínica a planejar a escala de médicos e a alocação de recursos.

## Conceitos de SQL demonstrados

- Modelagem relacional com chaves estrangeiras (`REFERENCES`)
- Agregações (`COUNT`, `ROUND`)
- Filtros condicionais com `FILTER (WHERE ...)`
- Junções entre tabelas (`JOIN`)
- Lógica condicional (`CASE WHEN`)
- Cálculo de datas (`AGE`, `EXTRACT`, `TO_CHAR`)
- Agrupamento e ordenação (`GROUP BY`, `ORDER BY`)

## Como executar

1. Crie o banco `clinica_db` no PostgreSQL
2. Execute `01_criar_tabelas.sql`
3. Execute `02_inserir_dados.sql`
4. Explore as análises em `03_consultas.sql`

---

**Autor:** Nathan Filipe Rosa de Souza
[GitHub](https://github.com/nathanfilipekz) · [LinkedIn](https://www.linkedin.com/in/nathan-filipe-rosa-de-souza/)

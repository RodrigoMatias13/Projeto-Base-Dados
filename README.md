# VINISYS — Sistema de Informação e Gestão Vinícola

Este repositório contém o projeto académico desenvolvido no âmbito da unidade curricular de **Bases de Dados** (Ano Letivo 2024/2025) nos cursos de LEI, LETI e LIGE do **Iscte - Instituto Universitário de Lisboa**.

O **VINISYS** é um sistema de informação completo concebido para garantir a gestão integrada de uma empresa distribuidora de vinhos, cobrindo todo o ciclo de vida do produto — desde a plantação das castas nas vinhas, passando pela colheita, produção, engarrafamento, atribuição de prémios, até à comercialização (vendas, faturação e devoluções aos clientes).

---

## 📂 Estrutura do Projeto

*   `PARTE1/` — Modelação conceptual, lógica e física da base de dados (BoUML, DDL e DML).
*   `PARTE2/` — Implementação de automatismos (Triggers, Procedures, Funções), queries analíticas complexas, views e protótipo de aplicação web em PHP.

---

## ⚙️ Detalhe das Fases de Desenvolvimento

### PARTE 1 — Modelação e Implementação Física

Nesta fase foi desenhado e implementado o esquema da base de dados relacional capaz de suportar as regras de negócio da distribuidora:
*   **Modelação Conceptual (BoUML):** Elaboração do diagrama de classes UML definindo as entidades principais como `VINHO`, `PRODUTOR`, `COLHEITA`, `VINHA`, `CASTA`, `COLABORADOR` (com especializações para `ENOLOGO` e `TRABALHADOR`, incluindo relações de chefia reflexivas), `CLIENTE`, `FATURA` e `DEVOLUCAO`.
*   **Implementação Física (SQL DDL/DML):** Scripts estruturados para a criação de tabelas com chaves primárias, estrangeiras e restrições de integridade, seguidos do povoamento da base de dados.

---

### PARTE 2 — Automatismos, Queries e Protótipo Web

Desenvolvimento da lógica de negócio programável diretamente no SGBD e interface de utilizador web-based.

#### 1. Automatismos (SQL)
*   **Triggers:**
    *   `T1`: Atualização automática da quantidade cultivada na tabela `PRODUZ` sempre que é inserido um novo registo de plantação de uma casta numa vinha.
    *   `T2`: Registo automático da data de início de uma colheita na tabela `COLHEITA` aquando da inserção do primeiro trabalhador associado em `PARTICIPA`.
*   **Stored Procedures:**
    *   `P1`: Registar uma nova participação de um trabalhador numa colheita com cálculo e gravação automática da sua remuneração total (com base nas horas trabalhadas).
    *   `P2`: Registar uma nova colheita associando-a dinamicamente a um produtor e a uma região vinícola.
*   **Funções:**
    *   `F1`: Cálculo do total de horas trabalhadas por todos os colaboradores numa colheita específica.
    *   `F2`: Cálculo da área total cultivada (em hectares) de uma determinada casta somando todas as vinhas registadas.

#### 2. Pesquisa de Dados e Relatórios (Queries e Views)
*   **Consultas de Análise (`Q1` a `Q6`):**
    *   Mapeamento de vinhas e respetivas castas de uva.
    *   Identificação dos vinhos mais premiados e análise histórica de prémios recebidos em anos consecutivos.
    *   Análise de desempenho geográfico (castas mais produzidas por região).
    *   Controlo financeiro de perdas com devoluções superiores a 100€ em 2023.
    *   Identificação de *bestsellers* (vinhos mais vendidos por cada produtor).
*   **Views de Otimização:**
    *   `vinhos_produtores`: Consolidação de informação de produtores, vinhos, regiões e edições.
    *   `empresas_maiores_compras`: Ranking de clientes corporativos ordenados descendentemente pelo volume total financeiro faturado.

#### 3. Protótipo de Aplicação Web (HTML/PHP)
Criação de uma interface administrativa web intuitiva, ligada à base de dados, contendo as seguintes páginas e fluxos:
*   **`W1` - Registo de Colheitas:** Formulário de duas fases para introdução de colheitas em curso (indicando ano, data de início, região e produtor) e posterior atualização de fecho (data de fim e peso total de uva colhida em kg).
*   **`W2` - Catálogo e Detalhes de Vinhos:** Motor de busca simples e avançado (por ID, região, ou perfil sensorial: tipo, cor, aroma, sabor) que redireciona para um ecrã detalhado com a ficha técnica do vinho, dados do produtor e histórico de medalhas/prémios obtidos.
*   **`W3` - Gestão de Clientes e Vendas:** Listagem analítica de clientes contendo o total de garrafas adquiridas e valor global gasto, integrando um mecanismo seguro para eliminação de clientes inativos (sem compras/faturas associadas).

---

## 🛠️ Tecnologias Utilizadas

*   **SGBD:** MySQL / MariaDB (ou outro SGBD SQL compatível)
*   **Linguagem de Scripting:** PHP (Desenvolvimento do Back-end Web)
*   **Markup & Estilo:** HTML5 / CSS3
*   **Modelação:** BoUML (Modelos Conceptual e Lógico)

---

## 🚀 Como Executar

### 1. Configuração da Base de Dados

1. Importa os scripts SQL de criação do esquema (DDL) localizados na pasta `PARTE1/` ou a base de dados oficial disponibilizada na `PARTE2/` no teu SGBD:
   ```sql
   SOURCE caminho/para/script_criacao.sql;
   SOURCE caminho/para/povoamento.sql;
   ```
2. Executa o script que cria os triggers, stored procedures, funções e views na pasta PARTE2/.

### 2. Configuração do Servidor Web

1. Garante que tens um ambiente local configurado como o XAMPP, WAMP ou LAMP.
2. Copia a pasta do protótipo web (ficheiros .php e .html da PARTE2/) para o diretório de documentos do servidor (ex: htdocs/ ou /var/www/html/).
3. Ajusta os parâmetros de ligação à base de dados (host, username, password, db_name) no ficheiro de configuração de ligação PHP do teu projeto.
4. Abre o teu navegador e acede a: http://localhost/ViniSys/

## 👤 Autor
* Rodrigo Matias

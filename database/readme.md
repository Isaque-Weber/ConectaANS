## ConectaANS - Análise de Dados da ANS

Este projeto tem como objetivo baixar, organizar e preparar dados da Agência Nacional de Saúde Suplementar (ANS) para análise, com foco nas demonstrações contábeis das operadoras e nos dados cadastrais.

### Objetivos

* **Download Automatizado:** Baixar arquivos de demonstrações contábeis dos últimos dois anos e os dados cadastrais das operadoras ativas diretamente das fontes da ANS.
* **Organização de Dados:** Estruturar os dados baixados em pastas organizadas por tipo.
* **Conversão para CSV:** Converter os arquivos ZIP de demonstrações contábeis para o formato CSV, facilitando a importação para bancos de dados e análise.
* **Preparação para Análise SQL:** Fornecer arquivos CSV prontos para serem importados em bancos de dados MySQL ou PostgreSQL para posterior análise através de queries SQL.

### Estrutura do Projeto

O projeto consiste em dois scripts Python para manipulação dos dados e arquivos SQL para interação com o banco de dados:


conecta_ans/
├── dados_ans/
│   ├── demonstracoes_contabeis/  # Arquivos ZIP baixados
│   └── csv_demonstracoes/      # Arquivos CSV convertidos
│   └── dados_cadastrais/       # Arquivo CSV de dados cadastrais
├── scripts/
│   ├── download_ans_data.py    # Script para baixar os dados da ANS
│   └── converter_para_csv.py # Script para converter arquivos ZIP para CSV
├── sql/
│   ├── analitc_query.sql     # Arquivo contendo as queries analíticas
│   ├── import_data.sql       # Arquivo contendo as queries para importar os dados CSV para as tabelas
│   └── setup_tables.sql      # Arquivo contendo as queries para criar as tabelas no banco de dados
├── README.md
└── Requirements.txt


### Pré-requisitos

* **Python 3.x:** Necessário para executar os scripts Python. Recomenda-se usar um gerenciador de ambientes como o `venv` para isolar as dependências do projeto.
* **Bibliotecas Python:** As seguintes bibliotecas são necessárias e podem ser instaladas usando o pip (gerenciador de pacotes do Python).
* **Acesso à Internet:** Para baixar os arquivos dos servidores da ANS.
* **Banco de Dados:** Um servidor de banco de dados MySQL 8.x ou PostgreSQL > 10.0 instalado e em execução.
* **Docker (Opcional):** Se você pretende usar um contêiner Docker para rodar o PostgreSQL, como mencionado durante o desenvolvimento.
* **Cliente SQL:** Uma ferramenta para se conectar ao seu banco de dados (e.g., pgAdmin, MySQL Workbench, DBeaver).

### Configuração do Ambiente de Desenvolvimento

Para configurar o ambiente de desenvolvimento e rodar este projeto, siga os passos abaixo:

1.  **Clonar o Repositório:**
    ```bash
    git clone <URL_do_seu_repositório>
    cd conecta_ans
    ```

2.  **Criar um Ambiente Virtual (Recomendado):**
    ```bash
    python -m venv venv
    source venv/bin/activate   # No Linux ou macOS
    .\venv\Scripts\activate  # No Windows
    ```

3.  **Instalar as Dependências:**
    Crie o arquivo `requirements.txt` com o seguinte conteúdo:
    ```
    requests
    python-dateutil
    pandas
    ```
    E execute:
    ```bash
    pip install -r requirements.txt
    ```

4.  **Configurar o Banco de Dados:**
    * **Certifique-se de que seu servidor MySQL ou PostgreSQL esteja rodando.** Se estiver usando Docker para PostgreSQL, siga as instruções da seção anterior no README.
    * **Crie um banco de dados** onde as tabelas serão criadas (você pode usar a linha de comando ou um cliente SQL para isso).

### Como Utilizar

1.  **Executar o Script de Download:**
    ```bash
    python scripts/download_ans_data.py
    ```

2.  **Executar o Script de Conversão para CSV:**
    ```bash
    python scripts/converter_para_csv.py
    ```

3. **Configurar o Banco de Dados e Importar os Dados:**
    * **Conecte-se ao seu banco de dados** (MySQL ou PostgreSQL) usando um cliente SQL.
    * **Execute os scripts SQL na pasta `sql/` na seguinte ordem:**
        1.  `setup_tables.sql`: Cria as tabelas necessárias no banco de dados para armazenar os dados da ANS. Certifique-se de que o banco de dados esteja vazio antes de executar este script.
        2.  `import_data.sql`: Importa os dados dos arquivos CSV localizados nas pastas `dados_ans/csv_demonstracoes/` e `dados_ans/dados_cadastrais/` para as tabelas criadas. **Ajuste os caminhos dos arquivos CSV no script, se necessário.**
        3.  `analitc_query.sql`: Contém consultas analíticas para responder a perguntas como "Quais foram as maiores despesas das operadoras no último trimestre?" e "Quais operadoras tiveram maior crescimento no último ano?". Execute este script após a importação dos dados.

### Observações

* Os arquivos de demonstrações contábeis são baixados em formato ZIP e contêm arquivos CSV com codificação `latin1` e separador `;`. O script de conversão tenta lidar com isso, mas pode ser necessário ajustar a codificação ou o separador caso encontre problemas.
* A URL para os dados cadastrais das operadoras ativas pode mudar. O script `scripts/download_ans_data.py` utiliza o link fornecido, mas é importante verificar se o link ainda é válido caso o download falhe. A URL utilizada no momento é: `https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv`.
* O script de download das demonstrações contábeis está configurado para baixar os arquivos dos anos de 2023 e 2024. Para incluir mais anos, você pode modificar a função `baixar_demonstracoes_contabeis` no arquivo `scripts/download_ans_data.py`.
* **Importante:** Os scripts SQL na pasta `sql/` são fornecidos como um guia. Você precisará adaptá-los para corresponder à estrutura exata dos arquivos CSV (nomes de colunas, tipos de dados, etc.) e aos detalhes da sua instalação do banco de dados.

### Próximos Passos

* **Preencher os arquivos SQL** com as queries necessárias para criar as tabelas, importar os dados e realizar a análise.

Este README agora descreve a estrutura do projeto de forma mais completa, incluindo a pasta `sql/` e a finalidade de cada um dos arquivos SQL. Ele também enfatiza a necessidade de configurar o banco de dados e executar os scripts SQL na ordem correta, além de alertar para a possível necessidade de adaptar os scripts SQL aos detalhes do ambiente.
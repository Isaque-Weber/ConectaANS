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
* **Banco de Dados:** Um servidor de banco de dados PostgreSQL > 10.0 instalado e em execução.
* **Docker (Opcional):** Se você pretende usar um contêiner Docker para rodar o PostgreSQL, como mencionado durante o desenvolvimento.
* **Cliente SQL:** Uma ferramenta para se conectar ao seu banco de dados (e.g., pgAdmin, MySQL Workbench, DBeaver) no ambiente de desenvolvimento eu utilizei o SQLTools do vscode.

### Configuração do Ambiente de Desenvolvimento

Para configurar o ambiente de desenvolvimento e rodar este projeto, siga os passos abaixo:

1.  **Clonar o Repositório:**
    ```bash
    git clone https://github.com/Isaque-Weber/ConectaANS
    cd conecta_ans
    ```

2.  **Criar um Ambiente Virtual (Recomendado):**
    ```bash
    python -m venv venv
    source venv/bin/activate   # No Linux ou macOS
    .\venv\Scripts\activate  # No Windows
    ```

3.  **Instalar as Dependências:**
    Execute o arquivo `requirements.txt` :
    
    ```bash
    pip install -r requirements.txt
    ```

4.  **Configurar o Banco de Dados:**
    * **Certifique-se de que seu servidor MySQL ou PostgreSQL esteja rodando.** Se estiver usando Docker para PostgreSQL, siga as instruções da seção anterior no README.
    * **Crie um banco de dados** onde as tabelas serão criadas (você pode usar a linha de comando ou um cliente SQL para isso). 
    OBS:crie o BD e depois, é só seguir o passo a passo dos scripts SQL

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

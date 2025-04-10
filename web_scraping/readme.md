# Web Scraping - Download de PDFs da ANS

Este script realiza o **web scraping** na página de atualização do rol de procedimentos da ANS e baixa somente os arquivos PDF referentes ao **Anexo I** e **Anexo II**. Após o download, os PDFs são armazenados na pasta `docs` e compactados em um arquivo ZIP "anexos.zip".

## Funcionalidades

- Acessa a página de atualização da ANS.
- Filtra e baixa os PDFs referentes a Anexo I e Anexo II.
- Armazena os PDFs na pasta "docs" e os comprime em um arquivo ZIP.

## Pré-requisitos

- Python 3.12.0
- Bibliotecas: `requests` e `beautifulsoup4`

Instale as dependências com:

```bash
pip install requests beautifulsoup4
```

## Instalação

1. Clone o repositório:

```bash
git clone https://seu-repositorio-url.git
```

2. Navegue até o diretório do projeto:

```bash
cd ConectaANS/web_scraping
```

3. (Opcional) Crie e ative um ambiente virtual:

- No Windows:

    ```bash
    python -m venv venv
    venv\Scripts\activate
    ```

- No Linux/macOS:

    ```bash
    python3 -m venv venv
    source venv/bin/activate
    ```

4. Instale as dependências (se houver um arquivo requirements.txt):

```bash
pip install -r requirements.txt
```

## Uso

Garanta que a pasta "docs" exista (o script a criará se necessário) e execute:

```bash
python src/scraping.py
```

O script:
- Acessa a página da ANS.
- Filtra os links dos PDFs desejados.
- Salva os arquivos na pasta "docs" e os comprime em "anexos.zip".

## Estrutura do Projeto

```
/ConectaANS
├── docs/            # PDFs baixados e o arquivo ZIP
├── web_scraping/
│   ├── src/
│   │   └── scraping.py
│   └── README.md
└── (outras partes do projeto)
```

## Solução de Possíveis Problemas

- Nenhum PDF baixado: Revise os critérios de filtragem do script conforme a nomenclatura atual dos arquivos.
- Erros de conexão: Verifique sua conexão com a internet e o acesso ao site.
- Problemas de permissão: Assegure que o script tenha permissão para criar e escrever na pasta "docs".
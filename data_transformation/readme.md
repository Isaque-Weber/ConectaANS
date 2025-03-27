# Data Transformation - Extração e Conversão de Dados

Este script realiza a extração dos dados da tabela "Rol de Procedimentos e Eventos em Saúde" presente no PDF do Anexo I. Em seguida, os dados são salvos em um arquivo CSV e compactados em um arquivo ZIP.

## Funcionalidades

- Abre o PDF e extrai as tabelas de todas as páginas utilizando `pdfplumber`.
- Combina as tabelas extraídas em um único DataFrame.
- Substitui as abreviações das colunas `OD` e `AMB` pelas descrições completas, conforme a legenda do rodapé.
- Salva os dados extraídos em um arquivo CSV.
- Compacta o CSV em um arquivo ZIP denominado `Teste_SeuNome.zip`.

## Pré-requisitos

- **Python 3.x**  
  (Verifique sua versão com `python --version` ou `python3 --version`)
- Bibliotecas:
  - `pdfplumber`
  - `pandas`

Para instalar as dependências necessárias, execute:

```bash
pip install pdfplumber pandas

Instruções
Localize o PDF do Anexo I
Certifique-se de que o PDF do Anexo I (por exemplo, Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf) esteja localizado na pasta docs.

Ajuste o Mapeamento das Colunas
No script, atualize o dicionário rename_map com os nomes completos corretos para as colunas OD e AMB, conforme informado na legenda do rodapé do PDF.

Execute o Script
Execute o script de transformação:

bash
Copiar
python src/transform.py
Nota: Verifique se o caminho para o PDF está correto no script.

```

## Estrutura do Projeto

```bash
Copiar
/ConectaANS
├── docs/                       # Contém o PDF do Anexo I e os arquivos gerados (CSV e ZIP)
├── data_transformation/
│   ├── src/
│   │   └── transform.py        # Script de transformação de dados
│   └── README.md               # Este arquivo
└── (outras partes do projeto)

```
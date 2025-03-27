import pdfplumber
import pandas as pd
import os
import zipfile

def extract_table_from_pdf(pdf_path):
    all_tables = []
    with pdfplumber.open(pdf_path) as pdf:
        num_pages = len(pdf.pages)
        print(f"Total de páginas: {num_pages}")
        for idx, page in enumerate(pdf.pages):
            print(f"Processando página {idx + 1}/{num_pages}...")
            try:
                table = page.extract_table()
            except Exception as e:
                print(f"Erro ao extrair tabela na página {idx + 1}: {e}")
                continue
            if table:
                try:
                    # Converter a tabela para DataFrame assumindo que a primeira linha é o cabeçalho
                    df = pd.DataFrame(table[1:], columns=table[0])
                    all_tables.append(df)
                    print(f"Tabela extraída com sucesso na página {idx + 1}")
                except Exception as e:
                    print(f"Erro ao converter tabela para DataFrame na página {idx + 1}: {e}")
            else:
                print(f"Nenhuma tabela encontrada na página {idx + 1}")
    if all_tables:
        combined_df = pd.concat(all_tables, ignore_index=True)
        print("Todas as tabelas foram combinadas com sucesso.")
        return combined_df
    else:
        print("Nenhuma tabela foi extraída do PDF.")
        return None

def replace_abbreviations(df, mapping):
    print("Substituindo abreviações nas colunas...")
    return df.rename(columns=mapping)

def save_csv_and_zip(df, csv_filename, zip_filename):
    print("Salvando CSV...")
    df.to_csv(csv_filename, index=False, encoding='utf-8')
    print("Compactando CSV em arquivo ZIP...")
    with zipfile.ZipFile(zip_filename, 'w', zipfile.ZIP_DEFLATED) as zipf:
        zipf.write(csv_filename, arcname=os.path.basename(csv_filename))
    print(f"CSV salvo e compactado em {zip_filename}")

if __name__ == "__main__":
    # Defina o caminho do PDF do Anexo I
    pdf_file = os.path.join("docs", "Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf")
    print(f"Abrindo PDF: {pdf_file}")
    
    # Extrai a tabela do PDF
    df = extract_table_from_pdf(pdf_file)
    if df is not None:
        # Atualize o mapeamento conforme a legenda do PDF
        rename_map = {
            "OD": "Nome Completo de OD",   # Exemplo de substituição
            "AMB": "Nome Completo de AMB"    # Exemplo de substituição
        }
        df = replace_abbreviations(df, rename_map)
        
        # Define os caminhos para o CSV e o arquivo ZIP
        csv_path = os.path.join("docs", "rol_de_procedimentos.csv")
        zip_path = os.path.join("docs", "Teste_SeuNome.zip")  # Substitua 'SeuNome' pelo seu nome
        
        # Salva e compacta o CSV
        save_csv_and_zip(df, csv_path, zip_path)
    else:
        print("Nenhuma tabela encontrada no PDF.")

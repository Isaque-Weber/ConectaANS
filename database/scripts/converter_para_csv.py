import os
import zipfile
import pandas as pd

def converter_zip_para_csv(diretorio_zip, diretorio_csv):
    """
    Converte arquivos ZIP contendo CSV para arquivos CSV individuais.

    Args:
        diretorio_zip (str): Caminho para o diretório com os arquivos ZIP.
        diretorio_csv (str): Caminho para o diretório onde os CSVs serão salvos.
    """
    os.makedirs(diretorio_csv, exist_ok=True)
    for nome_arquivo in os.listdir(diretorio_zip):
        if nome_arquivo.endswith(".zip"):
            caminho_zip = os.path.join(diretorio_zip, nome_arquivo)
            try:
                with zipfile.ZipFile(caminho_zip, 'r') as arquivo_zip:
                    for nome_arquivo_interno in arquivo_zip.namelist():
                        if nome_arquivo_interno.endswith(".csv"):
                            with arquivo_zip.open(nome_arquivo_interno) as arquivo_csv_zip:
                                try:
                                    # Tenta ler o CSV diretamente do arquivo ZIP
                                    df = pd.read_csv(arquivo_csv_zip, encoding='utf-8', sep=';')
                                    nome_arquivo_csv = os.path.splitext(nome_arquivo)[0] + ".csv"
                                    caminho_csv = os.path.join(diretorio_csv, nome_arquivo_csv)
                                    df.to_csv(caminho_csv, index=False, encoding='utf-8', sep=';')
                                    print(f"Arquivo CSV convertido: {caminho_csv}")
                                except pd.errors.ParserError as e:
                                    print(f"Erro ao ler CSV dentro de {nome_arquivo}: {e}")
                                except Exception as e:
                                    print(f"Erro inesperado ao processar CSV em {nome_arquivo}: {e}")
            except zipfile.BadZipFile:
                print(f"Arquivo ZIP corrompido ou inválido: {caminho_zip}")
            except Exception as e:
                print(f"Erro ao processar o arquivo ZIP {caminho_zip}: {e}")

if __name__ == "__main__":
    diretorio_principal = os.path.join("database", "dados_ans")
    diretorio_zip = os.path.join(diretorio_principal, "demonstracoes_contabeis")
    diretorio_csv = os.path.join(diretorio_principal, "csv_demonstracoes")
    converter_zip_para_csv(diretorio_zip, diretorio_csv)
    print("\nConversão dos arquivos ZIP para CSV concluída!")
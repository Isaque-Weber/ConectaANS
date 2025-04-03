import requests
import os
from datetime import datetime, date
from dateutil.relativedelta import relativedelta

def baixar_arquivo(url, diretorio):
    """Baixa um arquivo da URL especificada e salva no diretório."""
    nome_arquivo = os.path.join(diretorio, url.split('/')[-1])
    resposta = requests.get(url, stream=True)
    resposta.raise_for_status()
    with open(nome_arquivo, 'wb') as arquivo:
        for chunk in resposta.iter_content(chunk_size=8192):
            arquivo.write(chunk)
    print(f"Arquivo baixado: {nome_arquivo}")

def baixar_demonstracoes_contabeis(diretorio_principal="dados_ans"):
    """Baixa os arquivos de demonstrações contábeis dos últimos 2 anos."""
    diretorio_demonstracoes = os.path.join(diretorio_principal, "demonstracoes_contabeis")
    os.makedirs(diretorio_demonstracoes, exist_ok=True)
    url_base = "https://dadosabertos.ans.gov.br/FTP/PDA/demonstracoes_contabeis/"
    hoje = date.today()
    dois_anos_atras = hoje - relativedelta(years=2)

    ano_inicial = dois_anos_atras.year
    ano_final = 2024

    for ano in range(ano_inicial, ano_final + 1):
        if ano <= hoje.year:  # Adicionando esta verificação
            url_ano = f"{url_base}{ano}/"
            try:
                resposta_ano = requests.get(url_ano)
                resposta_ano.raise_for_status()
                links = [link.split('"')[1] for link in resposta_ano.text.split() if ".zip" in link]
                for link in links:
                    baixar_arquivo(f"{url_ano}{link}", diretorio_demonstracoes)
            except requests.exceptions.RequestException as e:
                print(f"Erro ao acessar ou baixar arquivos de {url_ano}: {e}")

def baixar_dados_cadastrais(diretorio_principal="dados_ans"):
    """Baixa os dados cadastrais das operadoras ativas."""
    diretorio_cadastrais = os.path.join(diretorio_principal, "dados_cadastrais")
    os.makedirs(diretorio_cadastrais, exist_ok=True)
    url_cadastrais_alternativa = "https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv" # Tentativa com um ano específico
    try:
        baixar_arquivo(url_cadastrais_alternativa, diretorio_cadastrais)
    except requests.exceptions.HTTPError as e:
        print(f"Erro ao baixar dados cadastrais da URL alternativa ({url_cadastrais_alternativa}): {e}")
        print("Por favor, verifique a URL mais recente dos dados cadastrais em https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/")

if __name__ == "__main__":
    diretorio_base = os.path.join("database", "dados_ans")
    os.makedirs(diretorio_base, exist_ok=True)
    baixar_demonstracoes_contabeis(diretorio_base)
    baixar_dados_cadastrais(diretorio_base)
    print("\nDownload dos arquivos concluído!")
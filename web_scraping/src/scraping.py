import requests
from bs4 import BeautifulSoup
import os
import zipfile

def download_specific_pdfs():
    url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
    response = requests.get(url)
    response.raise_for_status()

    soup = BeautifulSoup(response.text, "html.parser")

    # Vamos filtrar para pegar apenas Anexo I e Anexo II
    pdf_links = []
    for link in soup.find_all("a", href=True):
        href = link["href"]
        # Ajuste o critério de filtro conforme necessário
        if href.lower().endswith(".pdf") and ("Anexo_I_Rol" in href or "Anexo_II_DUT" in href):
            pdf_links.append(href)

    # Use a pasta docs como local para os PDFs e para o ZIP
    download_path = os.path.join("docs")
    os.makedirs(download_path, exist_ok=True)

    # Baixa cada PDF
    for pdf_url in pdf_links:
        pdf_name = pdf_url.split("/")[-1]

        # Se o link for relativo, concatena com a URL base
        if pdf_url.startswith("/"):
            pdf_url = "https://www.gov.br" + pdf_url

        print(f"Baixando {pdf_name}...")
        r = requests.get(pdf_url)
        r.raise_for_status()

        # Salva o PDF dentro de docs
        pdf_path = os.path.join(download_path, pdf_name)
        with open(pdf_path, "wb") as f:
            f.write(r.content)

    # Cria o arquivo ZIP dentro de docs
    zip_filename = os.path.join(download_path, "anexos.zip")
    with zipfile.ZipFile(zip_filename, "w") as zipf:
        for root, dirs, files in os.walk(download_path):
            for file in files:
                if file.endswith(".pdf"):
                    file_path = os.path.join(root, file)
                    zipf.write(file_path, arcname=file)

    print(f"PDFs baixados e compactados em {zip_filename}.")

if __name__ == "__main__":
    download_specific_pdfs()

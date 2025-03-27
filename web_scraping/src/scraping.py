import requests
from bs4 import BeautifulSoup
import os
import zipfile

def download_pdfs():
    url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
    response = requests.get(url)
    response.raise_for_status()

    soup = BeautifulSoup(response.text, "html.parser")

    # Exemplo: encontrar links que levam a PDF
    pdf_links = []
    for link in soup.find_all("a", href=True):
        href = link["href"]
        if href.lower().endswith(".pdf"):
            pdf_links.append(href)

    # Baixar cada PDF
    os.makedirs("pdfs", exist_ok=True)
    for pdf_url in pdf_links:
        pdf_name = pdf_url.split("/")[-1]
        pdf_path = os.path.join("pdfs", pdf_name)

        # Se o link for relativo, talvez seja preciso concatenar com a URL base
        if pdf_url.startswith("/"):
            pdf_url = "https://www.gov.br" + pdf_url

        print(f"Baixando {pdf_name}...")
        r = requests.get(pdf_url)
        r.raise_for_status()

        with open(pdf_path, "wb") as f:
            f.write(r.content)

    # Compactar os PDFs em um arquivo ZIP
    docs_folder = os.path.join("..", "..", "docs")
    os.makedirs(docs_folder, exist_ok=True)
    zip_filename = os.path.join(docs_folder, "anexos.zip")
    with zipfile.ZipFile(zip_filename, "w") as zipf:
        for root, dirs, files in os.walk("pdfs"):
            for file in files:
                file_path = os.path.join(root, file)
                zipf.write(file_path, arcname=file)

    print(f"PDFs baixados e compactados em {zip_filename}.")

if __name__ == "__main__":
    download_pdfs()

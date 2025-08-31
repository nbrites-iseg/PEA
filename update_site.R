#Passo 0: atualizar o Rmd

# Passo 1: No Terminal (dentro da pasta PEA), corre uma vez:

# git init
# git branch -M main
# git remote add origin https://github.com/nbrites-iseg/PEA.git
# git push -u origin main

# Passo 2: correr no RStudio source("update_site.R")

# update_site.R
# Script para atualizar automaticamente o site Bookdown no GitHub Pages

library(bookdown)

# ---- 0) Aviso sobre remote ----
# ⚠️ IMPORTANTE: antes da primeira utilização tens de correr no terminal:
# git init
# git branch -M main
# git remote add origin https://github.com/<UTILIZADOR>/<REPO>.git
# git push -u origin main
# (Só precisas de fazer isto UMA VEZ)

# ---- 1) Limpeza (remove builds antigos) ----
bookdown::clean_book()

# ---- 2) Renderizar o livro (HTML + PDF) ----
render_book("index.Rmd", c("bookdown::gitbook", "bookdown::pdf_document2"))

# ---- 3) Copiar o PDF para a pasta docs ----
if (file.exists("_main.pdf")) {
  file.copy("_main.pdf", "docs/_main.pdf", overwrite = TRUE)
  message("✅ Copiado _main.pdf para docs/_main.pdf")
} else {
  message("⚠️ PDF não foi encontrado. Verifica se a compilação correu bem.")
}

# ---- 4) Commit & Push no GitHub ----
system("git add -A")
system("git commit -m 'Atualização automática do site (HTML + PDF)'")
system("git push")

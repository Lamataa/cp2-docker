# Docker Labs — CP2

Repositório com os laboratórios 1 e 2 do Checkpoint 2 da disciplina de Docker.

---

## LAB 1 — Stack Flask + Redis com Docker Compose

### Arquivos

- `app/app.py`
- `app/requirements.txt`
- `Dockerfile`
- `docker-compose.yml`

### Passo a Passo

1. Subir a stack com Docker Compose:
docker compose up -d

2. Verificar containers em execução:
docker compose ps

3. Verificar network e volume criados:
docker network ls
docker volume ls

4. Acessar no navegador: **http://localhost:5000**

### Evidências

Arquivo `docker-compose.yml` no VS Code:
<!-- PRINT: docker compose no vscode -->

Build e inicialização (`docker compose up -d`):
<!-- PRINT: docker compose up -->

Containers em execução (`docker compose ps`):
<!-- PRINT: docker compose ps -->

Aplicação funcionando no navegador:
<!-- PRINT: localhost -->

Network criada (`docker network ls`):
<!-- PRINT: docker network ls -->

Volume criado (`docker volume ls`):
<!-- PRINT: docker volume ls -->

---

## LAB 2 — Multi-Stage Build e Docker Hub

### Arquivos

- `Dockerfile`
- `app/app.py`
- `app/requirements.txt`

### Dockerfile
FROM python:3.11-slim AS builder
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
FROM python:3.11-slim
LABEL maintainer="Gabriel Lamata"
LABEL version="1.0.0"
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY app/ .
EXPOSE 5000
RUN useradd -m appuser
USER appuser
CMD ["python", "app.py"]

### Boas Práticas Aplicadas

- **Multi-stage build**: imagem final sem dependências de build
- **Versionamento**: `LABEL version="1.0.0"` e tag `:1.0.0` no registry
- **Controle de dependências**: `requirements.txt` com versões fixas
- **Ordem de cache**: `requirements.txt` copiado antes do código-fonte
- **Usuário não-root**: `appuser` por segurança

### Passo a Passo

1. Build da imagem:
docker build -t lamataa/cp2-app:1.0.0 .

2. Login no Docker Hub:
docker login

3. Push da imagem para o registry:
docker push lamataa/cp2-app:1.0.0

4. Executar o container:
docker compose up -d

### Evidências

Dockerfile no VS Code:
<!-- PRINT: docker compose no vscode (o mesmo print serve aqui) -->

Build da imagem (`docker build`):
<!-- PRINT: não temos esse, pode pular ou refazer com: docker build -t lamataa/cp2-app:1.0.0 . -->

Push para o Docker Hub (`docker push`):
<!-- PRINT: docker login e push -->

Imagem publicada no Docker Hub:
<!-- PRINT: repositorio do docker -->
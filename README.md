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
<img width="1920" height="1026" alt="docker compose" src="https://github.com/user-attachments/assets/5799a047-fe92-4ff2-80c0-4d879517f040" />

Build e inicialização (`docker compose up -d`):
<img width="1920" height="1030" alt="docker compose up" src="https://github.com/user-attachments/assets/5e4278c8-3f0d-410f-9c33-a90425fe0b51" />

Containers em execução (`docker compose ps`):
<img width="1920" height="1030" alt="docker compose ps" src="https://github.com/user-attachments/assets/14878ad8-7ac2-4c66-92b5-b15707f76aed" />

Aplicação funcionando no navegador:
<img width="1913" height="990" alt="localhost" src="https://github.com/user-attachments/assets/9cb961e1-1392-438b-9e5b-a1ea5e5032a7" />

Network criada (`docker network ls`):
<img width="1920" height="1028" alt="docker netowrk e volume" src="https://github.com/user-attachments/assets/988d7c40-4511-4fa1-8197-687cad640510" />

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

Push para o Docker Hub (`docker push`):
<img width="1920" height="1028" alt="login e push" src="https://github.com/user-attachments/assets/461fb271-a9c9-45a2-b4ac-7f2df3b3684d" />


Imagem publicada no Docker Hub:
<img width="1916" height="988" alt="hub" src="https://github.com/user-attachments/assets/facdd6d2-14e5-4e94-90f7-b8998bfb24c1" />

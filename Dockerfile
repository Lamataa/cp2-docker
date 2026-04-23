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
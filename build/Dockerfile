FROM python:3.9-alpine

WORKDIR /app

COPY ../app/source_code ../app/requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt \
    && chown -R nobody:nogroup /app

USER nobody

CMD ["python", "/app/server.py"]

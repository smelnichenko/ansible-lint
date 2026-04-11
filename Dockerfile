FROM python:3.13-slim
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir ansible-lint

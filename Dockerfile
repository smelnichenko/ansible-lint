FROM python:3.13-slim
# git: ops's unit tests drive its upgrade scripts' merges and tags in throwaway repositories
RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir ansible-lint hvac && \
    ansible-galaxy collection install \
        community.hashi_vault \
        community.general \
        kubernetes.core \
        gluster.gluster

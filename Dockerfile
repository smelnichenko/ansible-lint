FROM python:3.13-slim
# git: ops's unit tests drive its upgrade scripts' merges and tags in throwaway repositories; jq: the scripts some of
# them run (create-environment's seed of Vault) parse JSON with it
RUN apt-get update && apt-get install -y --no-install-recommends git jq && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir ansible-lint hvac && \
    ansible-galaxy collection install \
        ansible.posix \
        community.hashi_vault \
        community.general \
        kubernetes.core \
        gluster.gluster

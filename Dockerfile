FROM python:3.13-slim
# git: ops's unit tests drive its upgrade scripts' merges and tags in throwaway repositories; jq: the scripts some of
# them run (create-environment's seed of Vault) parse JSON with it; gnupg, file, curl: the apt-key-pinned test makes keys
# and checks a dearmored keyring, fetched as the task fetches it (deploy/ansible/playbooks/tasks/apt-key-pinned.yml);
# lua5.1: the Argo CD health checks (Lua, run by Argo's gopher-lua - Lua 5.1) evaluated as written in setup-argocd.yml
RUN apt-get update && apt-get install -y --no-install-recommends git jq gnupg file curl lua5.1 && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir ansible-lint hvac && \
    ansible-galaxy collection install \
        ansible.posix \
        community.hashi_vault \
        community.general \
        kubernetes.core \
        gluster.gluster

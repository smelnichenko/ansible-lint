# Every version pinned (2026-11-13): unpinned, a rebuild for one apt package took ansible-core 2.21.5 -> 2.22.0 and
# two of ops's unit harnesses failed on it. These are the versions the image held then (CI green on them); a move of
# any of them is its own change, run against ops's whole unit suite first.
FROM python:3.13-slim@sha256:8d9d0b8bcf6506481eae4907c18f5e3e7902e629f5f6d684f9e7c32e85e3ddf0
# git: ops's unit tests drive its upgrade scripts' merges and tags in throwaway repositories; jq: the scripts some of
# them run (create-environment's seed of Vault) parse JSON with it; gnupg, file, curl: the apt-key-pinned test makes keys
# and checks a dearmored keyring, fetched as the task fetches it (deploy/ansible/playbooks/tasks/apt-key-pinned.yml);
# lua5.1: the Argo CD health checks (Lua, run by Argo's gopher-lua - Lua 5.1) evaluated as written in setup-argocd.yml;
# ruby: ops's Vagrantfile loaded as Vagrant loads it (its host-memory guard hook, scripts/copy-host-guard.sh)
RUN apt-get update && apt-get install -y --no-install-recommends git jq gnupg file curl lua5.1 ruby && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir ansible-lint==26.9.0 ansible-compat==26.9.0 ansible-core==2.21.5 hvac==2.4.0 && \
    ansible-galaxy collection install -p /usr/share/ansible/collections \
        ansible.posix:==2.2.2 \
        community.hashi_vault:==7.1.0 \
        community.general:==13.5.0 \
        kubernetes.core:==6.6.0 \
        gluster.gluster:==1.0.2
# Readable by any user (plan 128, CI steps non-root): the collections in Ansible's system-wide path, not root's home
# (/root is 0700 - a non-root step found none); and a user of its own, uid 1000, so `id -un` names it and it has a
# home (ops's git-mirror harness skipped its real sync runs for a nameless uid). The image does not switch to it: each
# pipeline step sets its user (backend_options.kubernetes.securityContext)
RUN useradd --uid 1000 --user-group --create-home --shell /bin/bash ci


FROM python:3.13-slim
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir ansible-lint hvac && \
    ansible-galaxy collection install \
        community.hashi_vault \
        community.general \
        kubernetes.core \
        gluster.gluster

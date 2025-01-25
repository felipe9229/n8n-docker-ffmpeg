# Use a imagem oficial do n8n como base
FROM docker.n8n.io/n8nio/n8n

# Mude para o usuário root para instalar pacotes
USER root

# Instale o Docker CLI e ffmpeg
RUN apk update && \
    apk add --no-cache docker-cli ffmpeg

# Crie o grupo docker (se não existir) e adicione o usuário 'node' ao grupo
RUN addgroup -S docker && \
    adduser node docker

# Volte para o usuário padrão 'node'
USER node

#### `docker-compose.service`

[Unit]
Description=Docker Compose Service
After=network.target docker.service
Requires=docker.service

[Service]
Type=oneshot
User=root
WorkingDirectory=/path/to/your/n8n-docker-ffmpeg
ExecStart=/usr/bin/docker-compose build --no-cache
ExecStartPost=/usr/bin/docker-compose up -d
RemainAfterExit=true

[Install]
WantedBy=multi-user.target

FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY utils /utils
RUN mv /utils/command/docker /utils

# Install Node.js and cloudflared
RUN chmod +x /utils/*.sh
# RUN /utils/node.install.sh
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs
RUN /utils/cloudflared.install.sh

# Set tunnel configuration
RUN mkdir -p ~/.cloudflared
RUN mv /utils/tunnel.config.yaml ~/.cloudflared/config.yaml
RUN mv /utils/creds/tunnel.credentials.json ~/.cloudflared/tunnel.credentials.json
RUN mv /utils/creds/cert.pem ~/.cloudflared/cert.pem
ENV TUNNEL_ORIGIN_CERT=~/.cloudflared/cert.pem

# Get source code
COPY api /app/api
COPY front /app/front
COPY socket /app/socket

# Copy environment variables
COPY utils/creds/api /app/api/.dev.vars
COPY utils/creds/front /app/front/.dev.vars

# Install Node.js dependencies
# https://developers.cloudflare.com/workers/wrangler/commands/#types
WORKDIR /app/api
RUN npm install
RUN npx wrangler types -c wrangler.jsonc -c ../socket/wrangler.jsonc

WORKDIR /app/front
RUN npm install
RUN npx wrangler types -c wrangler.jsonc -c ../api/wrangler.jsonc

WORKDIR /app/socket
RUN npm install
RUN npx wrangler types -c wrangler.jsonc

# Database Initialization
RUN mkdir -p /database/
ENV DRIZZLE_OUT=/database
COPY utils/creds/database /app/api/.env
WORKDIR /app/api
RUN npx drizzle-kit generate --name=init
RUN npx wrangler d1 execute MAIN --local --file="./database/0000_init.sql"

# Move commands
COPY utils/run.sh /app/run.sh
COPY utils/run-tunnel.sh /app/run-tunnel.sh
COPY utils/end.sh /app/end.sh
RUN chmod +x /app/run.sh
RUN chmod +x /app/run-tunnel.sh
RUN chmod +x /app/end.sh

# Set wrangler secret
COPY utils/creds/cloudflare.sh /root/.bashrc

WORKDIR /app

# ENTRYPOINT [ "sh", "-c", "/app/run.sh & /app/run-tunnel.sh & wait" ]

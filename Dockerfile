FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY utils /utils

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
COPY utils/creds/api /app/api/dev.vars
COPY utils/creds/front /app/front/dev.vars

# Install Node.js dependencies
WORKDIR /app/api
RUN npm install

WORKDIR /app/front
RUN npm install

WORKDIR /app/socket
RUN npm install

# Database Initialization
RUN mkdir -p /database/
ENV DRIZZLE_OUT=/database
WORKDIR /app/api
RUN npx drizzle-kit generate --name=init
RUN npx wrangler d1 execute MAIN --local --file="/database/0000_init.sql"

# Move commands

COPY utils/run.sh /app/run.sh
COPY utils/run-tunnel.sh /app/run-tunnel.sh

WORKDIR /app
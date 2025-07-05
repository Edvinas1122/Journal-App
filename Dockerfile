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
RUN mkdir -p /root/.cloudflared
RUN mv /utils/tunnel.config.yaml /root/.cloudflared/config.yaml
RUN mv /utils/tunnel.credentials.json /root/.cloudflared/tunnel.credentials.json

# Get source code
COPY api /app/api
COPY front /app/front
COPY socket /app/socket

# Install Node.js dependencies
WORKDIR /app/api
RUN npm install

WORKDIR /app/front
RUN npm install

WORKDIR /app/socket
RUN npm install

WORKDIR /app
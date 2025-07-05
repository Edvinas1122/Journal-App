#!/bin/bash
# Install cloudflared on Ubuntu Jammy (22.04)
# https://pkg.cloudflare.com/index.html#ubuntu-jammy

# Add cloudflare gpg key
mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg -o /usr/share/keyrings/cloudflare-main.gpg

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' > /etc/apt/sources.list.d/cloudflared.list

# install cloudflared
apt-get update && apt-get install -y cloudflared
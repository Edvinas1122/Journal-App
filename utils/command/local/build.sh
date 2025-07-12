#!/bin/bash

# Builds the node instances on the host mashine

set -e

echo "📦 Installing dependencies..."

echo "▶️  API"
cd api
cp ../utils/creds/api .dev.vars
cp ../utils/creds/database .env
npm install
npx wrangler types -c wrangler.jsonc -c ../socket/wrangler.jsonc
npx drizzle-kit generate --name=init
npx wrangler d1 execute MAIN --local --file="./database/0000_init.sql"
cd ..

echo "▶️  FRONT"
cd front
cp ../utils/creds/front .dev.vars
npm install
npx wrangler types -c wrangler.jsonc -c ../api/wrangler.jsonc
cd ..

echo "▶️  SOCKET"
cd socket
npm install
npx wrangler types -c wrangler.jsonc
cd ..

bash utils/command/local/cloudflared.install.sh

echo "🔧 Setting up Cloudflared tunnel configuration..."

# Create the config directory
mkdir -p ~/.cloudflared

# Move or copy the necessary files
cp utils/tunnel.config.yaml ~/.cloudflared/config.yaml
cp utils/creds/tunnel.credentials.json ~/.cloudflared/tunnel.credentials.json
cp utils/creds/cert.pem ~/.cloudflared/cert.pem

# Export the environment variable (for current shell session)
export TUNNEL_ORIGIN_CERT="$HOME/.cloudflared/cert.pem"

echo "✅ Done!"

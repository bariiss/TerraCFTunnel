#!/usr/bin/env bash
set -euo pipefail

terraform init -input=false
terraform apply -auto-approve

CLOUDFLARED_CMD=$(terraform output -raw cloudflared_command)

CLOUDFLARED_ARGS=${CLOUDFLARED_CMD#cloudflared }

echo "🚀 Starting cloudflared tunnel as Docker daemon…"

docker rm -f cf-tunnel 2>/dev/null || true

docker run -d \
  --name cf-tunnel \
  --restart always \
  --network host \
  --cap-add NET_ADMIN \
  --cap-add NET_RAW \
  cloudflare/cloudflared:latest \
  ${CLOUDFLARED_ARGS}

echo "✅ cloudflared is up (container: cf-tunnel)"
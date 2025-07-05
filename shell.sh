#!/bin/bash
# filepath: /Users/imc/Documents/cloudflare/run-dev.sh

docker run -it --rm \
  -v api/src:/app/api/src \
  -v api/drizzle:/app/api/drizzle \
  -v front/src:/app/front/src  \
  -v socket/src:/app/socket/src \
  --name cloudflare-dev \
  ubuntu:22.04 \
  bash
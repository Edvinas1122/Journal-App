#!/bin/bash

docker run -it --rm \
  -p 8787:8787 \
  -v "$PWD/api/src:/app/api/src" \
  -v "$PWD/front/src:/app/front/src"  \
  -v "$PWD/socket/src:/app/socket/src" \
  --name cloudflare-dev \
  journal:dev \
  bash
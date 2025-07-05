#!/bin/bash

docker run -it --rm \
  -v "$PWD/api/src:/app/api/src" \
  -v "$PWD/api/drizzle:/app/api/drizzle" \
  -v "$PWD/front/src:/app/front/src"  \
  -v "$PWD/socket/src:/app/socket/src" \
  --name cloudflare-dev \
  journal:dev \
  bash
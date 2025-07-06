#!/bin/bash

# Start API
(cd /app/api && npm run dev &)

# Start Frontend
(cd /app/front && npm run dev &)

# Start Socket
(cd /app/socket && npm run dev &)

# Wait for all background jobs to finish
wait
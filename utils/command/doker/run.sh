#!/bin/bash

app_route=/app

# Start API
(cd $app_route/api && npm run dev &)

# Start Frontend
(cd $app_route/front && npm run dev &)

# Start Socket
(cd $app_route/socket && npm run dev &)

# Wait for all background jobs to finish
wait
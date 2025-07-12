#!/bin/bash

# Find PIDs of all processes named 'MainThread'
pids=$(ps | grep '[M]ainThread' | awk '{print $1}')

# If there are matching PIDs, kill them
if [ -n "$pids" ]; then
  echo "Killing MainThread processes: $pids"
  kill $pids
else
  echo "No MainThread processes found."
fi

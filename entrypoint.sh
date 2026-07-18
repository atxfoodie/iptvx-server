#!/bin/bash
set -e

# Detect the host system architecture
ARCH=$(uname -m)
echo "Starting IPTVX Media Server on architecture: $ARCH"

cd /app

# Dynamic execution fallback loop
if [ -d "./$ARCH" ] && [ -f "./$ARCH/iptvx-server" ]; then
    exec "./$ARCH/iptvx-server" --config /config
elif [ -f "./iptvx-server" ]; then
    exec "./iptvx-server" --config /config
elif [ -f "./start.sh" ]; then
    exec ./start.sh --config /config
else
    echo "ERROR: Could not locate a valid iptvx-server binary or startup script."
    exit 1
fi

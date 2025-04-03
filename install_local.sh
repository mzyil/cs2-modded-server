#!/usr/bin/env bash

# Load environment variables from.env file
if [ -f ".cs2env" ]; then
    source .cs2env
else
    echo "Error:.cs2env file not found. Please create a.env file with required variables."
    exit 1
fi

# Check bare minimum dependencies
# Check if curl is installed
if! command -v curl &> /dev/null
then
    echo "Warning: curl is not installed. Please install it to continue. sudo apt update && sudo apt install curl"
    exit 1
fi

# Set environment variables with default values if not set in.env file
export RCON_PASSWORD="${RCON_PASSWORD:-changeme}"
export API_KEY="${API_KEY:-changeme}"
export STEAM_ACCOUNT="${STEAM_ACCOUNT:-}"
export MOD_BRANCH="${MOD_BRANCH:-master}"
export SERVER_PASSWORD="${SERVER_PASSWORD:-}"
export PORT="${PORT:-27015}"
export TICKRATE="${TICKRATE:-128}"
export MAXPLAYERS="${MAXPLAYERS:-32}"
export LAN="${LAN:-0}"
export EXEC="${EXEC:-on_boot.cfg}"
export DUCK_DOMAIN="${DUCK_DOMAIN:-}"
export DUCK_TOKEN="${DUCK_TOKEN:-}"
export CUSTOM_FOLDER="${CUSTOM_FOLDER:-}"

cd /

# Download latest installer
curl -s -H "Cache-Control: no-cache" -o "install.sh" "https://raw.githubusercontent.com/mzyil/cs2-modded-server/${MOD_BRANCH}/install.sh" && chmod +x install.sh

# Run
bash install.sh |& tee /install.log
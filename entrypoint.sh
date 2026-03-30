#!/bin/bash
set -e

# 1. Download Velocity
if [ ! -f "velocity.jar" ]; then
    echo "Downloading Velocity 3.5.0 SNAPSHOT..."
    curl -Lo velocity.jar "https://fill-data.papermc.io/v1/objects/4334a3577a4c6daac264d1ff3be73d27ec1f4f9b3339af683bdcf3099f66402b/velocity-3.5.0-SNAPSHOT-584.jar"
fi

# 2. Ensure plugins folder exists
mkdir -p plugins

# 3. Download EaglerXServer plugin
if [ ! -f "plugins/EaglerXServer.jar" ]; then
    echo "Downloading EaglerXServer..."
    curl -Lo plugins/EaglerXServer.jar "https://release-assets.githubusercontent.com/github-production-release-asset/901524674/67366b4a-04dc-4685-8926-2d06b903e644?sp=r&sv=2018-11-09&sr=b&spr=https&se=2026-03-30T21%3A24%3A19Z&rscd=attachment%3B+filename%3DEaglerXServer.jar&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2026-03-30T20%3A23%3A42Z&ske=2026-03-30T21%3A24%3A19Z&sks=b&skv=2018-11-09&sig=XVZWgueRkOn4RATGWvuqjfnwYUtAILV8DzU%2BlX0L6W8%3D&jwt=eyJ0eXAiOiJKV1Qi..."
fi

# 4. Set backend server from environment variable
if [ -z "$SERVER" ]; then
    echo "ERROR: SERVER environment variable not set!"
    exit 1
fi
echo "Setting backend server to $SERVER"
sed -i "s|ATERNOS_PUBLIC_IP:PORT|$SERVER|g" velocity.toml

# 5. Start Velocity
echo "Starting Velocity proxy..."
java -Xmx1G -jar velocity.jar

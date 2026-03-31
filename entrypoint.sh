#!/bin/sh

echo "Starting setup..."

# Create plugins folder
mkdir -p plugins

# Download Velocity
echo "Downloading Velocity..."
curl -L -o velocity.jar https://fill-data.papermc.io/v1/objects/4334a3577a4c6daac264d1ff3be73d27ec1f4f9b3339af683bdcf3099f66402b/velocity-3.5.0-SNAPSHOT-584.jar

# Download EaglerXServer
echo "Downloading EaglerXServer..."
curl -L -o plugins/EaglerXServer.jar https://edge.forgecdn.net/files/7205/709/EaglerXServer.jar

# Download Via plugins (your versions)
echo "Downloading ViaVersion..."
curl -L -o plugins/ViaVersion.jar https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.8.1/PAPER/ViaVersion-5.8.1.jar

echo "Downloading ViaBackwards..."
curl -L -o plugins/ViaBackwards.jar https://hangarcdn.papermc.io/plugins/ViaVersion/ViaBackwards/versions/5.8.1/PAPER/ViaBackwards-5.8.1.jar

echo "Downloading ViaRewind..."
curl -L -o plugins/ViaRewind.jar https://hangarcdn.papermc.io/plugins/ViaVersion/ViaRewind/versions/4.0.15/PAPER/ViaRewind-4.0.15.jar

# Fix Velocity bind port for Render (CRITICAL FIX)
echo "Configuring bind port to $PORT..."
sed -i "s|bind = \"0.0.0.0:.*\"|bind = \"0.0.0.0:$PORT\"|" velocity.toml

# Debug info
echo "===== DEBUG INFO ====="
echo "PORT is: $PORT"

echo "Root files:"
ls -lh

echo "Plugins folder:"
ls -lh plugins/

echo "Velocity config:"
cat velocity.toml
echo "======================"

# Start Velocity
echo "Starting Velocity..."
java -Xms512M -Xmx512M -jar velocity.jar

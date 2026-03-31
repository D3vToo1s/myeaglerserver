#!/bin/sh

echo "Starting setup..."

# Create plugins folder
mkdir -p plugins

# Download Velocity
echo "Downloading Velocity..."
curl -L -o velocity.jar https://fill-data.papermc.io/v1/objects/4334a3577a4c6daac264d1ff3be73d27ec1f4f9b3339af683bdcf3099f66402b/velocity-3.5.0-SNAPSHOT-584.jar

# Download EaglerXServer (correct direct jar)
echo "Downloading EaglerXServer..."
curl -L -o plugins/EaglerXServer.jar https://edge.forgecdn.net/files/7205/709/EaglerXServer.jar

# (Optional test) Via plugins on Velocity
echo "Downloading ViaVersion..."
curl -L -o plugins/ViaVersion.jar https://github.com/ViaVersion/ViaVersion/releases/latest/download/ViaVersion-Velocity.jar

echo "Downloading ViaBackwards..."
curl -L -o plugins/ViaBackwards.jar https://github.com/ViaVersion/ViaBackwards/releases/latest/download/ViaBackwards-Velocity.jar

echo "Downloading ViaRewind..."
curl -L -o plugins/ViaRewind.jar https://github.com/ViaVersion/ViaRewind/releases/latest/download/ViaRewind-Velocity.jar

# Fix port for Render (CRITICAL)
echo "Configuring port to $PORT..."
sed -i "s/port = .*/port = $PORT/" velocity.toml

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

# Start server
echo "Starting Velocity..."
java -Xms512M -Xmx512M -jar velocity.jar

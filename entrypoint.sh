#!/bin/sh

echo "Starting setup..."

# Download Velocity
echo "Downloading Velocity..."
curl -L -o velocity.jar https://fill-data.papermc.io/v1/objects/4334a3577a4c6daac264d1ff3be73d27ec1f4f9b3339af683bdcf3099f66402b/velocity-3.5.0-SNAPSHOT-584.jar

# Download EaglerXServer (REAL jar, not HTML)
echo "Downloading EaglerXServer..."
curl -L -o plugins/EaglerXServer.jar https://edge.forgecdn.net/files/7205/709/EaglerXServer.jar

# Replace port with Render's PORT
echo "Configuring port..."
sed -i "s/port = .*/port = $PORT/" velocity.toml

# Debug check
echo "Files:"
ls -lh
ls -lh plugins/

echo "Starting Velocity..."
java -Xms512M -Xmx512M -jar velocity.jar

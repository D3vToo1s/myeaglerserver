#!/bin/bash
set -e

echo "Bootstrapping Eaglercraft proxy..."

SERVER_DIR="/server"
PLUGINS_DIR="$SERVER_DIR/plugins"
CONFIG_DIR="/app/config"

mkdir -p "$PLUGINS_DIR"
cd "$SERVER_DIR"

# ===== COPY CORE CONFIGS (BEFORE FIRST RUN) =====
cp "$CONFIG_DIR/velocity.toml" .
cp "$CONFIG_DIR/forwarding.secret" .

# ===== DOWNLOAD VELOCITY =====
if [ ! -f velocity.jar ]; then
  echo "Downloading Velocity..."
  curl -o velocity.jar "https://fill-data.papermc.io/v1/objects/d9f6feb5b257d3f8d889978d55d0cfdc2f5fa3d01240dc7cd495d74fbb75cd8d/velocity-3.5.0-SNAPSHOT-585.jar"
fi

# ===== DOWNLOAD PLUGINS =====
cd "$PLUGINS_DIR"

curl -o EaglerXServer.jar "https://mediafilez.forgecdn.net/files/7205/709/EaglerXServer.jar"
curl -o ViaVersion.jar "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.8.1/PAPER/ViaVersion-5.8.1.jar"
curl -o ViaBackwards.jar "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaBackwards/versions/5.8.1/PAPER/ViaBackwards-5.8.1.jar"
curl -o ViaRewind.jar "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaRewind/versions/4.0.15/PAPER/ViaRewind-4.0.15.jar"

cd "$SERVER_DIR"

# ===== FIRST RUN (GENERATE PLUGIN CONFIG FOLDERS) =====
echo "Running first startup..."
java -jar velocity.jar &
PID=$!

# Wait until Eagler folder exists
echo "Waiting for plugin folders..."
until [ -d "$PLUGINS_DIR/EaglerXServer" ]; do
  sleep 1
done

kill $PID || true
sleep 2

# ===== COPY EAGLER CONFIG =====
echo "Applying Eagler config..."
cp "$CONFIG_DIR/listeners.yml" "$PLUGINS_DIR/EaglerXServer/"

# ===== START SERVER =====
echo "Starting Velocity..."
exec java -Xms512M -Xmx1024M -jar velocity.jar

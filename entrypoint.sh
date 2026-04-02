#!/bin/sh

echo "Starting setup..."

mkdir -p plugins

# ----------------------------
# OPEN PORT EARLY (RENDER FIX)
# ----------------------------
echo "Opening port early for Render..."
python3 -m http.server $PORT >/dev/null 2>&1 &
SERVER_PID=$!

# ----------------------------
# Download Velocity
# ----------------------------
echo "Downloading Velocity..."
curl -L -o velocity.jar https://fill-data.papermc.io/v1/objects/4334a3577a4c6daac264d1ff3be73d27ec1f4f9b3339af683bdcf3099f66402b/velocity-3.5.0-SNAPSHOT-584.jar

# ----------------------------
# Download plugins
# ----------------------------
echo "Downloading plugins..."
curl -L -o plugins/EaglerXServer.jar https://edge.forgecdn.net/files/7205/709/EaglerXServer.jar
curl -L -o plugins/ViaVersion.jar https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.8.1/PAPER/ViaVersion-5.8.1.jar
curl -L -o plugins/ViaBackwards.jar https://hangarcdn.papermc.io/plugins/ViaVersion/ViaBackwards/versions/5.8.1/PAPER/ViaBackwards-5.8.1.jar
curl -L -o plugins/ViaRewind.jar https://hangarcdn.papermc.io/plugins/ViaVersion/ViaRewind/versions/4.0.15/PAPER/ViaRewind-4.0.15.jar

# ----------------------------
# Create velocity config (fresh)
# ----------------------------
echo "Creating velocity.toml..."
cat <<EOF > velocity.toml
config-version = "2.7"
bind = "0.0.0.0:$PORT"
motd = "A Velocity Server"
show-max-players = 100

online-mode = false
force-key-authentication = false

player-info-forwarding-mode = "none"

[servers]
lobby = "ALobby.aternos.me:43482"
lifesteal = "ALifestealServer.aternos.me:25850"
survival = "ACoolSurvivalServer.aternos.me:42361"

try = ["lobby"]
EOF

# ----------------------------
# Stop temporary server
# ----------------------------
echo "Stopping temporary server..."
kill $SERVER_PID
sleep 2

# ----------------------------
# Start Velocity
# ----------------------------
echo "Starting Velocity..."
exec java -Xms512M -Xmx512M -jar velocity.jar

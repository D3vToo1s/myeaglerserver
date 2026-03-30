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
    curl -Lo plugins/EaglerXServer.jar "YOUR_REAL_URL_HERE"
fi

# 4. Validate backend env
if [ -z "$SERVER" ]; then
    echo "ERROR: SERVER environment variable not set!"
    exit 1
fi

echo "Using backend: $SERVER"

# 5. Generate clean velocity.toml (NO sed)
cat > velocity.toml <<EOF
[servers]
paper_backend = "$SERVER"

[fallback]
server = "paper_backend"

[bind]
host = "0.0.0.0"
port = 25565

[forwarding]
mode = "MODERN"
secret-file = "forwarding.secret"

[players]
online-mode = true
EOF

# 6. Ensure forwarding secret exists
if [ ! -f "forwarding.secret" ]; then
    echo "supersecretkey123" > forwarding.secret
fi

# 7. Start Velocity
echo "Starting Velocity proxy..."
java -Xmx1G -jar velocity.jar

#!/bin/sh

echo "Downloading Velocity..."
curl -o velocity.jar https://fill-data.papermc.io/v1/objects/4334a3577a4c6daac264d1ff3be73d27ec1f4f9b3339af683bdcf3099f66402b/velocity-3.5.0-SNAPSHOT-584.jar

echo "Downloading EaglerXServer..."
curl -o plugins/EaglerXServer.jar https://example.com/EaglerXServer.jar

echo "Starting Velocity..."
java -Xms512M -Xmx512M -jar velocity.jar

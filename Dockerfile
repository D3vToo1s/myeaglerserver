
# Dockerfile
FROM openjdk:17-jdk-slim

WORKDIR /minecraft

# Install curl for downloading files
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy configuration templates and entrypoint
COPY config/velocity.toml ./velocity.toml
COPY config/listeners.yml ./listeners.yml
COPY entrypoint.sh ./entrypoint.sh

# Make entrypoint executable
RUN chmod +x entrypoint.sh

# Expose ports
EXPOSE 25565   # Java
EXPOSE 8080    # Eaglercraft
EXPOSE 19132/udp  # Bedrock default
EXPOSE 19133/udp  # Bedrock optional

# Run entrypoint
ENTRYPOINT ["./entrypoint.sh"]

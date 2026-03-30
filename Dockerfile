# Use Eclipse Temurin 17 JDK
FROM eclipse-temurin:17-jdk

WORKDIR /minecraft

# Install curl for downloading files
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy configuration and entrypoint
COPY config/velocity.toml ./velocity.toml
COPY config/listeners.yml ./listeners.yml
COPY entrypoint.sh ./entrypoint.sh

# Make entrypoint executable
RUN chmod +x entrypoint.sh

# Expose only Eaglercraft port
EXPOSE 8080

# Start the proxy
ENTRYPOINT ["./entrypoint.sh"]

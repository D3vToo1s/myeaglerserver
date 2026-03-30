FROM eclipse-temurin:21-jre

WORKDIR /app

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create plugins folder
RUN mkdir -p plugins

# Copy ALL config files
COPY config/ ./
COPY entrypoint.sh ./

RUN chmod +x entrypoint.sh

# Render uses dynamic port
EXPOSE 10000

CMD ["./entrypoint.sh"]

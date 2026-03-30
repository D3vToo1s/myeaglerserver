# Use Eclipse Temurin 21 JDK
FROM eclipse-temurin:21-jdk

WORKDIR /minecraft

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY config/velocity.toml ./velocity.toml
COPY config/listeners.yml ./listeners.yml
COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x entrypoint.sh

# Only Eaglercraft port
EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]

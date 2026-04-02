FROM eclipse-temurin:21-jre

WORKDIR /app

RUN apt-get update && apt-get install -y curl python3 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh ./

RUN chmod +x entrypoint.sh

EXPOSE 25565

CMD ["./entrypoint.sh"]

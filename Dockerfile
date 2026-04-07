FROM eclipse-temurin:21-jre

WORKDIR /app

COPY config ./config
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 25577

CMD ["./entrypoint.sh"]

FROM eclipse-temurin:17
WORKDIR /app
COPY . .
CMD ["java", "-jar", "EaglerXServer.jar"]

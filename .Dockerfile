# Build stage
FROM gradle:8.7-jdk17 AS build
WORKDIR /app
COPY . .
RUN gradle build -x test

# Run stage
FROM openjdk:17-jdk-slim
COPY --from=build /app/build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
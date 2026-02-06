# Stage 1: Build the project with Java 25
FROM eclipse-temurin:25-jdk-jammy AS build

WORKDIR /app

# Copy Gradle wrapper and build files
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle .
COPY settings.gradle .

# Copy source code
COPY src ./src

# Make gradlew executable
RUN chmod +x ./gradlew

# Build the project (skip tests)
RUN ./gradlew build -x test

# Stage 2: Run the app with Java 25
FROM eclipse-temurin:25-jdk-jammy

WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose default Spring Boot port
EXPOSE 8080

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]

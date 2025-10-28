# Build Stage
FROM eclipse-temurin:21-jdk-jammy AS build
WORKDIR /app

# Copy Maven wrapper and pom.xml first to leverage caching
COPY pom.xml .
COPY mvnw .
COPY .mvn ./.mvn

# Make mvnw executable and download dependencies
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copy source code
COPY src ./src

# Package application (skip tests for faster build)
RUN ./mvnw package -DskipTests -B

# Runtime Stage
FROM eclipse-temurin:21-jre-jammy AS runtime
WORKDIR /app

# Copy built JAR
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

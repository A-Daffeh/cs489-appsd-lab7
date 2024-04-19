# Use the official Gradle image as a base image
FROM gradle:8.7.0-jdk21 AS build
# Set the working directory inside the container
WORKDIR /app
# Copy only necessary Gradle build files for dependency resolution
COPY build.gradle .
COPY settings.gradle .
COPY gradlew .
COPY gradle ./gradle
# Resolve dependencies
RUN gradle --no-daemon dependencies
# Copy the application source code
COPY . .
# Build the application without running tests
RUN gradle --no-daemon clean build -x test

# Start a new stage to create a lightweight JDK image for running the application
FROM openjdk:21
# Set the working directory inside the container
WORKDIR /app
# Copy the built artifact from the 'build' stage
COPY --from=build /app/build/libs/*.jar app.jar
# Command to run the application
CMD ["java", "-jar", "app.jar"]

# Dockerfile first copies the necessary Gradle build files and resolves dependencies,
# then copies the entire application source code and builds the application.
# Finally, it creates a  JDK image for running the application and copies the built artifact into it.
# Use an official OpenJDK runtime as the base image
FROM openjdk:8-jdk-alpine

# Set the working directory within the container
WORKDIR /app

# Copy the Maven executable to the image
COPY mvnw .
COPY .mvn .mvn

# Copy the pom.xml file
COPY pom.xml .

# Make Maven wrapper executable
RUN chmod +x mvnw

# Download dependencies and create layer
RUN ./mvnw dependency:go-offline -B

# Copy project source code
COPY src src

# Build the application
RUN ./mvnw package -DskipTests

# Specify the command to run the application
CMD ["java", "-jar", "target/course-api-0.0.1-SNAPSHOT.jar"]

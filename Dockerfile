# ---- Stage 1 -------

# Pull the base image so that we can use maven to build jar files
FROM maven:3.8.3-openjdk-17 AS builder

# Working directory where your code and jar file will be stored
WORKDIR /app

# Copying all the code from host to container
COPY . /app

# Build the app to generate jar file
RUN mvn clean install -DskipTests=true


# ----- Stage 2 ----

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/bankapp.jar


# Expose the port so that the port can be mapped with the host
EXPOSE 8080

# Execute the JAR file using java command and -jar flar (to specify we are executing a jar file)
ENTRYPOINT ["java","-jar","/app/target/bankapp.jar"]



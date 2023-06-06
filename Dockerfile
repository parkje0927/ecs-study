#FROM openjdk:17-jdk-slim-buster
#ARG JAR_FILE=build/libs/*.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]
#WORKDIR /app


FROM azul/zulu-openjdk:17 as builder
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +X ./gradlew
RUN ./gradlew bootJar

FROM azul/zulu-openjdk:17 as runtime
COPY --from=builder build/libs/*.jar app.jar

EXPOSE 8085
ENTRYPOINT ["java", "-jar", "/app.jar"]
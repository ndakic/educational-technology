FROM maven:3.6.3-jdk-8
LABEL MAINTAINER="daka"
COPY ./ elearning-server
WORKDIR /elearning-server
RUN mvn package -DskipTests
EXPOSE 9000
ENTRYPOINT ["java", "-jar", "target/elearning-server-0.0.1-SNAPSHOT.jar"]
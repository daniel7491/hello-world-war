FROM maven:3.8.4-openjdk-11 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package

FROM tomcat:9.0

COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/

EXPOSE 8082

ENTRYPOINT ["catalina.sh", "run"]

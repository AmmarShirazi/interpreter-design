FROM maven:3.8.5-openjdk-18 as builder

COPY ./src /usr/src/app/src
COPY ./pom.xml /usr/src/app

WORKDIR /usr/src/app

RUN mvn clean package

FROM openjdk:18

COPY --from=builder /usr/src/app/target/*.jar /usr/app/interpreter-app.jar

WORKDIR /usr/app

VOLUME [ "/usr/app/scripts" ]

CMD ["java", "-cp", "interpreter-app.jar", "com.ammar.lox.Lox"]

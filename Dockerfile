FROM gradle:8.10.2-jdk8-focal AS build
COPY --chown=gradle:gradle . /home/gradle/src
RUN git clone https://github.com/imperva/automatic-api-attack-tool.git /home/automatic-api-attack-tool
WORKDIR /home/automatic-api-attack-tool
RUN ./gradlew build

FROM openjdk:8-jre-slim
COPY --from=build /home/automatic-api-attack-tool /automatic-api-attack-tool
WORKDIR /automatic-api-attack-tool
COPY build/libs/imperva-api-attack-tool.jar /automatic-api-attack-tool/
COPY src/main/resources/runnable.sh /automatic-api-attack-tool/
RUN cat runnable.sh imperva-api-attack-tool.jar > api-attack.sh && chmod +x api-attack.sh
CMD [ "/bin/bash" ]

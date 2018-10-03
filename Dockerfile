FROM openjdk:12-alpine

COPY ./build/install/helloCI /helloCI

RUN apk add --no-cache bash

EXPOSE 80 4567/tcp

ENTRYPOINT ["/helloCI/bin/helloCI"]

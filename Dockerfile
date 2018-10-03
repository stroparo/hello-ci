FROM openjdk:12-alpine

EXPOSE 80 4567/tcp

RUN apk add --no-cache bash

COPY ./build/install/helloCI /helloCI

ENTRYPOINT ["/helloCI/bin/helloCI"]

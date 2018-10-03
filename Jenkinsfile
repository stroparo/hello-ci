#!/usr/bin/env groovy

container_name = 'helloci'
container_image_name = 'stroparo/hello-ci'
docker_host_port = 80
docker_container_port = 4567

pipeline {

    agent none

    options {
        buildDiscarder(
            logRotator(
                numToKeepStr: '10',
            )
        )
    }

    environment {
        POD_NAME = 'some_pod' // TODO
    }

    stages {

        stage('Build hello-ci app into a container') {
            agent any
            steps {
                cleanWs()
                checkout scm
                sh './gradlew build'
                sh 'pwd ; ls -l; echo ; echo Searching... ; echo ; find . -type d -name install'
                sh 'docker build -f Dockerfile -t stroparo/hello-ci .'
            }
        }

        stage('Deploy docker container') {
            agent any
            steps {
                echo "Using Docker image '${container_image_name}'"
                echo "Removing running instances"

                // TODO Refactor this to handle it efficiently

                sh "docker stop ${container_name} || true"
                sh "docker rm ${container_name} || true"
                sh "!(docker ps | grep -q ${container_name})"
                sh "docker run -d --name ${container_name} -p ${docker_host_port}:${docker_container_port} ${container_image_name}"
            }
        }

    }
}


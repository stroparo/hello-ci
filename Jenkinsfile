#!/usr/bin/env groovy

project_name = 'helloci'
container_image_name = 'stroparo/hello-ci'
docker_host_port = 8000
docker_container_port = 4321

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

        stage("Build app") {
            agent any
            steps {
                cleanWs()
                checkout scm
                sh './gradlew build installDist'
            }
        }

        stage('Build container') {
            agent any
            steps {
                sh "docker build -f Dockerfile -t ${container_image_name} ."
            }
        }

        stage('Deploy docker container') {
            agent any
            steps {
                echo "Using Docker image '${container_image_name}'"
                echo "Removing running instances"

                sh "docker stop ${project_name} || true"
                sh "docker rm ${project_name} || true"
                sh "!(docker ps | grep -q ${project_name})"
                sh "docker run -d --name ${project_name} -p ${docker_host_port}:${docker_container_port} ${container_image_name}"
            }
        }

    }
}


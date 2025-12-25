pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "azamatbekimov/cicd-pipeline"
        DOCKER_CREDENTIALS_ID = "docker_hub_creds_id"
    }

    stages {

        stage('Git Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Application Build') {
            steps {
                sh 'chmod +x scripts/build.sh'
                sh './scripts/build.sh'
            }
        }

        stage('Tests') {
            steps {
                sh 'chmod +x scripts/test.sh'
                sh './scripts/test.sh'
            }
        }

        stage('Docker Image Build') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                sh "docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest"
            }
        }

        stage('Docker Image Push') {
            steps {
                withDockerRegistry(
                    credentialsId: "${DOCKER_CREDENTIALS_ID}",
                    url: 'https://index.docker.io/v1/'
                ) {
                    sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }
    }
}

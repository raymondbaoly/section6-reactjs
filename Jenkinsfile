pipeline {
    agent any

    environment {
        REGISTRY_IMAGE = 'raymondbaoly/section6-reactjs'
        DOCKERFILE_PATH = 'Dockerfile'

    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh 'docker build -t ${REGISTRY_IMAGE}:prod -f ${DOCKERFILE_PATH} .'
                }
            }
        }
        stage('SonarQube - SAST') {
            steps {
                withSonarQubeEnv('section6') {
                    sh 'sonar-scanner -Dsonar.projectKey=section6-nodejs -Dsonar.sources=. -Dsonar.language=ts'
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    sh "docker push ${REGISTRY_IMAGE}:prod"
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh "kubectl -n default rollout restart deployment/section6-reactjs"
                }
            }
        }

    }

}

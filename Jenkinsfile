pipeline {

    agent any

    stages {

        stage('Git Checkout') {

            steps {

                checkout scm

            }

        }


        stage('Python Test') {

            steps {

                sh '''
                cd backend
                pip install -r requirements.txt
                pytest
                '''

            }

        }


        stage('SonarQube') {

            steps {

                echo 'Running SonarQube analysis'

                sh '''
                sonar-scanner \
                -Dsonar.projectKey=event-ticket \
                -Dsonar.sources=backend
                '''

            }

        }


        stage('Docker Build') {

            steps {

                sh '''
                docker compose build
                '''

            }

        }


        stage('Deploy') {

            steps {

                sh '''
                docker compose down
                docker compose up -d
                '''

            }

        }

    }


    post {

        success {

            echo 'Event Ticket Application deployed successfully'

        }

        failure {

            echo 'Pipeline failed'

        }

    }

}

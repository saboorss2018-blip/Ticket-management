pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }

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

                    python3 -m venv testenv

                    testenv/bin/pip install --upgrade pip

                    testenv/bin/pip install -r requirements.txt

                    testenv/bin/pytest -v
                '''
            }
        }

        stage('SonarQube') {
            steps {
                echo 'Running SonarQube analysis'

                withCredentials([
                    string(
                        credentialsId: 'SONAR_TOKEN',
                        variable: 'SONAR_TOKEN'
                    )
                ]) {
                    sh '''
                        /opt/sonar-scanner/bin/sonar-scanner \
                        -Dsonar.projectKey=event-ticket \
                        -Dsonar.organization=YOUR_ORGANIZATION_KEY \
                        -Dsonar.sources=backend \
                        -Dsonar.token="$SONAR_TOKEN"
                    '''
                }
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

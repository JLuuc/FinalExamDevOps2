pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/JLuuc/FinalExamDevOps2.git'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Deploy to Testing') {
            steps {
                echo '🚀 Deploying to Testing environment...'
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'testing-env',
                            transfers: [
                                sshTransfer(
                                    sourceFiles: 'index.html, js.js, style.css',
                                    removePrefix: '',
                                    remoteDirectory: '/var/www/html',
                                    cleanRemote: true
                                )
                            ],
                            verbose: true
                        )
                    ]
                )
            }
        }

        stage('Run Selenium Tests') {
            steps {
                echo '🧪 Running Selenium Tests (placeholder)'
            }
        }

        stage('Deploy to Production') {
            steps {
                echo '🚀 Deploying to Production instances...'
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'prod-env-1',
                            transfers: [
                                sshTransfer(
                                    sourceFiles: 'index.html, js.js, style.css',
                                    removePrefix: '',
                                    remoteDirectory: '/var/www/html',
                                    cleanRemote: true
                                )
                            ],
                            verbose: true
                        ),
                        sshPublisherDesc(
                            configName: 'prod-env-2',
                            transfers: [
                                sshTransfer(
                                    sourceFiles: 'index.html, js.js, style.css',
                                    removePrefix: '',
                                    remoteDirectory: '/var/www/html',
                                    cleanRemote: true
                                )
                            ],
                            verbose: true
                        )
                    ]
                )
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
    }
}


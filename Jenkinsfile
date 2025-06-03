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
                                    remoteDirectory: '',
                                    execCommand: ''
                                )
                            ],
                            usePromotionTimestamp: false,
                            verbose: true
                        )
                    ]
                )
            }
        }

        stage('Run Selenium Tests') {
            steps {
                echo '🧪 Running Selenium tests...'
                dir('selenium-tests/test') {
                    sh 'node ticTacToe.test.js'
                }
            }
        }

        stage('Deploy to Staging') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                echo '🚧 Deploying to Staging environment...'
                // Add sshPublisher config for staging-env here
            }
        }

        stage('Deploy to Production') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                echo '🚀 Deploying to Production environment...'
                // Add sshPublisher configs for prod1-env and prod2-env here
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


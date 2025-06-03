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
                            transfers: [sshTransfer(sourceFiles: 'index.html, js.js, style.css', remoteDirectory: '/var/www/html/')],
                            usePromotionTimestamp: false,
                            verbose: true
                        )
                    ]
                )
            }
        }

        stage('Run Selenium Tests') {
            steps {
                echo '🧪 Running Selenium Tests (placeholder)'
                // Add command/script to run the Selenium test here
            }
        }

        stage('Deploy to Staging') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                echo '🚧 (TODO) Deploy to Staging environment...'
                // Add staging-env sshPublisher here when ready
            }
        }

        stage('Deploy to Production') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                echo '🚀 Deploying to ProductionEnv1 and ProductionEnv2...'
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'prod-env-1',
                            transfers: [sshTransfer(sourceFiles: 'index.html, js.js, style.css', remoteDirectory: '/var/www/html/')],
                            usePromotionTimestamp: false,
                            verbose: true
                        ),
                        sshPublisherDesc(
                            configName: 'prod-env-2',
                            transfers: [sshTransfer(sourceFiles: 'index.html, js.js, style.css', remoteDirectory: '/var/www/html/')],
                            usePromotionTimestamp: false,
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


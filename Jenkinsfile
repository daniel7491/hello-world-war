pipeline {
    agent any

    environment {
        MAVEN_HOME = tool name: 'Maven', type: 'hudson.tasks.Maven$MavenInstallation'
        SONARQUBE = 'b4424b63-b1c0-4dda-a4c8-c519021f4226' // Name of your SonarQube server configuration in Jenkins
        DOCKER_CREDENTIALS_ID = 'docker-credentials' // ID of your Docker credentials in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/lidorg-dev/hello-world-war'
            }
        }

        stage('Build Maven WAR') {
            steps {
                script {
                    sh "${MAVEN_HOME}/bin/mvn clean package"
                }
            }
        }

        stage('Run SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv(SONARQUBE) {
                        sh "${MAVEN_HOME}/bin/mvn sonar:sonar"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def image = docker.build("myrepo/hello-world-war:${env.BUILD_ID}")
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    def image = docker.build("myrepo/hello-world-war:${env.BUILD_ID}")
                    docker.withRegistry('', DOCKER_CREDENTIALS_ID) {
                        image.push("${env.BUILD_ID}")
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

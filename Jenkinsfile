pipeline {
    agent any
    
    environment {
        MONGO_INITDB_ROOT_USERNAME = 'root'
        MONGO_INITDB_ROOT_PASSWORD = 'example'
        CONTAINER_ID = ''
    }
    
    stages {
        stage('Start MongoDB') {
            steps {
                script {
                    // Запуск контейнера MongoDB
                    CONTAINER_ID = sh(returnStdout: true, script: "docker run -d -e MONGO_INITDB_ROOT_USERNAME=${env.MONGO_INITDB_ROOT_USERNAME} -e MONGO_INITDB_ROOT_PASSWORD=${env.MONGO_INITDB_ROOT_PASSWORD} -p 27017:27017 mongo").trim()
                }
            }
        }
        
        stage('Start Mongo Express') {
            steps {
                script {
                    docker.image('mongo-express')
                        .withRun("-e ME_CONFIG_MONGODB_ADMINUSERNAME=${env.MONGO_INITDB_ROOT_USERNAME} -e ME_CONFIG_MONGODB_ADMINPASSWORD=${env.MONGO_INITDB_ROOT_PASSWORD} -e ME_CONFIG_MONGODB_URL=mongodb://${env.MONGO_INITDB_ROOT_USERNAME}:${env.MONGO_INITDB_ROOT_PASSWORD}@mongo:27017/ -p 8081:8081 --restart always") { c ->
                            // Wait for Mongo Express to start
                            sh 'sleep 10'
                        }
                }
            }
        }
        
        stage('Stop and Remove Container') {
            steps {
                script {
                    // Зупинка та видалення контейнера MongoDB
                    if (env.CONTAINER_ID) {
                        sh "docker stop ${env.CONTAINER_ID}"
                        sh "docker rm -f --volumes ${env.CONTAINER_ID}"
                    }
                }
            }
        }
    }
}



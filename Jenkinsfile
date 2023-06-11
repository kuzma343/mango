pipeline {
    agent any
    
    environment {
        MONGO_INITDB_ROOT_USERNAME = 'root'
        MONGO_INITDB_ROOT_PASSWORD = 'example'
    }
    
    stages {
        stage('Start MongoDB') {
            steps {
                script {
                    docker.image('mongo')
                        .withRun("-e MONGO_INITDB_ROOT_USERNAME=${env.MONGO_INITDB_ROOT_USERNAME} -e MONGO_INITDB_ROOT_PASSWORD=${env.MONGO_INITDB_ROOT_PASSWORD} -p 27017:27017 --restart always") { c ->
                            // Wait for MongoDB to start
                            sh 'sleep 10'
                        }
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
    }
}


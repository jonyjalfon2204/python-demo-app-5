pipeline {
    agent {label 'builder'}
    environment {
        DOCKER_BUILDKIT = 1
    }
    stages {
        stage('Build'){
          steps{
            container('dind'){
              sh  'docker build -t jonyjalfon94/python-demo-app-5:$BUILD_NUMBER .'
            }
          }
        }
        stage("Push image to DockerHub"){
            steps{
                container('dind'){
                    withCredentials([usernamePassword(credentialsId: 'test-creds-dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                        sh 'docker push jonyjalfon94/python-demo-app-5:$BUILD_NUMBER'
                    }
                }
            }
        }
    }
}

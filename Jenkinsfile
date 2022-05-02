pipeline {
    agent any
    stages {
         stage('Clone repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }

        stage('Build') { 
            steps { 
                script{
                 dockerImage = docker.build("pthakkar/mkdocs:latest")
                }
            }
        }

        stage('Prodcue'){
            steps {
                 echo 'Empty'
            }
        }
        stage('Serve') {
            steps {
                echo 'Empty'
            }
        }
    }
}
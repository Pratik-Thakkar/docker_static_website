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

        stage('Build docker image') { 
            steps { 
                script{
                 dockerImage = docker.build("pthakkar/mkdocs:${env.BUILD_ID}")
                }
            }
        }

        stage('Build site'){
            steps {
                agent {
                    docker { 
                        image 'pthakkar/mkdocs:${env.BUILD_ID}'
                        args '-v env.WORKSPACE/mkdocs:/docs/src/ -v env.WORKSPACE/mkdocs/site:/docs/output/ produce' 
                    }
                }
            }
        }
        stage('Serve site') {
            steps {
                agent {
                    docker { 
                        image 'pthakkar/mkdocs:${env.BUILD_ID}'
                        args '-v env.WORKSPACE/mkdocs/site:/docs/src/ -p 8000:8000 serve' 
                    }
                }
            }
        }
    }
}
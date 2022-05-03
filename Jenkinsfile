pipeline {
    environment {
        WORKSPACE = "${env.WORKSPACE}"
        BUILDID = "${env.BUILD_ID}"
    }
    agent any
    stages {
        stage('Clone repository') { 
            steps { 
                script{
                checkout scm                // For testing using pipeline script from SCM
                //git([url: 'https://github.com/Pratik-Thakkar/mkdocs.git', branch: 'main', credentialsId: 'pratik_prj'])
                }
            }
        }

        stage('Build docker image') { 
            steps { 
                script{
                 dockerImage = docker.build("pthakkar/mkdocs:latest")
                }
            }
        }

        stage('Build site'){
            agent {
                docker { 
                    image 'pthakkar/mkdocs:latest'
                    args '-t --rm -v ${WORKSPACE}/src/:/docs/src/ -v ${WORKSPACE}/src/site/:/docs/output/ --produce'
                    reuseNode true 
                }
            }
            steps { sh 'mkdocs --version' }
        }
        stage('Serve site') {
            agent {
                docker { 
                    image 'pthakkar/mkdocs:latest'
                    args '-t -p 8000:8000 -v ${WORKSPACE}/src/site:/docs/src/ --serve'
                    reuseNode true 
                }
            }
            steps { sh 'curl -v http://localhost:8000' }
        }
    }
}
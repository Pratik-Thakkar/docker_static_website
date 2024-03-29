pipeline {
    environment {
        WORKSPACE = "${env.WORKSPACE}"          // Required for mounting source and output folders
        BUILDID = "${env.BUILD_ID}"             // Required for docker image tag
        GOSS_PATH = "/usr/local/bin/goss"       // Required for running dgoss command from Jenkins workspace
    }
    agent any
    stages {
        stage('Clone repository') { 
            steps { 
                script{
                    /* Let's make sure we have the repository cloned to our workspace */

                    checkout scm                 // For testing using pipeline script from SCM
                }
            }
        }

        stage('Build docker image') { 
            steps { 
                script{
                    /* This builds the actual image; synonymous to docker build on the command line */

                    dockerImage = docker.build("pthakkar/mkdocs:$BUILDID")
                }
            }
        }

        stage('Build site'){
            steps {
                /* Bulding site documents with mkdocs and creating tar file in output folder */
                
                sh 'docker run -t --rm -v $WORKSPACE/src/:/docs/src/ -v $WORKSPACE/src/output/:/docs/output/ pthakkar/mkdocs:$BUILDID produce'
            }
        }

        stage('Test site') {     
            steps {
                /* Ideally, we would run a test framework against our image.
                * For this example, we're using Goss -  Quick and Easy server validation */

                sh '/usr/local/bin/dgoss run -t -p 8000:8000 --name mksite -v $WORKSPACE/src/output/:/docs/src/ pthakkar/mkdocs:$BUILDID serve'
            }
        }
    }
}
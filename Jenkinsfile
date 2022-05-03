pipeline {
    environment {
        WORKSPACE = "${env.WORKSPACE}"
        BUILDID = "${env.BUILD_ID}"
        GOSS_PATH = "/usr/local/bin/goss"       // Required for running dgoss command in a container
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
                /* Bulding site documents with mkdocs */
                
                sh 'docker run -t --rm -v $WORKSPACE/src/:/docs/src/ -v $WORKSPACE/src/output/:/docs/output/ pthakkar/mkdocs:$BUILDID produce'
            }
        }

        stage('Test site') {     
            steps {
                /* Ideally, we would run a test framework against our image.
                * For this example, we're using a goss -  Quick and Easy server validation) */

                sh '/usr/local/bin/dgoss run -t -p 8000:8000 --name mksite -v $WORKSPACE/src/output/:/docs/src/ pthakkar/mkdocs:$BUILDID serve'
            }
        }
    }
}
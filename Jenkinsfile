pipeline {
     agent any
	 options{
        buildDiscarder(logRotator(numToKeepStr: '7', daysToKeepStr: '7'))
        timestamps()
        }
     
        environment {
		registryUrl = 'devops9.azurecr.io'
		Repo='loan-calculator'
		registryCredential='AZURE-ECR'
		VERSION="${'v' + BUILD_ID}"
		IMAGE_TAG=$"{registryUrl + '/' + Repo + ':' + VERSION}"
        dockerImage = ''
    }
    
    stages {

        stage ('1-GITHUB-Repo-checkout') {
            steps {
              git (url:'https://github.com/akashbrvs/Loan-calculator.git', branch: 'main', credentialsId: 'GITHUB')
            }
        }
       
        stage ('2-Build-Docker-Image') {
            steps {
                
                script {
                    dockerImage = docker.build IMAGE_TAG
					 
                }
            }
        }
       
    stage('3-Upload-Image-to-ACR') {
     steps{   
         script {
            docker.withRegistry( "http://${registryUrl}",registryCredential ) {
            dockerImage.push()
            }
        }
      }
    }
	stage ('4-Remove-local-image') {
            steps {
                
                script {
                   sh 'echo $VERSION > versionfile;docker rmi $IMAGE_TAG'
                }
            }
        }
    }
  
 }

pipeline {
     agent any
	 options{
        buildDiscarder(logRotator(numToKeepStr: '7', daysToKeepStr: '7'))
        timestamps()
        }
     
        environment {
		
		registryUrl = 'devops9.azurecr.io'
		registryRepo='loan-calculator'
		version='1.0.0-RELEASE'
		IMAGE_TAG='devops9.azurecr.io/loan-calculator:1.0.0-RELEASE'
		registryCredential='AZURE-ECR'
		
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
                   sh 'docker rmi $IMAGE_TAG'
                }
            }
        }
    }
  
 }

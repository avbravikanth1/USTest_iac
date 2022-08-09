pipeline {
    agent any
    stages {
        stage("SCM Checkout") {
            steps {
                git branch: 'master',
                    credentialsId: "raviGitAccess",            
                    url: 'https://github.com/avbravikanth1/my-react-app.git'
                dir("Test_iac") {
                    git branch: 'master',
                    credentialsId: "raviGitAccess",
                    url: 'https://github.com/avbravikanth1/USTest_iac.git'
                }
            }  
        }             
        stage('Build') {
            steps {
                sh "npm install"
                sh "npm run build"               
            }
        }
        stage('copy files') {
            steps {
                ansiblePlaybook become: true,
                    credentialsId: 'awsUsDemo',
                    disableHostKeyChecking: true, 
                    installation: 'ansible', 
                    inventory: 'Test_iac/inventories/dev.inv', 
                    limit: 'awsAppServer', 
                    playbook: 'Test_iac/appDeploy.yml',
                    tags: 'copy_files'
            }
        }
        stage('Deploy') {
            steps {
                ansiblePlaybook become: true, 
                    credentialsId: 'awsUsDemo',
                    disableHostKeyChecking: true, 
                    installation: 'ansible', 
                    inventory: 'Test_iac/inventories/dev.inv', 
                    limit: 'awsAppServer', 
                    playbook: 'Test_iac/appDeploy.yml',
                    tags: 'npm_start'                
            }
        }
        
    }
}
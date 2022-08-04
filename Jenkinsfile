pipeline {
    agent any
    stages {
        stage("SCM Checkout") {
            steps {
                git branch: 'master',
                    credentialsId: "RajaGithubAccess",            
                    url: 'https://github.com/rajasekhar2304/my-react-app.git'
                dir("SAtest_iac") {
                    git branch: 'master',
                    credentialsId: "RajaGithubAccess",
                    url: 'https://github.com/rajasekhar2304/SAtest_iac.git'
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
                    credentialsId: 'awsSADemoServer',
                    disableHostKeyChecking: true, 
                    installation: 'ansible', 
                    inventory: 'SAtest_iac/inventories/dev.inv', 
                    limit: 'awsAppServer', 
                    playbook: 'SAtest_iac/appDeploy.yml',
                    tags: 'copy_files'
            }
        }
        stage('Deploy') {
            steps {
                ansiblePlaybook become: true, 
                    credentialsId: 'awsSADemoServer',
                    disableHostKeyChecking: true, 
                    installation: 'ansible', 
                    inventory: 'SAtest_iac/inventories/dev.inv', 
                    limit: 'awsAppServer', 
                    playbook: 'SAtest_iac/appDeploy.yml',
                    tags: 'npm_start'                
            }
        }
        
    }
}
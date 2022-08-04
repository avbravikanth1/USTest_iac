pipeline {
    agent any

    // environment {
    //     AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
    //     AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-aceess-key')
    // }

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
        stage('EB Deployment') {
            steps {
                ansiblePlaybook become: true, 
                    credentialsId: 'awsSADemoServer',
                    disableHostKeyChecking: true, 
                    installation: 'ansible', 
                    inventory: 'SAtest_iac/inventories/dev.inv', 
                    limit: 'awsAppServer', 
                    playbook: 'SAtest_iac/appDeploy.yml',
                    tags: 'ebdeploy'                
            }
        }
        
    }
}
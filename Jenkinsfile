pipeline {
    agent {
        label 'gitops-jenkins-jenkins-slave'
    }
    stages {
        stage('Get Source') {
            steps {
                git credentialsId: 'GitHubAccess', url: 'https://github.com/chenbiao7/app-repo.git'
                script {
                    echo "1.2 In scripts"
                    build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                    echo ${build_tag}
                    repo_name = '939921924936.dkr.ecr.us-east-1.amazonaws.com'
                    app_name = 'gitops-app-demo'
                }
            }
        }
        stage('Build Image') {
            steps {
                sh "docker build --network host -t ${repo_name}/${app_name}:latest ."
                sh "docker tag ${repo_name}/${app_name}:latest ${repo_name}/${app_name}:${build_tag}"
            }

        }
        stage('Push Image') {
            steps {
                withDockerRegistry(credentialsId: 'ecr:us-east-1:AWS-AKSK', url: 'https://939921924936.dkr.ecr.us-east-1.amazonaws.com/gitops-app-demo') {
                    sh "docker push ${repo_name}/${app_name}:latest"
                    sh "docker push ${repo_name}/${app_name}:${build_tag}"
                }
            }
        }
    }
}

pipeline {
    agent {
        label 'gitops-jenkins-jenkins-slave'
    }
    stages {
        stage('Get Source') {
            steps {
                echo "1.Clone Repo Stage"
                git credentialsId: 'GitHubAccess', url: 'https://github.com/chenbiao7/gitops-app'
                echo "1.1 Clone Finished"
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
            echo "2.Build Image With Tag"
            steps {
                echo "2.Build Docker Image Stage"
                sh "docker build --network host -t ${repo_name}/${app_name}:latest ."
                sh "docker tag ${repo_name}/${app_name}:latest ${repo_name}/${app_name}:${build_tag}"
            }

        }
        stage('Push Image') {
            echo "3.Push With My Image"
            steps {
                echo "3.Push Docker Image Stage"
                withDockerRegistry(credentialsId: 'ecr:us-east-1:AWS-AKSK', url: 'https://939921924936.dkr.ecr.us-east-1.amazonaws.com/gitops-app') {
                    sh "docker push ${repo_name}/${app_name}:latest"
                    sh "docker push ${repo_name}/${app_name}:${build_tag}"
                }
            }
        }
    }
}

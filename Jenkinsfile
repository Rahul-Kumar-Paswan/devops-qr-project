pipeline{
    agent any 
    stages{
        stage('Docker Build Image'){
            steps{
                script{
                    def buildNumber = env.BUILD_NUMBER

                    def apiImage = "rahulkumarpaswan/devops-qr-api:${buildNumber}"
                    def frontEndImage = "rahulkumarpaswan/devops-qr-front-end:${buildNumber}"
                    sh 'ls -l'
                    sh 'pwd'

                    dir('./devops-qr-code/api/') {
                        echo 'Building API Docker Image'
                        sh 'ls -l'
                        sh "docker build -t devops-qr-api ."
                        sh "docker tag devops-qr-api ${apiImage}"
                        withCredentials([usernamePassword(credentialsId: 'docker-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                            sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker push ${apiImage}"
                        }
                    }
                    echo 'Building Frontend Docker Image'
                    dir('./devops-qr-code/front-end-nextjs/') {
                        sh 'ls -l'
                        sh 'pwd'
                        sh "docker build -t devops-qr-front-end ."
                        sh "docker tag devops-qr-front-end ${frontEndImage}"
                        sh "docker push ${frontEndImage}"
                    }
                }
            }  
        }
        stage('Infrastructure'){
            environment {
                AWS_ACCESS_KEY_ID = credentials('aws_access_key')
                AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key')
            }
            steps{
                script{
                    dir('./Infra/'){
                        echo 'Inside the Infra directory'
                        sh 'ls -l'
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh "terraform validate"
                        sh 'terraform apply -auto-approve'
                        // sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
        stage('Kubernetes Deployment') {
            steps {
                script {
                    def buildNumber = env.BUILD_NUMBER
                    def apiImage = "rahulkumarpaswan/devops-qr-api:${buildNumber}"
                    def frontEndImage = "rahulkumarpaswan/devops-qr-front-end:${buildNumber}"

                    dir('./Kubernetes/') {
                        echo 'Inside the Kubernetes directory'
                        sh 'ls -l'
                        withCredentials([
                            string(credentialsId: 'aws_kubectl_access_key', variable: 'AWS_KUBECTL_ACCESS_KEY_ID'),
                            string(credentialsId: 'aws_kubectl_secret_key', variable: 'AWS_KUBECTL_SECRET_ACCESS_KEY')
                        ]) {
                            // withEnv(["KUBECONFIG=/home/jenkins/.kube/config"]) {
                                sh """
                                    aws eks --region ap-south-1 update-kubeconfig --name my-devops-cluster
                                    export API_IMAGE=${apiImage} FRONTEND_IMAGE=${frontEndImage}
                                    kubectl config view
                                    kubectl get nodes
                                    kubectl config current-context
                                    envsubst < secret.yml | kubectl apply -f -
                                    envsubst < front-end-deploy.yaml | kubectl apply -f -
                                    envsubst < qr-api.yaml | kubectl apply -f -
                                """
                            }
                        // }
                    }
                }
            }
        }
        stage('Dev') {
            steps {
                echo 'Hello Dev'
            }
        }
    }
}
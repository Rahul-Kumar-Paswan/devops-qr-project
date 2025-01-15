// pipeline {
//     agent any
//     stages {
        // stage('Build Docker Images') {
        //     steps {
        //         script {
        //             def buildNumber = env.BUILD_NUMBER

        //             def apiImage = "rahulkumarpaswan/devops-qr-api:${buildNumber}"
        //             def frontEndImage = "rahulkumarpaswan/devops-qr-front-end:${buildNumber}"

        //             dir('./devops-qr-code/api/') {
        //                 echo 'Building API Docker Image'
        //                 sh "docker build -t devops-qr-api ."
        //                 sh "docker tag devops-qr-api ${apiImage}"
        //                 withCredentials([usernamePassword(credentialsId: 'docker-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        //                     sh "echo $PASS | docker login -u $USER --password-stdin"
        //                     sh "docker push ${apiImage}"
        //                 }
        //             }
        //             dir('./devops-qr-code/front-end-nextjs/') {
        //                 echo 'Build Frontend Docker Image'
        //                 sh "docker build -t devops-qr-front-end ."
        //                 sh "docker tag devops-qr-front-end ${frontEndImage}"
        //                 sh "docker push ${frontEndImage}"
        //             }
        //         }
        //     }
        // }
        // stage('Setup Infrastructure') {
        //     steps {
        //         script {
        //             withCredentials([
        //                 string(credentialsId: 'aws_access_key', variable: 'AWS_ACCESS_KEY_ID'),
        //                 string(credentialsId: 'aws_secret_key', variable: 'AWS_SECRET_ACCESS_KEY')
        //             ]) {
        //                 dir('./Infra/') {
        //                     echo 'Inside the Infra directory'
        //                     sh 'terraform init'
        //                     sh 'terraform plan'
        //                     sh 'terraform validate'
        //                     sh 'terraform apply -auto-approve'
        //                 }
        //             }
        //         }
        //     }
        // }
        // stage('Deploy to Kubernetes') {
        //     steps {
        //         script {
        //             def buildNumber = env.BUILD_NUMBER
        //             def apiImage = "rahulkumarpaswan/devops-qr-api:${buildNumber}"
        //             def frontEndImage = "rahulkumarpaswan/devops-qr-front-end:${buildNumber}"

        //             dir('./Kubernetes/') {
        //                 echo 'Inside the Kubernetes directory'
        //                 withCredentials([
        //                     string(credentialsId: 'aws_access_key', variable: 'AWS_ACCESS_KEY_ID'),
        //                     string(credentialsId: 'aws_secret_key', variable: 'AWS_SECRET_ACCESS_KEY')
        //                 ]) {
        //                     def base64AccessKey = sh(script: "echo -n ${AWS_ACCESS_KEY_ID} | base64", returnStdout: true).trim()
        //                     def base64SecretKey = sh(script: "echo -n ${AWS_SECRET_ACCESS_KEY} | base64", returnStdout: true).trim()

        //                     sh """
        //                         export BASE64_AWS_ACCESS_KEY=${base64AccessKey}
        //                         export BASE64_AWS_SECRET_KEY=${base64SecretKey}
        //                         aws eks --region ap-south-1 update-kubeconfig --name my-devops-cluster
        //                         export API_IMAGE=${apiImage} FRONTEND_IMAGE=${frontEndImage}
        //                         kubectl config view
        //                         kubectl get nodes
        //                         kubectl config current-context
        //                         envsubst < secret.yml | kubectl apply -f -
        //                         envsubst < front-end-deploy.yaml | kubectl apply -f -
        //                         envsubst < qr-api.yaml | kubectl apply -f -
        //                     """
        //                 }
        //             }
        //         }
        //     }
        // }
//     }
// }



// Destroy the infrastructure
pipeline {
    agent any
    stages {
        stage('Destroying Terraform Infrastructure') {
            steps {
                echo "Testing stage 1 !!!!"
            }
        }
        stage('Destroying Everything') {
            steps {
                script {
                    withCredentials([
                        string(credentialsId: 'aws_access_key', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'aws_secret_key', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        dir('./Infra/') {
                            echo 'Inside the Infra directory'
                            sh 'terraform init'
                            sh 'terraform plan'
                            sh 'terraform validate'
                            sh 'terraform destroy -auto-approve'
                        }
                    }
                }
            }
        }
    }
}

pipeline {
    agent any 

    environment {
        // 1. Docker Variables
        DOCKER_USER = "your-dockerhub-username" // CHANGE THIS!
        IMAGE_NAME = "${DOCKER_USER}/my-custom-app"
        IMAGE_TAG = "v${env.BUILD_ID}" // Automatically uses Jenkins build # (e.g., v1, v2)
        
        // 2. GitHub Variables
        GIT_USER = "PankajGautam04"
        GIT_EMAIL = "your-email@example.com"    // CHANGE THIS!
        CONFIG_REPO = "github.com/PankajGautam04/git-demo-config.git"
    }

    stages {
        stage('Checkout & Verify') {
            steps {
                echo "Successfully pulled code from GitHub!"
                sh 'ls -la' 
            }
        }

        stage('Read File') {
            steps {
                // Using '|| true' so the pipeline doesn't crash if the .txt file is deleted later
                sh 'cat *.txt || true'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                echo "Building the custom NGINX image..."
                // Runs the Dockerfile in your repo
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                
                echo "Uploading image to DockerHub..."
                // Securely logs into DockerHub and pushes the image
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER_VAR')]) {
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER_VAR --password-stdin"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Update GitOps Config') {
            steps {
                echo "Updating Helm values in git-demo-config..."
                // Securely uses your GitHub token to push the changes
                withCredentials([usernamePassword(credentialsId: 'github-token', passwordVariable: 'GIT_PAT', usernameVariable: 'GIT_USR')]) {
                    sh """
                    # Set up Git identity
                    git config --global user.name "${GIT_USER}"
                    git config --global user.email "${GIT_EMAIL}"
                    
                    # Clone the config repo using the secret token
                    git clone https://${GIT_USR}:${GIT_PAT}@${CONFIG_REPO} config-repo
                    cd config-repo
                    
                    # Search for the old tag in values.yaml and replace it with the new build tag
                    sed -i "s/tag: .*/tag: \\"${IMAGE_TAG}\\"/g" demo-app/values.yaml
                    
                    # Commit and push back to GitHub
                    git add .
                    git commit -m "Jenkins automated deploy: Updated image to ${IMAGE_TAG}"
                    git push origin main
                    """
                }
            }
        }
    }
}

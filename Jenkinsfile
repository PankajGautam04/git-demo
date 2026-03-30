pipeline {
    agent any 

    stages {
        stage('Checkout & Verify') {
            steps {
                echo "Successfully pulled code from GitHub!"
                // This command will list the files in your repo, proving it downloaded your .txt file
                sh 'ls -la' 
            }
        }
        stage('Read File') {
            steps {
                // This will print the contents of whatever text file is in your repo
                sh 'cat *.txt'
            }
        }
        stage('Simulate Build') {
            steps {
                echo "Building the git-demo application..."
            }
        }
        stage('Update GitOps Config') {
            steps {
                // Pseudo-code for the Jenkins handoff
                sh '''
                git clone https://github.com/PankajGautam04/git-demo-config.git
                cd git-demo-config
                # Update the deployment.yaml with the new Docker image tag
                sed -i 's/myapp:v1/myapp:v2/g' deployment.yaml
                git add deployment.yaml
                git commit -m "Update image to v2"
                git push origin main
                '''
            }
        }
    }
}

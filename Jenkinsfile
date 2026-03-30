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
    }
}

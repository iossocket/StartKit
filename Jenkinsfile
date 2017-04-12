node {
    stage('Checkout') {
       checkout scm
    }

    stage('Build') {
        sh "/Users/jetstar/.fastlane/bin/fastlane beta"
    }
}

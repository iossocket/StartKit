node {
    stage('Checkout') {
       checkout scm
    }

    stage('Build') {
        sh "fastlane beta"
    }
}

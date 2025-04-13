pipeline {
    agent any

    environment {
          MAVEN_OPTS = '-Xmx2048m' // Adjust based on available system memory
    }

    tools {
        maven 'Maven 3.8.7' // Adjust to your Maven installation
        jdk 'JDK 17'        // Adjust to your JDK installation
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Checkstyle Analysis') {
            steps {
                sh 'mvn checkstyle:checkstyle'
                recordIssues tools: [checkStyle(pattern: '**/target/checkstyle-result.xml')], failOnError: true
            }
        }

        stage('SpotBugs Analysis') {
            steps {
                sh 'mvn com.github.spotbugs:spotbugs-maven-plugin:spotbugs'
                recordIssues tools: [spotBugs(pattern: '**/target/spotbugsXml.xml')], failOnError: true
            }
        }

        stage('OWASP Dependency-Check') {
            steps {
                dependencyCheck (additionalArguments: '--nvdApiKey 71466541-8d18-4312-bf8c-d2d8ac63f256 --format XML --out target --scan .', odcInstallation: 'DC')
                dependencyCheckPublisher pattern: 'target/dependency-check-report.xml',
                    failedTotalCritical: 1,
                    failedTotalHigh: 1,
                    failedTotalMedium: 1,
                    failedTotalLow: 1,
                    stopBuild: true
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'target/*.xml', allowEmptyArchive: true
        }
    }
}

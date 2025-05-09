#!/bin/bash

set -e

# Define variables
JENKINS_CONTAINER_NAME="jenkins"
JENKINS_IMAGE="jenkins/jenkins:lts"
JENKINS_HOME_VOLUME="jenkins_home"
JENKINS_PORT=8080
JENKINS_SLAVE_PORT=50000

# Create Docker volume for Jenkins data
docker volume create $JENKINS_HOME_VOLUME

# Run Jenkins container
docker run -d \
  --name $JENKINS_CONTAINER_NAME \
  -p $JENKINS_PORT:8080 \
  -p $JENKINS_SLAVE_PORT:50000 \
  -e JAVA_OPTS="-Xms512m -Xmx2048m" \
  -v $JENKINS_HOME_VOLUME:/var/jenkins_home \
  $JENKINS_IMAGE

# Wait for Jenkins to initialize
echo "Waiting for Jenkins to initialize..."
sleep 30

# Download Jenkins CLI
curl -o jenkins-cli.jar http://localhost:$JENKINS_PORT/jnlpJars/jenkins-cli.jar

# Display the initial admin password
echo "Initial Admin Password:"
docker exec $JENKINS_CONTAINER_NAME cat /var/jenkins_home/secrets/initialAdminPassword

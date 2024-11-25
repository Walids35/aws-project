#!/bin/bash
# Update the instance
sudo yum update -y

# Install Docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Pull the public Docker image
docker pull walids35/aws-back-app

# Run the Docker container
docker run -d -p 4000:4000 walids35/aws-back-app

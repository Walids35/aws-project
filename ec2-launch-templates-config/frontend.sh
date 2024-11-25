#!/bin/bash
# Update the instance
sudo yum update -y

# Install Docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Pull the public Docker image
sudo docker pull walids35/aws-front-app

# Run the Docker container
sudo docker run -d -p 80:3000 walids35/aws-front-app

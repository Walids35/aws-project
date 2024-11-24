#!/bin/bash

# Update system packages
sudo yum update -y

# Install Python3 and pip
sudo yum install -y python3
sudo yum install -y python3-pip

# Create a dedicated directory for the backend application
mkdir -p /home/ec2-user/backend-app
cd /home/ec2-user/backend-app

# Create a Python virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install Flask (or any other framework required for the backend)
pip install flask

# Create a simple Flask backend application
cat <<EOL > app.py
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({"message": "Welcome to the Backend Application!"})

@app.route('/status')
def status():
    return jsonify({"status": "Backend is running smoothly!"})

@app.route('/data')
def data():
    return jsonify({
        "id": 1,
        "name": "Sample Data",
        "description": "This is an example response from the backend"
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000)
EOL

# Create a systemd service file to run the backend on startup
sudo tee /etc/systemd/system/backend.service > /dev/null <<EOL
[Unit]
Description=Python Backend Application
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/backend-app
ExecStart=/home/ec2-user/backend-app/venv/bin/python app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd to apply the new service
sudo systemctl daemon-reload

# Start and enable the backend service
sudo systemctl start backend.service
sudo systemctl enable backend.service

# Log the backend setup completion
echo "Backend Application Setup Completed" > /home/ec2-user/backend-setup.log

#!/bin/bash

# Update and install necessary packages
sudo yum update -y
sudo yum install -y httpd

# Start and enable Apache HTTP Server
sudo systemctl start httpd
sudo systemctl enable httpd

# Define the backend URL
BACKEND_URL="http://10.0.0.110:4000"

# Create a more aesthetic and functional frontend page
sudo bash -c 'cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Frontend Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        h1 {
            color: #2c3e50;
        }
        .container {
            margin: auto;
            padding: 20px;
            max-width: 600px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .response {
            margin-top: 20px;
            padding: 15px;
            border-radius: 5px;
            background-color: #eaf8e6;
            color: #2c3e50;
            font-weight: bold;
        }
        .loading {
            color: #999;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Frontend Application</h1>
        <p>Welcome to the Frontend Application</p>
        <p>This page dynamically fetches data from the backend:</p>
        <div class="response">
            Backend Response: <span id="backendResponse" class="loading">Loading...</span>
        </div>
    </div>

    <script>
        // Fetch backend response dynamically
        const backendUrl = "$BACKEND_URL/";
        fetch(backendUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.text();
            })
            .then(data => {
                document.getElementById("backendResponse").textContent = data;
                document.getElementById("backendResponse").classList.remove("loading");
            })
            .catch(error => {
                document.getElementById("backendResponse").textContent = "Failed to fetch backend response.";
                document.getElementById("backendResponse").classList.remove("loading");
                console.error("Error fetching backend:", error);
            });
    </script>
</body>
</html>
EOF'

# Restart Apache to load the new page
sudo systemctl restart httpd

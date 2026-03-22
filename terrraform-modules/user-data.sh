#!/bin/bash
# Update and install Nginx
sudo apt-get update -y
sudo apt-get install nginx -y

# Start Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Get the Availability Zone using IMDSv2
# We need a token first for security
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
HOSTNAME=$(hostname -f)

# Create a custom index.html to show the AZ
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>AZ Test Page</title>
    <style>
        body { font-family: sans-serif; text-align: center; margin-top: 50px; }
        .box { border: 2px solid #333; padding: 20px; display: inline-block; border-radius: 10px; }
        .az { color: #ff9900; font-weight: bold; font-size: 2em; }
    </style>
</head>
<body>
    <div class="box">
        <h1>Hello from Terraform!</h1>
        <p>This instance is running in Availability Zone:</p>
        <p class="az">$AZ</p>
        <p>Instance Hostname: $HOSTNAME</p>
    </div>
</body>
</html>
EOF
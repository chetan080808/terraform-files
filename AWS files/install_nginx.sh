#!bin/bash

# Update package lists
sudo apt update -y

# Install Nginx
sudo apt install nginx -y

# Start and enable Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# show output
echo "Hello chetan welcome to nginx server" | sudo tee /var/www/html/index.html
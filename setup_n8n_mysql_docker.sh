#!/bin/bash

# Script name: setup_n8n_mysql_docker.sh

# Script to automate setup of n8n with MySQL and Docker

# Define constants for usernames and passwords
N8N_USERNAME="your_n8n_username"
N8N_PASSWORD="your_n8n_password"

MYSQL_ROOT_PASSWORD="your_mysql_root_password"
MYSQL_N8N_USERNAME="n8n_user"
MYSQL_N8N_PASSWORD="your_mysql_n8n_password"

# Update and upgrade system packages
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y

# Install MySQL server and run secure installation
sudo apt install mysql-server -y

# Modify MySQL configuration to allow remote connections
sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL service
sudo systemctl restart mysql

# Run mysql_secure_installation to secure MySQL installation
sudo mysql_secure_installation <<EOF

y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
y
y
y
EOF

# Configure MySQL for n8n
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD <<MYSQL_SCRIPT
CREATE DATABASE n8n_db;
CREATE USER '$MYSQL_N8N_USERNAME'@'%' IDENTIFIED BY '$MYSQL_N8N_PASSWORD';
GRANT ALL PRIVILEGES ON n8n_db.* TO '$MYSQL_N8N_USERNAME'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Install Docker and start Docker service
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Run n8n Docker container
sudo docker run -d -it --rm --name n8n -p 5678:5678 \
  -e N8N_BASIC_AUTH_ACTIVE=true \
  -e N8N_BASIC_AUTH_USER=$N8N_USERNAME \
  -e N8N_BASIC_AUTH_PASSWORD=$N8N_PASSWORD \
  -e N8N_SECURE_COOKIE=false \
  n8nio/n8n

echo "n8n Docker container is now running."

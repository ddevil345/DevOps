#!/bin/bash
echo "change server to BG"
sudo sed -i 's/http:\/\/us./http:\/\/bg./g' /etc/apt/sources.list

echo "Updating and upgrading the system"
sudo apt update

echo "Install docker"
sudo apt install -y docker docker.io docker-compose

echo "Adding the current user to the docker group"
sudo usermod -aG docker vagrant

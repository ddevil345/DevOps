#!/bin/bash
echo "Install docker"
sudo apt install -y docker docker.io

echo "Add users"
sudo useradd jenkins
sudo usermod --password jenkins jenkins
sudo echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo adduser vagrant docker
sudo adduser jenkins docker


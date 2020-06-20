#!/bin/bash
echo "change server to BG"
sudo sed -i 's/http:\/\/us./http:\/\/bg./g' /etc/apt/sources.list

echo "Added & Updated repos"
sudo apt update

echo "Install Java JDK 11 and git"
sudo apt install openjdk-11-jdk-headless openjdk-11-jre-headless git sshpass -y

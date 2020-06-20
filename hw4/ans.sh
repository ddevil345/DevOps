#!/bin/bash
echo "change server to BG"
sudo sed -i 's/http:\/\/us./http:\/\/bg./g' /etc/apt/sources.list

echo "Update and Install ansible"
sudo apt-get update
sudo apt-get install ansible sshpass -y
echo "added hosts in hosts file"
sudo echo "192.168.12.100 ans.hw4.local ans" >> /etc/hosts
sudo echo "192.168.12.101 docker.hw4.local docker" >> /etc/hosts
sudo echo "192.168.12.102 web.hw4.local web" >> /etc/hosts
sudo echo "192.168.12.103 db.hw4.local db" >> /etc/hosts

#!/bin/bash
echo "change server to BG"
sudo sed -i 's/http:\/\/us./http:\/\/bg./g' /etc/apt/sources.list

sudo apt-get update

sudo echo "192.168.12.100 ans.hw4.local ans" >> /etc/hosts
sudo echo "192.168.12.101 docker.hw4.local docker" >> /etc/hosts
sudo echo "192.168.12.102 web.hw4.local web" >> /etc/hosts
sudo echo "192.168.12.103 db.hw4.local db" >> /etc/hosts

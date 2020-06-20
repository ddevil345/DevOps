#!/bin/bash
echo "===========Update"
sudo apt update
echo "===========Upgrade"
sudo apt upgrade
echo "===========Install Docker"
sudo apt install -y docker docker.io
echo "===========Make dir and files"
mkdir web
echo '<h1>Hello from my first container!</h1>' > web/index.html
echo "===========Run apache2 port 80"
sudo docker run -dit --name hw2docker -p 80:80 -v /home/vagrant/web/:/usr/local/apache2/htdocs/ httpd:2.4

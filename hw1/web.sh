#!/bin/bash

echo "* Add hosts ..."
echo "192.168.12.10 web.hw1.lab web" >> /etc/hosts
echo "192.168.12.11 db.hw1.lab db" >> /etc/hosts

echo "* Install Software ..."
sudo apt-get update -y
sudo apt-get install apache2 -y
sudo apt-get install -y php-{bcmath,bz2,intl,gd,mbstring,mcrypt,mysql,zip}
sudo apt-get install libapache2-mod-php  -y
echo "* Start HTTP ..."
sudo systemctl restart apache2.service
#sudo systemctl enable apache2.service

echo "* Copy web site files to /var/www/html/ ..."
cp /vagrant/* /var/www/html


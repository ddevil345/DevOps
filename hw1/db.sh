#!/bin/bash

PASS="pazz123"

echo "* Add hosts ..."
echo "192.168.12.10 web.hw1.lab web" >> /etc/hosts
echo "192.168.12.11 db.hw1.lab db" >> /etc/hosts

export DEBIAN_FRONTEND=noninteractive
sudo echo mariadb-server  mariadb-server/root_password password $PASS | debconf-set-selections
sudo echo mariadb-server mariadb-server/root_password_again password $PASS | debconf-set-selections

echo "* Install Software ..."
sudo apt-get update
sudo apt install -y mariadb-server mariadb-client

echo "* Allowing non-local DB access ..."
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

echo "* Restarting MariaDB in order to take an effect ..."
/etc/init.d/mysql restart
echo "* Create and load the database ..."
sudo -u root mysql -u root -p$PASS < /vagrant/db_setup.sql

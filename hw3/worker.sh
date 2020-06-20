#!/bin/bash
echo "Joining the swarm"
MASTER_IP=$(cat /home/vagrant/hw3/master_ip)
SWARM_TOKEN=$(cat /home/vagrant/hw3/worker_token)
sudo docker swarm join --token "${SWARM_TOKEN}" "${MASTER_IP}":2377
docker build -t php7.2-mysql ./hw3/service-php



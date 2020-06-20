# Get the IP address of the machine
MASTER_IP=$(ip -4 addr show eth1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
# Initiate the swarm
echo "Intializing the Swarm"
sudo docker swarm init --advertise-addr=$MASTER_IP
# Save the Swarm Token and Master IP from eth1
echo "Exporting the master IP"
echo $MASTER_IP > /home/vagrant/hw3/master_ip
sudo docker swarm join-token --quiet worker > /home/vagrant/hw3/worker_token
docker build -t php7.2-mysql ./hw3/service-php

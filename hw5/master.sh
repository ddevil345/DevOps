#!/bin/bash
echo "change server to BG"
sudo sed -i 's/http:\/\/us./http:\/\/bg./g' /etc/apt/sources.list

echo "Add Jenkins"
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -'
sudo echo "deb https://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list
sudo apt update
echo "Install Jenkins"
sudo apt install jenkins -y
#sudo apt install -f
#wget https://d-devil.org/devops/jenkins_2.235.1_all.deb
#sudo dpkg -i jenkins_2.235.1_all.deb
sudo systemctl enable --now jenkins
sudo echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

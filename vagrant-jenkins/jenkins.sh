#!/bin/bash

# Install Jenkins
echo "[TASK 1] Install Jenkins"
apt update -y
apt install -y openjdk-8-jdk

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y

# Install nodejs 10
echo "[TASK 2] Install nodejs 10"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt install -y nodejs
node --version
npm --version
sudo npm i -g pm2

# Install default services
echo "[TASK 3] nginx docker.io ansible unzip nano git curl"
apt install -y nginx
apt-get -y install docker.io ansible unzip nano git curl

groupadd docker
gpasswd -a jenkins docker
setfacl -m user:jenkins:rw /var/run/docker.sock


# Enable ssh password authentication
echo "[TASK 4] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 5] Set root password"
echo "kubeadmin" | passwd --stdin root >/dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc

ip a
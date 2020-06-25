#!/bin/bash

# Install Jenkins
echo "[TASK 1] Install Jenkins"
apt update -y
apt install -y openjdk-8-jdk



# Install nodejs 10
echo "[TASK 2] Install nodejs 10"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt install -y nodejs
node --version
npm --version
sudo npm i -g pm2

# Install default services
echo "[TASK 3] nginx docker.io ansible unzip nano git curl"
#apt install -y apache2
apt-get -y install docker.io ansible unzip nano git curl

groupadd docker
gpasswd -a jenkins docker
setfacl -m user:vagrant:rw /var/run/docker.sock

# Install LEMP

apt install -y mysql-server
apt install -y php php-fpm php-mysql php-xml php-mbstring
apt install -y apt install php7.2-fpm php7.2-common php7.2-sqlite3 php7.2-mysql php7.2-gmp php7.2-curl php7.2-intl php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-ldap php7.2-gd php7.2-bcmath php7.2-xml php7.2-cli php7.2-zip

echo "<?php phpinfo ();?>" | sudo tee /var/www/html/info.php

# Composer

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
cd /var/www/
composer create-project symfony/skeleton symfony5

chown -R www-data:www-data /var/www/symfony5/
chmod -R 755 /var/www/symfony5/

# Enable ssh password authentication
echo "[TASK 4] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 5] Set root password"
echo "kubeadmin" | passwd --stdin root >/dev/null 2>&1

# Install phpmyadmin
#apt install -y phpmyadmin php-mbstring php-gettext
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc

ip a



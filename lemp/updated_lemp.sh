#!/bin/bash


echo "[TASK 1] Upadte"
apt update -y && apt upgrade


# Install default services
echo "[TASK 2] Install: zip nano git curl"
#apt install -y apache2
apt-get -y install  zip nano git curl

# Install LEMP
echo "[TASK 3] Install: mysql-server, php"

apt install -y mysql-server
apt install -y php php-fpm php-mysql php-xml php-mbstring
apt install -y apt install php7.2-fpm php7.2-common php7.2-sqlite3 php7.2-mysql php7.2-gmp php7.2-curl php7.2-intl php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-ldap php7.2-gd php7.2-bcmath php7.2-xml php7.2-cli php7.2-zip

echo "[TASK 4] Install: apache2"

apt install -y apache2

rm /var/www/html/info.html
cd /var/www/html/
git clone https://github.com/ethicalhack3r/DVWA.git
chmod -R 777 /var/www/html/DVWA/

echo "<?php phpinfo ();?>" | sudo tee /var/www/html/info.php






# Enable ssh password authentication
echo "[TASK 4] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 5] Set root password"
echo "kubeadmin" | passwd --stdin root >/dev/null 2>&1

# Install phpmyadmin
#apt install -y phpmyadmin php-mbstring php-gettext
#sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc

ip a



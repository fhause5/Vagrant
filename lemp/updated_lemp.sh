#!/bin/bash


function dvwa() {
    apt update -y && apt upgrade
    apt install apache2 -y
    systemctl enable apache2
    apt install mariadb-server -y
    apt install -y php libapache2-mod-php php-mysql php-mysqli -y
    apt install php-gd -y
    apt install -y git rsync
    echo "<?php phpinfo ();?>" | sudo tee /var/www/html/info.php
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE dvwa;
CREATE USER 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';
GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
    rm -r /var/www/html/index.html
    git clone https://github.com/ethicalhack3r/DVWA /tmp/DVWA
    rsync -avP /tmp/DVWA/ /var/www/html/
    cp /var/www/html/config/config.inc.php.dist /var/www/html/config/config.inc.php
    chown -R www-data.www-data /var/www/html/
    sudo sed -i "s/allow_url_include = Off/allow_url_include = On/" /etc/php/7.2/apache2/php.ini
    sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    systemctl restart apache2
    systemctl restart mysql
    systemctl reload sshd

}

dvwa

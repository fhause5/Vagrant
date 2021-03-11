#!/bin/bash

yum update -y
yum install -y docker vim wget

# OC
function OC {
    wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
    tar -xvf *.tar.gz
    cd openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit
    cp oc /usr/local/bin/
    cp oc kubectl /bin/
}
# Enable ssh password authentication
echo "[TASK 4] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd
systemctl enable docker
systemctl restart docker


# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc
OC
ip a



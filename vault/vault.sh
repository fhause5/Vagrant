#!/bin/bash

sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
service sshd restart
ip a | grep 192.168.


#!/bin/bash
sudo yum update -y
Sudo yum install httpd -y
Sudo systemctl start httpd
Sudo groupadd cloud
Sudo useradd michel -g cloud
sudo yum install docker -y
sudo usermod -aG docker ec2-user
sudo service docker start
sudo systemctl enable docker
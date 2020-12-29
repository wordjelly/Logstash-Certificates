#!/bin/bash

########## ONLY EXECUTE THIS SCRIPT IF YOU HAVE NOT ALREADY DOWNLOADED ELASTICSEARCH AND LOGSTASH #############
## zip unzip functionality.
sudo apt-get install zip unzip


########## INSTALL LOGSTASH AS A SYSTEM SERVICE
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list

sudo apt update

## linked test order creation.
## for eg if i select fasting + pp for a patient.
## will do background creation of three linked orders and show them.
## install 6.8.13
sudo apt install logstash

sudo apt install elasticsearch=6.8.3

## CLONE LOGSTASH CERTIFICATES GITHUB REPO(WORDJELLY)
cd /home
mkdir Github
cd /home/Github
gh clone https://github.com/wordjelly/Logstash-Certificates.git


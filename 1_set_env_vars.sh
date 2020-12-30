## SET ENV VARS REQUIRED IN THE CHECK_CERT_SCRIPT.
###################### *********** #######################
## IF YOU DID NOT DOWNLOAD ES AND LOGSTASH using the download_es_logstash.sh script in this repo, PLEASE SET THE THREE ENV VARS:
## SSL_CERTIFICATES_PATH : the path on your machine where you want to store the SSL CERTIFICATES.
## ELASTICSEARCH_PATH : the path where elasticsearch is installed : eg /home/Downloads/elasticsearch, and its bin directory is accessible.
## IP_ADDRESSES : comma seperated list of ip addresses on which the logstash server will run. 
###################### ************ ######################

## make this work from scratch on the server.
## and only then we restart
## the ip address thing is not working.
## cloud printing.
## THIS SCRIPT ASSUMES THAT YOU DOWNLOADED ES AND LOGSTASH USING THE DOWNLOAD_ES_LOGSTASH.SH FILE.

## SET THE PATH WHERE YOU WANT TO STORE THE SSL CERTIFICATES FOR LOGSTASH.
## for this we need to rewrite /etc/environment and ~.bashrc
mkdir /etc/logstash/certificates
echo 'export SSL_CERTIFICATES_PATH="/etc/logstash/certificates"' >> ~/.bashrc
echo 'export SSL_CERTIFICATES_PATH="/etc/logstash/certificates"' >> /etc/environment

## this path will be used to call the bin/certutil function of elasticsearch
## THEN EXPORT THE PATH FOR ELASTICSEARCH bin directories.
echo 'export ELASTICSEARCH_PATH="/usr/share/elasticsearch"' >> ~/.bashrc
echo 'export ELASTICSEARCH_PATH="/usr/share/elasticsearch"' >> /etc/environment

## Now since we are using digitalocean with IPV4, we need to export an IP addresses variable.
## get the IP address of the droplet.
IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
command="export IP_ADDRESSES=${IP},0.0.0.0"
echo "${command}" >> ~/.bashrc
echo "${command}" >> /etc/environment

source /etc/environment

echo 'export LOGSTASH_PORT=1443'
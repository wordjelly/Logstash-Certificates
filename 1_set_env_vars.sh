## SET ENV VARS REQUIRED IN THE CHECK_CERT_SCRIPT.
###################### *********** #######################
## IF YOU DID NOT DOWNLOAD ES AND LOGSTASH using the download_es_logstash.sh script in this repo, PLEASE SET THE THREE ENV VARS:
## SSL_CERTIFICATES_PATH : the path on your machine where you want to store the SSL CERTIFICATES.
## ELASTICSEARCH_PATH : the path where elasticsearch is installed : eg /home/Downloads/elasticsearch, and its bin directory is accessible.
## IP_ADDRESSES : comma seperated list of ip addresses on which the logstash server will run. 
###################### ************ ######################

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
IP=$(ifconfig eth0 |grep "inet "|awk '{print $2}')

echo 'export IP_ADDRESSES="$IP"'
#!/bin/bash
IP=${LOGSTASH_SERVER_IP_ADDRESS:-0.0.0.0} 
curl -v --cacert $SSL_CERTIFICATES_PATH/ssl_certificates/ca/ca.crt --key $SSL_CERTIFICATES_PATH/ssl_certificates/host/host.key --cert $SSL_CERTIFICATES_PATH/ssl_certificates/host/host.crt  https://$IP:$LOGSTASH_PORT

#!/bin/bash
IP=${IP_ADDRESS:-0.0.0.0} 
curl -v --cacert $LOGSTASH_PATH/ssl_certificates/ca/ca.crt --key $LOGSTASH_PATH/ssl_certificates/host/host.key --cert $LOGSTASH_PATH/ssl_certificates/host/host.crt  https://$IP:$LOGSTASH_PORT

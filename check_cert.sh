#!/bin/bash

curl -v --cacert $LOGSTASH_PATH/ssl_certificates/ca/ca.crt --key $LOGSTASH_PATH/ssl_certificates/host/host.key --cert $LOGSTASH_PATH/ssl_certificates/host/host.crt  https://$IP_ADDRESS:$LOGSTASH_PORT

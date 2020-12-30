#!/bin/bash
LOGSTASH_PATH=${LOGSTASH_PATH:-/etc/logstash/conf.d} 
echo "using logstash configuration path as "
echo $LOGSTASH_PATH
cp ./logstash_ssl.conf $LOGSTASH_PATH
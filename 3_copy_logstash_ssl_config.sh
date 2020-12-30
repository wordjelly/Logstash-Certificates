#!/bin/bash
LOGSTASH_PATH=${LOGSTASH_PATH:-/etc/logstash/conf.d} 
echo "using logstash configuration path as "
echo $LOGSTASH_PATH
value=`cat ./logstash_ssl.conf`
ESCAPED_REPLACE=$(printf '%s\n' "$SSL_CERTIFICATES_PATH" | sed -e 's/[\/&]/\\&/g')
value=$(echo "$value" | sed "s/\${LOGSTASH_PORT}/$LOGSTASH_PORT/g")
value=$(echo "$value" | sed "s/\${SSL_CERTIFICATES_PATH}/$ESCAPED_REPLACE/g")
echo $value
echo $value > $LOGSTASH_PATH/logstash_ssl.conf

#!/bin/bash
ES_HOST=${ES_HOST:-http://locahost:9200} 
ES_USER=${ES_USER:-}
ES_PASSWORD=${ES_PASSWORD:-}
ES_INDEX=${ES_INDEX:-logstash-logs}
EMAIL_TO=${EMAIL_TO:-root@127.0.0.1}
EMAIL_FROM=${EMAIL_FROM:-root@127.0.0.1}
EMAIL_SUBJECT=${EMAIL_SUBJECT:-Logs}
LOGSTASH_PATH=${LOGSTASH_PATH:-/etc/logstash/conf.d}
echo "using es host: "
echo $ES_HOST
echo "using es user: "
echo $ES_USER
echo "using ES PASSWORD: "
echo $ES_PASSWORD 
echo "using ES LOGS INDEX:"
echo $ES_INDEX
echo "using EMAIL LOGS TO:"
echo $EMAIL_TO
echo "using EMAIL LOGS FROM:"
echo $EMAIL_FROM
echo "email EMAIL LOGS SUBJECT"
echo $EMAIL_SUBJECT
echo "using logstash configuration path as "
echo $LOGSTASH_PATH
value=`cat ./logstash_ssl.conf`
ESCAPED_REPLACE=$(printf '%s\n' "$SSL_CERTIFICATES_PATH" | sed -e 's/[\/&]/\\&/g')
value=$(echo "$value" | sed "s/\${LOGSTASH_PORT}/$LOGSTASH_PORT/g")
value=$(echo "$value" | sed "s/\${ES_HOST}/$ES_HOST/g")
value=$(echo "$value" | sed "s/\${ES_USER}/$ES_USER/g")
value=$(echo "$value" | sed "s/\${ES_PASSWORD}/$ES_PASSWORD/g")
value=$(echo "$value" | sed "s/\${EMAIL_FROM}/$EMAIL_FROM/g")
value=$(echo "$value" | sed "s/\${EMAIL_TO}/$EMAIL_TO/g")
value=$(echo "$value" | sed "s/\${SSL_CERTIFICATES_PATH}/$ESCAPED_REPLACE/g")
echo $value
echo $value > $LOGSTASH_PATH/logstash_ssl.conf


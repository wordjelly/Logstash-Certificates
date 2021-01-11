#!/bin/bash
ES_HOST=${ES_HOST:-http://localhost:9200} 
ES_USER=${ES_USER:-}
ES_PASSWORD=${ES_PASSWORD:-}
ES_INDEX=${ES_INDEX:-logstash-logs}
EMAIL_LOGS_TO=${EMAIL_LOGS_TO:-root@127.0.0.1}
EMAIL_LOGS_FROM=${EMAIL_LOGS_FROM:-root@127.0.0.1}
EMAIL_LOGS_SUBJECT=${EMAIL_LOGS_SUBJECT:-Logs}
EMAIL_PORT=${EMAIL_PORT:-1025}
LOGSTASH_CONFIG_PATH=${LOGSTASH_CONFIG_PATH:-/etc/logstash/conf.d}
echo "using es host: "
echo $ES_HOST
echo "using es user: "
echo $ES_USER
echo "using ES PASSWORD: "
echo $ES_PASSWORD 
echo "using ES LOGS INDEX:"
echo $ES_INDEX
echo "using EMAIL LOGS TO:"
echo $EMAIL_LOGS_TO
echo "using EMAIL LOGS FROM:"
echo $EMAIL_LOGS_FROM
echo "email EMAIL LOGS SUBJECT"
echo $EMAIL_LOGS_SUBJECT
echo "using logstash configuration path as "
echo $LOGSTASH_CONFIG_PATH
value=`cat ./logstash_ssl.conf`

value=$(echo "$value" | sed "s/\${LOGSTASH_PORT}/$LOGSTASH_PORT/g")

ES_HOST_ESCAPED=$(printf '%s\n' "$ES_HOST" | sed -e 's/[\/&]/\\&/g')
value=$(echo "$value" | sed "s/\${ES_HOST}/$ES_HOST_ESCAPED/g")

value=$(echo "$value" | sed "s/\${ES_USER}/$ES_USER/g")

value=$(echo "$value" | sed "s/\${ES_INDEX}/$ES_INDEX/g")

value=$(echo "$value" | sed "s/\${EMAIL_PORT}/$EMAIL_PORT/g")

value=$(echo "$value" | sed "s/\${ES_PASSWORD}/$ES_PASSWORD/g")
value=$(echo "$value" | sed "s/\${EMAIL_LOGS_FROM}/$EMAIL_LOGS_FROM/g")
value=$(echo "$value" | sed "s/\${EMAIL_LOGS_TO}/$EMAIL_LOGS_TO/g")

value=$(echo "$value" | sed "s/\${EMAIL_LOGS_SUBJECT}/$EMAIL_LOGS_SUBJECT/g")

ESCAPED_REPLACE=$(printf '%s\n' "$SSL_CERTIFICATES_PATH" | sed -e 's/[\/&]/\\&/g')
value=$(echo "$value" | sed "s/\${SSL_CERTIFICATES_PATH}/$ESCAPED_REPLACE/g")

echo $value
echo $value > $LOGSTASH_CONFIG_PATH/logstash_ssl.conf



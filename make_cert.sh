#!/bin/bash
echo "LOGSTASH PATH : ${LOGSTASH_PATH}"
rm -r $LOGSTASH_PATH/ssl_certificates
mkdir $LOGSTASH_PATH/ssl_certificates
$ELASTICSEARCH_PATH/bin/elasticsearch-certutil cert --name host --ip $IP_ADDRESS --out $LOGSTASH_PATH/ssl_certificates/certificates.zip  --keep-ca-key --pem
unzip $LOGSTASH_PATH/ssl_certificates/certificates.zip -d $LOGSTASH_PATH/ssl_certificates

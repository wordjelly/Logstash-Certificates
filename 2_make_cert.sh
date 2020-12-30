#!/bin/bash
rm -r $SSL_CERTIFICATES_PATH/ssl_certificates
mkdir $SSL_CERTIFICATES_PATH/ssl_certificates
$ELASTICSEARCH_PATH/bin/elasticsearch-certutil cert --name host --ip $IP_ADDRESSES --out $SSL_CERTIFICATES_PATH/ssl_certificates/certificates.zip  --keep-ca-key --pem
unzip $SSL_CERTIFICATES_PATH/ssl_certificates/certificates.zip -d $SSL_CERTIFICATES_PATH/ssl_certificates

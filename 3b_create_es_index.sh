#!/bin/bash
ES_HOST=${ES_HOST:-http://localhost:9200} 
ES_USER=${ES_USER:-elastic}
ES_PASSWORD=${ES_PASSWORD:-}
ES_INDEX=${ES_INDEX:-logstash-logs}

echo $ES_HOST
echo $ES_USER
echo $ES_PASSWORD
echo $ES_INDEX
############# UPDATE ELASTICSEARCH INDEX MAPPINGS ###############

echo "creating logstash logs elasticsearch index ---" 

full_host="https://${ES_USER}:${ES_PASSWORD}@${ES_HOST}"
echo "full host ${full_host}"
echo "deleting index"
curl -X DELETE "${full_host}/${ES_INDEX}?pretty"

echo "creating index"
curl -X PUT "${full_host}/${ES_INDEX}?pretty" -H 'Content-Type: application/json' -d'
{}
'

echo "putting"
curl -X PUT "${full_host}/${ES_INDEX}/_mapping/doc?pretty" -H 'Content-Type: application/json' -d'
{
  "properties": {
    "status": {
      "type": "integer"
    },
    "tags" : {
    	"type" : "keyword"
    },
    "message": {
	"type" : "keyword"
    },
    "params" : {
    	"type" : "keyword"
    }
  }
}
'

echo "make sure you recreate your kibana index pattern, to see the new properties!"

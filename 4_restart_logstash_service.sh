#!/bin/bash
echo "stopping logstash service if its running"
sudo systemctl stop logstash.service

echo "restarting logstash service"
sudo systemctl start logstash.service

echo "started logstash service."
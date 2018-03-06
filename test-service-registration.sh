#!/bin/bash
wget https://releases.hashicorp.com/consul/1.0.6/consul_1.0.6_linux_amd64.zip
unzip consul_1.0.6_linux_amd64.zip 
consul agent -retry-join 192.168.99.100 -advertise 192.168.0.1 -data-dir /tmp/consul -config-file services.json

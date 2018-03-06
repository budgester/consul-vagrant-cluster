#!/bin/bash
 
# update and unzip
dpkg -s unzip &>/dev/null || {
 apt-get -y update && apt-get install -y unzip
}

if [ ! -f /home/ubuntu/consul ]; then 
  # install consul 
  cd /home/ubuntu
  version='1.0.6'
  wget https://releases.hashicorp.com/consul/${version}/consul_${version}_linux_amd64.zip -O consul.zip
  unzip consul.zip
  # make consul executable
  rm consul.zip
  chmod +x consul
  mv consul /usr/local/bin/. 
fi

cp /vagrant/consul.service /etc/systemd/system/consul.service

if [ ! -d /etc/systemd/system/consul.d ]; then 
  mkdir /etc/systemd/system/consul.d
fi

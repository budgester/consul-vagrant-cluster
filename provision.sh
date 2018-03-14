#!/bin/bash
 
# update and unzip
yum update -y && yum install -y unzip && yum install -y wget

if [ ! -f /usr/local/bin/consul ]; then 
  # install consul 
  cd /home/vagrant
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

if [ ! -f /usr/local/bin/vault ]; then 
  # install vault 
  cd /home/vagrant
  version='0.9.5'
  wget https://releases.hashicorp.com/vault/${version}/vault_${version}_linux_amd64.zip -O vault.zip
  unzip vault.zip
  # make consul executable
  rm vault.zip
  chmod +x vault
  mv vault /usr/local/bin/. 
fi

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
   -keyout /etc/ssl/certs/vault.key \
   -out /etc/ssl/certs/vault.crt \
   -subj "/C=GB/ST=London/L=London/O=Open Banking/OU=IT Department/CN=vault"

cp /vagrant/vault.service /etc/systemd/system/vault.service

if [ ! -d /etc/systemd/system/vault.d ]; then 
  mkdir /etc/systemd/system/vault.d
fi

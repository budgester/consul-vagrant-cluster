This createsa vagrant based consul/vault cluster based on the blog post

https://codeblog.dotsandbrackets.com/vagrant-create-consul-cluster/

To get up and running you will need

Virtualbox
Vagrant

Run

vagrant up

This will run up 3 machines. To see the servers run 'vagrant status'

budgester$ vagrant status

Current machine states:
consul-server-0           running (virtualbox)
consul-server-1           running (virtualbox)
consul-server-2           running (virtualbox)

Logon to one of the machines by running the command 'vagarant ssh consul-server-0'

You should then be able to run: 'consul members' to see that all the servers are alive an connected within the cluster.

[vagrant@consul-server-0 ~]$ consul members
Node             Address              Status  Type    Build  Protocol  DC   Segment
consul-server-0  192.168.99.100:8301  alive   server  1.0.6  2         dc1  <all>
consul-server-1  192.168.99.101:8301  alive   server  1.0.6  2         dc1  <all>
consul-server-2  192.168.99.102:8301  alive   server  1.0.6  2         dc1  <all>


The IP address this will setup will be 192.168.99.100-102 and the consul UI will be available on
 http://192.168.99.100:8500/ui/

To run vault you will need to go through the following process once all the consul servers have joined the cluster and bootstrapped themselves.

On the first machine we will need to initialise and unseal vault and then the additional server we just need to unseal them

vagrant ssh consul-server-0
sudo service vault restart
sudo /usr/local/bin/vault server init -tls-skip-verify

Make a note of the keys securely as this is the master unsealing keys of the vault server.

sudo /usr/local/bin/vault operator unseal -tls-skip-verify

Run this 3 times and enter a different key each time. 

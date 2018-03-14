def create_consul_host(config, hostname, ip, initJson)
  config.vm.define hostname do |host|
 
  config.vm.box = "ubuntu/xenial64"
    host.vm.hostname = hostname
    host.vm.provision "shell", path: "provision.sh"
 
    host.vm.network "private_network", ip: ip
    host.vm.provision "shell", inline: "echo '#{initJson}' > /etc/systemd/system/consul.d/init.json"
    host.vm.provision "shell", inline: "service consul start"
  end
end

 

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  serverIp = "192.168.99.100"
  for host_number in 0..2
    hostname="consul-server-#{host_number}"
    clientIp="192.168.99.10#{host_number}"
    clientInit = %(
      {
        "server": true,
        "ui": true,
        "advertise_addr": "#{clientIp}",
        "client_addr": "#{clientIp} 127.0.0.1",
        "retry_join": ["#{serverIp}"],
        "data_dir": "/tmp/consul",
        "bootstrap_expect": 3
      }
    )
    create_consul_host config, hostname, clientIp, clientInit
  end
end

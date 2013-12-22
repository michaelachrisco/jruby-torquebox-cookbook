# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "catalog"
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  
  config.vm.define "primary" do |primary|
      primary.vm.box = "precise32"
      primary.vm.network "forwarded_port", guest: 8080, host: 1234
  end

  config.vm.define "secondary" do |secondary|
    secondary.vm.box = "precise32"
    secondary.vm.network "forwarded_port", guest: 8080, host: 1235
  end
    
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "dummy"
  config.vm.provider :aws do |aws, override|
      aws.tags= {
            'Name' => 'demo'
          }
      aws.security_groups = ["web"]    
      aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
      aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
      override.ssh.private_key_path = ENV['AWS_PRIVATE_KEY_PATH']
      aws.keypair_name = ENV['AWS_KEYPAIR_NAME']
      aws.ami = "ami-c5a98cac" 
      aws.instance_type = "m1.medium"
      override.ssh.username = "ubuntu"
      aws.instance_ready_timeout = 300
  end
  
  config.vm.provider :digital_ocean do |provider|
      provider.client_id = ENV['CLIENT_ID']
      provider.api_key = ENV['API_KEY']
      provider.image = "Ubuntu 12.10 x64"
      provider.region = "New York 2"
      provider.size ="512MB"
  end
  
  
end
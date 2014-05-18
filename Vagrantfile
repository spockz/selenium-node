# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|


  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.ssh.forward_agent = true
  config.vm.network "public_network"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  # config.vm.provider :aws do |aws, override|
  #   aws.access_key_id = 'XXXX'      # Replace this
  #   aws.secret_access_key = 'XXXX'  # Replace this
  #   aws.keypair_name = 'XXXX'       # Replace this
  #   aws.ami = 'ami-7747d01e'        # ubuntu 12.04
  #   override.ssh.username = 'ubuntu'
  #   override.ssh.private_key_path = '~/.ssh/amazon-ubuntu.pem'
  # end

  config.vm.provision :shell, :path => "setup.sh"
  # config.vm.network :forwarded_port, guest:4444, host:4444

end

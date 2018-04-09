# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

# Vagrant.configure(2) do |config|
#   config.vm.box = 'ctg-baseline-virtualbox-v1.0.1.rhel-6.7-x86_64'
#   config.vm.box_url = 'https://s3-us-west-2.amazonaws.com/ctgdevops-software/vagrant/1.0.1/ctg-baseline-virtualbox-v1.0.1.rhel-6.7-x86_64.box'
#
#   # Create a forwarded port mapping which allows access to a specific port
#   # within the machine from a port on the host machine. In the example below,
#   # accessing "localhost:8079" will access port 80 on the guest machine.
#   config.vm.network 'forwarded_port', guest: 80, host: 80
#
#   config.omnibus.chef_version = '11.18.12'
# end

Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  config.vm.provision 'shell', inline: <<-SHELL
#!/bin/bash
SHELL
end

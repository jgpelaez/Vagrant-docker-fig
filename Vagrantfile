# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Limitate the resources used by our VMs
  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = 1024
    v.cpus = 2
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]
  end


  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

   # Use vagrant cachier if it is available - it will speed up repeated 
    # 'vagrant destroy' and 'vagrant up' calls
    if Vagrant.has_plugin?("vagrant-cachier")
      # monkey-patch / disable the :apt_lists bucket until this is fixed:
      # https://github.com/fgrehm/vagrant-cachier/issues/113
      module VagrantPlugins
        module Cachier
          class Bucket
            class AptLists < Bucket
              def self.capability
                :none
              end
            end
          end
        end
      end
      config.cache.scope = :box
    end

  # Multiple machines can be defined within the same project Vagrantfile
  # using the config.vm.define method call.
  config.vm.define "vm_with_docker" do |vdocker|

    # Install the latest version of Docker
    vdocker.vm.provision "shell", inline: <<SH
      # If you'd like to try the latest version of Docker:
      # First, check that your APT system can deal with https URLs:
      # the file /usr/lib/apt/methods/https should exist.
      # If it doesn't, you need to install the package apt-transport-https.
      [ -e /usr/lib/apt/methods/https ] || {
      apt-get -y update
      apt-get -y install apt-transport-https
      }
      # Then, add the Docker repository key to your local keychain.
      sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
      # Add the Docker repository to your apt sources list,
      # update and install the lxc-docker package.
      # You may receive a warning that the package isn't trusted.
      # Answer yes to continue installation.
      if [ -f /etc/default/docker ]; then
      	cp /etc/default/docker /etc/default/docker.backup
      fi
      sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
      apt-get -y update
      apt-get -y install lxc-docker
  	  # Add vagrant user to the docker group
      usermod -a -G docker vagrant
SH

    # Create config folder
    vdocker.vm.provision "shell", inline: <<SH
    	mkdir /home/vagrant/vmconfig
    	chmod 777 /home/vagrant/vmconfig
SH

	vdocker.vm.provision :file do |file|
	    file.source      = './vmconfig/smb.partial.conf'
	    file.destination = '/home/vagrant/vmconfig/smb.partial.conf'
	end
	
    # Install GIT and Fig
    vdocker.vm.provision "shell", inline: <<SH
      # It is easiest to install Git on Linux using the preferred
      # package manager of your Linux distribution.
      # Debian/Ubuntu
      # $ apt-get install git
      # apt-get -y install git
      # Installing Fig
      curl -L https://github.com/orchardup/fig/releases/download/0.5.2/linux > /usr/local/bin/fig
      chmod +x /usr/local/bin/fig
SH


    # Install samba
    vdocker.vm.provision "shell", inline: <<SH
      # $ apt-get install git
      echo "Setting samba config"
      sudo apt-get -y install samba      
      mkdir /home/vagrant/git
      mkdir /home/vagrant/data
      chmod +rw /home/vagrant/git
      chmod +rw /home/vagrant/data
      # TODO download a file from git and concat cat /etc/samba/smb.conf
      cat /home/vagrant/vmconfig/smb.partial.conf >> /etc/samba/smb.conf
      echo "Access from windows \\\\192.168.59.103\\data"
      echo "Access from windows \\\\192.168.59.103\\git"
      echo "Access from windows \\\\192.168.59.103\\vmconfig"
SH

    vdocker.vm.network :private_network, ip: "192.168.59.103"

  end

end

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
  config.vm.define "vm_with_dockers" do |vdocker|

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
      sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
      apt-get -y update
      apt-get -y install lxc-docker
SH

    # Install GIT and Fig
    vdocker.vm.provision "shell", inline: <<SH
      # It is easiest to install Git on Linux using the preferred
      # package manager of your Linux distribution.
      # Debian/Ubuntu
      # $ apt-get install git
      apt-get -y install git
      # Automatically chdir to vagrant directory upon 
      echo "\n\ncd /home/vagrant/mnt\n" >> /home/vagrant/.bashrc
      # Installing Fig
      curl -L https://github.com/orchardup/fig/releases/download/0.5.2/linux > /usr/local/bin/fig
      chmod +x /usr/local/bin/fig
SH

    # Install samba
    vdocker.vm.provision "shell", inline: <<SH
      # $ apt-get install git
      sudo apt-get -y install samba
      mkdir /data
      # TODO download a file from git and concat cat /etc/samba/smb.conf
      echo "[data]" >> /etc/samba/smb.conf
      echo "comment = Local Dev Server - /data" >> /etc/samba/smb.conf
      echo "path = /data" >> /etc/samba/smb.conf
      echo "browsable = yes" >> /etc/samba/smb.conf
      echo "guest ok = yes" >> /etc/samba/smb.conf
      echo "read only = no" >> /etc/samba/smb.conf
      echo "create mask = 0777" >> /etc/samba/smb.conf
      echo "force user = root" >> /etc/samba/smb.conf
      echo "force group = root" >> /etc/samba/smb.conf
      echo "#[data] End" >> /etc/samba/smb.conf
      echo "Access from windows \\192.168.59.103\data
SH

    vdocker.vm.network "forwarded_port", guest: 8282, host: 8282
    # Since we mount the dir using NFS we need a private network
    vdocker.vm.network :private_network, ip: "192.168.59.103"
    # Using NFS because some shits, such as Mongod, don't know how to deal with some flavors of partition system
    # vdocker.vm.synced_folder ".", "/home/vagrant/mnt", :nfs => false, :mount_options => ['nolock,vers=3,udp']

	#  vdocker.vm.synced_folder ".", "/vagrant", type: "smb"
  end


end

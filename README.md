#Vagrant-docker-fig


A Vagrant file with Ubuntu trusty64, the latest Docker release, the latest Fig release, and Git

##What's inside ?

 - Ubuntu 14.04 LTS (trusty).  
 - the latest Docker release  ([https://docs.docker.com/](https://docs.docker.com/))  
 - Fig 0.5.2                 ([http://orchardup.github.io/fig/](http://orchardup.github.io/fig/))  
 - Git (through apt-get)  

##Network

IP [`192.168.59.103`][ip]  
 

The folders (/home/vagrant/git, /home/vagrant/data, /home/vagrant/vmconfig) are shared with the host using samba.

Or on Windows, use Explorer to Connect to:

\\192.168.59.103\data
\\192.168.59.103\git  
\\192.168.59.103\vmconfig

Connect to the shared folder using Finder (OS X):

	Connect to cifs://192.168.59.103/data
	Once mounted, will appear as /Volumes/data  

## Executions

Installs the proxyconf plugin:

	install-vagrant-proxyconf.cmd
	
Vagrant up:

	vagrantup.cmd


## CPU/RAM

[2 CPU][ncpu]  
[CPU cap at 70%][cpuc]  
[1024 Mo RAM][ram]  

[mnt]: https://github.com/Micka33/Vagrant-docker-fig/blob/master/Vagrantfile#L63
[nfs]: https://github.com/Micka33/Vagrant-docker-fig/blob/master/Vagrantfile#L63
[ip]:  https://github.com/Micka33/Vagrant-docker-fig/blob/master/Vagrantfile#L61
[port]:https://github.com/Micka33/Vagrant-docker-fig/blob/master/Vagrantfile#L59
[ncpu]:https://github.com/Micka33/Vagrant-docker-fig/blob/master/Vagrantfile#L12
[cpuc]:https://github.com/Micka33/Vagrant-docker-fig/blob/master/Vagrantfile#L13
[ram]: https://github.com/Micka33/Vagrant-docker-fig/blob/master/Vagrantfile#L11

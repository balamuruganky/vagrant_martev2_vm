# vagrant_martev2_vm
Vagrant AlmaLinux 8.9 VM creation for martev2 workspace for development purpose

## System requirements
* CPU : Atleast 4 [2 CPUs are for VM]
* Memory : Atleast 4GB [2GB for VM]

## How to setup NFS server in host machine
* Please follow the instructions [https://developer.hashicorp.com/vagrant/docs/synced-folders/nfs]

## How to create VM
* Install Oracle VirtualBox [https://www.virtualbox.org/wiki/Downloads]
* Install Vagrant [https://developer.hashicorp.com/vagrant/install]
* git clone https://github.com/balamuruganky/vagrant_martev2_vm
* cd vagrant_martev2_vm
* vagrant up

## How to use KVM on Linux instead of using Oracle VirtualBox
* Install Vagrant [https://developer.hashicorp.com/vagrant/install]
* git clone https://github.com/balamuruganky/vagrant_martev2_vm
* cd vagrant_martev2_vm
* vagrant up --provider libvirt

## How to login to VM
* vagrant ssh

## How to shutdown the VM
* vagrant halt

## How to destroy the VM
* vagrant destroy

## Network
This VM has no public IP assigned. Please use "nmtui" utility in AlmaLinux VM to configure the network.

## Useful links
* https://developer.hashicorp.com/vagrant/docs/providers
* https://developer.hashicorp.com/vagrant/docs/plugins


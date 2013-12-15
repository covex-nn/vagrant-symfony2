Vagrant Symfony2 basebox
========================

* First of all use [packer-template](https://github.com/covex-nn/packer-templates) to create `ubuntu1204` basebox box
* Run `vagrant package` to create vagrant box for Symfony2
* Run `vagrant box add symfony-ubuntu1204-x64 package.box` to add box to your system

Base box
--------

* MySQL 5.5
* PHP 5.3 with `mysql`, `sqlite`, `intl`, `xsl`, `xmlrpc`, `mcrypt`, `gd`, `curl` and `xdebug` extensions
* Ant

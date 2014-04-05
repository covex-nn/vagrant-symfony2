Vagrant Symfony2 basebox
========================

* First of all use [packer-template](https://github.com/covex-nn/packer-templates) to create `ubuntu1204` basebox box
* Run `vagrant destroy`, `vagrant up`, `vagrant halt` and `vagrant package` to create vagrant box for Symfony2
* Run `vagrant box add symfony-ubuntu1204-x64 package.box` to add box to your system

Base box
--------

* MySQL 5.5
* PHP 5.3 with `apc`, `mysql`, `sqlite`, `intl`, `xsl`, `xmlrpc`, `mcrypt`, `gd`, `curl` and `xdebug` extensions
* Composer
* PEAR with PHPUnit
* Apache2
* phpMyAdmin
* Ant
* Ruby with `compass` and `sass` gems
* nfs-common
* Sass 3.2.9, Compass 0.12.2

Usage example
-------------

https://github.com/apnet/symfony-standard-edition

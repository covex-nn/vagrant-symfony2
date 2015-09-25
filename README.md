Vagrant Symfony2 basebox
========================

Usage
-----

```
Vagrant.configure("2") do |config|
  config.vm.box = "covex/symfony-ubuntu1404-x64"
  config.vm.box_version = ">= 3.1.0"
end
```

or

```
Vagrant.configure("2") do |config|
  config.vm.box = "covex/symfony-ubuntu1204-x64"
  config.vm.box_version = ">= 2.3.0"
end
```

Contents
--------

* Apache 2.4 with HTTPS support for *.local sites
* MySQL 5.5
* PHP 5.5.9 with `apc`, `mysql`, `sqlite`, `intl`, `xsl`, `xmlrpc`, `mcrypt`, `gd`, `curl` and `xdebug` extensions
* Composer
* PHPUnit 4.6.5 and PHP_CodeSniffer 2.3.1
* phpMyAdmin
* Ruby 1.9.3
* Ant
* Nfs-common and Samba

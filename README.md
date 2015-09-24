Vagrant Symfony2 basebox
========================

Usage
-----

```
Vagrant.configure("2") do |config|
  config.vm.box = "covex/symfony-ubuntu1204-x64"
  config.vm.box_version = ">= 2.3.0"
end
```

Contents
--------

* Apache2 with HTTPS support for *.local sites
* MySQL 5.5
* PHP 5.3.10 with `apc`, `mysql`, `sqlite`, `intl`, `xsl`, `xmlrpc`, `mcrypt`, `gd`, `curl` and `xdebug` extensions
* Composer
* PHPUnit 4.6.5 and PHP_CodeSniffer 2.3.0s
* phpMyAdmin
* Ruby 1.9.1
* Ant
* Nfs-common and Samba

Vagrant Symfony2 basebox
========================

Usage
-----

```
Vagrant.configure("2") do |config|
  config.vm.box = "covex/symfony-ubuntu1204-x64"
  config.vm.box_version = ">= 2.1.3"
end
```

Contents
--------

* Apache2
* MySQL 5.5
* PHP 5.3.10 with `apc`, `mysql`, `sqlite`, `intl`, `xsl`, `xmlrpc`, `mcrypt`, `gd`, `curl` and `xdebug` extensions
* Composer
* PHPUnit 4.6.5 and PHP_CodeSniffer 2.3.0s
* phpMyAdmin
* Ruby with `sass-3.4.13`, `compass-1.0.3` and `bootstrap-sass-3.3.4` gems
* Ant
* Nfs-common and Samba

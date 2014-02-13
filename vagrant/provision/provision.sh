# provision.sh
#
# This file is specified in Vagrantfile and is loaded by Vagrant as the primary
# provisioning script whenever the commands `vagrant up`, `vagrant provision`,
# or `vagrant reload` are used. It provides all of the default packages and
# configurations included with Varying Vagrant Vagrants.

# Capture a basic ping result to Google's primary DNS server to determine if
# outside access is available to us. If this does not reply after 2 attempts,
# we try one of Level3's DNS servers as well. If neither of these IPs replies to
# a ping, then we'll skip a few things further in provisioning rather than
# creating a bunch of errors.
ping_result=`ping -c 2 8.8.4.4 2>&1`
if [[ $ping_result != *bytes?from* ]]
then
	ping_result=`ping -c 2 4.2.2.2 2>&1`
fi

# PACKAGE INSTALLATION
#
# Build a bash array to pass all of the packages we want to install to a single
# apt-get command. This avoids doing all the leg work each time a package is
# set to install. It also allows us to easily comment out or add single
# packages. We set the array as empty to begin with so that we can append
# individual packages to it as required.
apt_package_install_list=()

# Start with a bash array containing all packages we want to install in the
# virtual machine. We'll then loop through each of these and check individual
# status before adding them to the apt_package_install_list array.
apt_package_check_list=(
    ack
    mysql-server
    mysql-client
    php5
    php5-mysql
    php5-sqlite
    php5-intl
    php5-xsl
    php5-xmlrpc
    php5-mcrypt
    php5-gd
    php5-curl
    php5-xdebug
    php-pear
    php-apc
    phpmyadmin
    default-jdk
    ant
)

echo "Check for apt packages to install..."

# Loop through each of our packages that should be installed on the system. If
# not yet installed, it should be added to the array of packages to install.
for pkg in "${apt_package_check_list[@]}"
do
	package_version=`dpkg -s $pkg 2>&1 | grep 'Version:' | cut -d " " -f 2`
	if [[ $package_version != "" ]]
	then
		space_count=`expr 20 - "${#pkg}"` #11
		pack_space_count=`expr 30 - "${#package_version}"`
		real_space=`expr ${space_count} + ${pack_space_count} + ${#package_version}`
		printf " * $pkg %${real_space}.${#package_version}s ${package_version}\n"
	else
		echo " *" $pkg [not installed]
		apt_package_install_list+=($pkg)
	fi
done

# MySQL
#
# Use debconf-set-selections to specify the default password for the root MySQL
# account. This runs on every provision, even if MySQL has been installed. If
# MySQL is already installed, it will not affect anything.
#
echo mysql-server mysql-server/root_password password root | debconf-set-selections
echo mysql-server mysql-server/root_password_again password root | debconf-set-selections

if [[ $ping_result == *bytes?from* ]]
then
	# If there are any packages to be installed in the apt_package_list array,
	# then we'll run `apt-get update` and then `apt-get install` to proceed.
	if [ ${#apt_package_install_list[@]} = 0 ];
	then
		echo -e "No apt packages to install.\n"
	else
		# update all of the package references before installing anything
		echo "Running apt-get update..."
		apt-get update --assume-yes

		# install required packages
		echo "Installing apt-get packages..."
		apt-get install --assume-yes ${apt_package_install_list[@]}

		# Clean up apt caches
		apt-get clean
	fi
else
	echo -e "\nNo network connection available, skipping package installation"
fi

# Capture the current IP address of the virtual machine into a variable that
# can be used when necessary throughout provisioning.
#
vvv_ip=`ifconfig eth1 | ack "inet addr" | cut -d ":" -f 2 | cut -d " " -f 1`


echo -e "\nSetup MySQL configuration files..."
# Configuration for MySQL
cp /srv/config/my.cnf /etc/mysql/my.cnf
echo " * /srv/config/my.cnf -> /etc/mysql/my.cnf"

# MySQL gives us an error if we restart a non running service, which
# happens after a `vagrant halt`. Check to see if it's running before
# deciding whether to start or restart.
exists_mysql=`service mysql status`
if [ "mysql stop/waiting" == "$exists_mysql" ]
then
    echo "service mysql start"
    service mysql start
else
    echo "service mysql restart"
    service mysql restart
fi


echo -e "\nSetup Apache2 and PHP configuration files..."

cp /etc/phpmyadmin/apache.conf /etc/apache2/sites-available/010-phpmyadmin
chmod 644 /etc/apache2/sites-available/010-phpmyadmin
cp /srv/config/symfony2.local /etc/apache2/sites-available/100-symfony2
chmod 644 /etc/apache2/sites-available/100-symfony2
cp /srv/config/symfony2.ini /etc/php5/conf.d/symfony2.ini
chmod 644 /etc/php5/conf.d/symfony2.ini

a2enmod rewrite
a2enmod headers
a2ensite 010-phpmyadmin
a2ensite 100-symfony2
a2dissite default
service apache2 reload


echo -e "\nSetup composer..."
cd /tmp
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer


echo -e "\nSetup PHPUnit..."
pear channel-discover pear.phpunit.de
pear channel-discover pear.symfony.com
pear install --onlyreqdeps phpunit/PHPUnit

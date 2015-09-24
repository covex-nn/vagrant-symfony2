cp /etc/phpmyadmin/apache.conf /etc/apache2/sites-available/010-phpmyadmin
chmod 644 /etc/apache2/sites-available/010-phpmyadmin
cp /srv/config/symfony2.local /etc/apache2/sites-available/100-symfony2
chmod 644 /etc/apache2/sites-available/100-symfony2
cp /srv/config/symfony2.ini /etc/php5/conf.d/symfony2.ini
chmod 644 /etc/php5/conf.d/symfony2.ini
mkdir /etc/apache2/ssl
cp /srv/config/*.pem /etc/apache2/ssl
chmod 644 /etc/apache2/ssl/*.pem

a2enmod rewrite
a2enmod headers
a2enmod ssl
a2ensite 010-phpmyadmin
a2ensite 100-symfony2
a2dissite default
service apache2 reload

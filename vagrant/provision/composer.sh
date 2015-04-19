cd /tmp
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

mkdir --mode=700 /root/.composer
cp /srv/config/config.json /root/.composer/config.json
chmod 664 /root/.composer/config.json

mkdir /home/vagrant/.composer
cp /srv/config/composer.json /home/vagrant/.composer/composer.json
cp /srv/config/config.json /home/vagrant/.composer/config.json
chmod -R 664 /home/vagrant/.composer
chmod 755 /home/vagrant/.composer
chown -R vagrant:vagrant /home/vagrant/.composer
env HOME=/home/vagrant sudo -u vagrant composer global update
echo "export PATH=~/.composer/vendor/bin:\$PATH" >> /home/vagrant/.bashrc

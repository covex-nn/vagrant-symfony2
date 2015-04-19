mkdir /home/vagrant/share
chown vagrant:vagrant /home/vagrant/share
cp /srv/config/smb.conf /etc/samba/smb-vagrant-share.conf
chmod 644 /etc/samba/smb-vagrant-share.conf
echo "[public]" >> /etc/samba/smb.conf
echo "include = /etc/samba/smb-vagrant-share.conf" >> /etc/samba/smb.conf
service smbd restart

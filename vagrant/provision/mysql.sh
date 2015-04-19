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

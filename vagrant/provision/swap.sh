# @see https://getcomposer.org/doc/articles/troubleshooting.md#proc-open-fork-failed-errors
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
chmod 0600 /var/swap.1
/sbin/swapon /var/swap.1
echo '/var/swap.1 none swap defaults 0 0' >> /etc/fstab

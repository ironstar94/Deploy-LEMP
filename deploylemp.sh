#!/bin/bash
sudo apt-get update && sudo apt-get dist-upgrade -y
sudo ufw allow 80
sudo ufw allow 443
sudo apt-get install nginx apache2-utils mysql-server php php-fpm php-mcrypt php-mysql php-dom php-mbstring php-zip unzip -y
sudo mysql_secure_installation
sudo apt-get install fail2ban psad rkhunter chkrootkit -y
sudo groupadd admin
sudo usermod -a -G admin ken
sudo dpkg-statoverride --update --add root admin 4750 /bin/su
sudo su -c "echo 'tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0' >> /etc/fstab"
sudo su -c "echo 'nospoof on' >> /etc/host.conf"
find /var/www/html \( -type f -execdir chmod 644 {} \; \) \
                  -o \( -type d -execdir chmod 711 {} \; \)
sudo chown -R www-data:www-data /var/www/html
sudo service nginx restart
sudo chkrootkit
sudo rkhunter --update
sudo rkhunter --propupd
sudo rkhunter --check
sudo apt-get install wapiti -y
#wapiti http://example.org -n 10 -b folder
sudo ufw enable

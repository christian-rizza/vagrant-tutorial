#!/usr/bin/env bash

sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
sed -i '/^#.*force_color_prompt=yes/s/^#//' ./.bashrc
echo "cd /var/www/html/" >> ./.bashrc

printf "%$(tput cols)s\n"|tr " " "="
echo "Starting provisioning"
printf "%$(tput cols)s\n"|tr " " "="
echo "Updating package list..."
apt-get update  > /dev/null

echo "Installing Apache..."
apt-get install -y apache2  > /dev/null
echo "Installing Apache modules..."
apt-get install -y php5 > /dev/null
apt-get install -y php5-xdebug > /dev/null
echo "Installing MySql..."
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password vagrant'  > /dev/null
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password vagrant'  > /dev/null
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql  > /dev/null

echo "Configuring Apache for Vagrant..."
if ! [ -L /var/www ]; then
  rm -rf /var/www/*
  ln -fs /vagrant /var/www/html
fi
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
a2enmod rewrite
#Configuring XDebug
echo "zend_extension=xdebug.so">/etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_enable = on">>/etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = on">>/etc/php5/mods-available/xdebug.ini
service apache2 restart  > /dev/null

echo "Installing Git and dev tools..."
apt-get install -y git  > /dev/null

echo "Running Tutorial Configuration..."
bash /var/www/html/bootstrap-tutorial.sh

printf "%$(tput cols)s\n"|tr " " "="
echo "Provisioning completed"
printf "%$(tput cols)s\n"|tr " " "="
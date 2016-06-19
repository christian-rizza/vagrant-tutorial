#!/usr/bin/env bash

sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
sed -i '/^#.*force_color_prompt=yes/s/^#//' ./.bashrc
echo "cd /var/www/" >> ./.bashrc

printf "%$(tput cols)s\n"|tr " " "="
echo "Starting provisioning"
printf "%$(tput cols)s\n"|tr " " "="
echo "Updating package list..."
apt-get update  > /dev/null

echo "Installing Apache..."
apt-get install -y apache2  > /dev/null 2>&1
echo "Installing Apache modules..."
apt-get install -y php5 > /dev/null 2>&1
apt-get install -y php5-xdebug > /dev/null 2>&1
echo "Installing MySql..." 2>&1
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password vagrant'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password vagrant'
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql  > /dev/null 2>&1

echo "Configuring Apache for Vagrant..."
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sed -i 's#DocumentRoot /var/www/html#DocumentRoot /var/www/#' /etc/apache2/sites-available/000-default.conf
a2enmod rewrite > /dev/null 2>&1
#Configuring XDebug
echo "zend_extension=xdebug.so">/etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_enable = on">>/etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = on">>/etc/php5/mods-available/xdebug.ini
service apache2 restart  > /dev/null 2>&1

echo "Installing Git and dev tools..."
apt-get install -y git  > /dev/null 2>&1

echo "Running Tutorial Configuration..."
bash /var/www/bootstrap-tutorial.sh

printf "%$(tput cols)s\n"|tr " " "="
echo "Provisioning completed"
printf "%$(tput cols)s\n"|tr " " "="
#!/usr/bin/env bash

printf "%$(tput cols)s\n"|tr " " "="
echo "Tutorial Configuration"
printf "%$(tput cols)s\n"|tr " " "="

echo "Add NodeJS and Gulp..."
apt-get -y install npm nodejs-legacy > /dev/null 2>&1
npm install --global gulp-cli > /dev/null 2>&1

echo "Install Composer Globally..."
curl -s https://getcomposer.org/installer | php  > /dev/null 2>&1
mv composer.phar /usr/local/bin/composer  > /dev/null 2>&1
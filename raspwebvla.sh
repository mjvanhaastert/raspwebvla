##Raspberry pi webserver Civicrm Script

#!/bin/bash

#
#chmod +x raspwebvla.sh
#
#sudo ./raspwebvla.sh

echo "###################################################################################"
echo "Please be Patient: Installation will start now.......and it will take some time :)"
echo "###################################################################################"

#Update the repositories

sudo apt-get update

echo "###################################################################################"
echo "Installing apache2 , mysql server, phpmyadmin and client and all the plugins needed"
echo "###################################################################################"

apt-get install apache2
apt-get install php7.0-mysql php7.0-curl php7.0-json php7.0-cgi  php7.0 libapache2-mod-php7.0

#The following commands set the MySQL root password to WebVla-01! when you install the mysql-server package.

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password WebVla-01!'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password WebVla-01!'

apt-get install mysql-server mysql-client
mysql_secure_installation
apt-get install phpmyadmin

echo "###################################################################################"
echo "Creating a folder called drupal in the /home/ubuntu"
echo "Then downloading the drupal core files and modules"
echo "###################################################################################"

sudo mkdir /home/ubuntu/drupal
sudo mkdir /home/ubuntu/modules
cd /home/ubuntu/drupal/
sudo wget https://ftp.drupal.org/files/projects/drupal-7.55.tar.gz
tar -xvzf drupal-7.55.tar.gz
cd /home/ubuntu/modules
sudo wget https://ftp.drupal.org/files/projects/ckeditor-7.x-1.17.tar.gz
sudo wget https://ftp.drupal.org/files/projects/views-7.x-3.16.tar.gz
sudo wget https://ftp.drupal.org/files/projects/ctools-7.x-1.12.tar.gz
sudo wget https://ftp.drupal.org/files/projects/rules-7.x-2.10.tar.gz
sudo wget https://ftp.drupal.org/files/projects/webform-7.x-4.15.tar.gz
sudo wget https://ftp.drupal.org/files/projects/webform_civicrm-7.x-4.18.tar.gz
sudo wget https://ftp.drupal.org/files/projects/options_element-7.x-1.12.tar.gz
sudo wget https://ftp.drupal.org/files/projects/webform_layout-7.x-2.3.tar.gz
tar -xvzf *

echo "###################################################################################"
echo "Moving everything in the right place"
echo "###################################################################################"

mv -r ckeditor views ctools rules webform webform_civicrm options_element webform_layout -t /home/ubuntu/drupal/modules


#Restart all the installed services to verify that everything is installed properly

echo -e "\n"

service apache2 restart && service mysql restart > /dev/null

echo -e "\n"

if [ $? -ne 0 ]; then
   echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)
else
   echo "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi

echo -e "\n"

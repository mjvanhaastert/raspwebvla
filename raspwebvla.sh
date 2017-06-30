##Raspberry pi webserver Civicrm Script

#!/bin/bash

#
#chmod +x raspwebvla.sh
#
#sudo ./raspwebvla.sh

clear

echo "###################################################################################"
echo "###################################################################################"
echo "Please be Patient: Installation will start now.......and it will take some time :)"
echo "Keep a pen and paper by hand to write stuff down"
echo "###################################################################################"
echo "###################################################################################"

#Update the repositories

sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade
sudo apt-get -y --force-yes dist-upgrade

clear

echo "###################################################################################"
echo "###################################################################################"
echo "Installing apache2 , mysql server, phpmyadmin and client and all the plugins needed"
echo "It will ask you to make a username and password for mysql"
echo "###################################################################################"
echo "###################################################################################"

sudo apt-get -y --force-yes install apache2
sudo apt-get -y --force-yes install mysql-server mysql-client
sudo apt-get -y --force-yes install php7.0-mysql php7.0-curl php7.0-json php7.0-cgi  php7.0 libapache2-mod-php7.0
sudo apt-get -y --force-yes install phpmyadmin

mysql_secure_installation

clear

echo "###################################################################################"
echo "###################################################################################"
echo "phpmyadmin is installed and can be accessed by typing in the ip of the webserver"
echo "The username of phpmyadmin is root and the password you what you created"
echo "###################################################################################"
echo "###################################################################################"

sleep -s 10

clear

echo "###################################################################################"
echo "###################################################################################"
echo "Creating folders in the /home/ubuntu and downloading all the files you need for it"
echo "###################################################################################"
echo "###################################################################################"

sudo mkdir /home/ubuntu/civicrm
cd /home/ubuntu/civicrm
sudo wget https://download.civicrm.org/civicrm-4.7.20-drupal.tar.gz
sudo tar -xvzf civicrm-4.7.20-drupal.tar.gz
wget https://download.civicrm.org/civicrm-4.7.20-l10n.tar.gz
sudo tar xvzf civicrm-4.7.20-l10n.tar.gz
rm -r civicrm-4.7.20-drupal.tar.gz civicrm-4.7.20-l10n.tar.gz
sudo mkdir /home/ubuntu/drupal
sudo mkdir /home/ubuntu/modules
cd /home/ubuntu/drupal/
sudo wget https://ftp.drupal.org/files/projects/drupal-7.55.tar.gz
sudo tar -xvzf drupal-7.55.tar.gz
sudo rm -r drupal-7.55.tar.gz
cd drupal-7.55/profiles/standard/translations
sudo wget ftp.drupal.org/files/translations/7.x/drupal/drupal-7.55.nl.po
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
echo "###################################################################################"
echo "Moving everything in the right place"
echo "###################################################################################"
echo "###################################################################################"

cd /home/ubuntu/civicrm/
sudo mv -r civicrm /home/ubuntu/drupal/modules
sudo mv -r ckeditor views ctools rules webform webform_civicrm options_element webform_layout -t /home/ubuntu/drupal/modules
cd /home/ubuntu/drupal/drupal-7.55
sudo mv -r * /var/www/html

clear

echo "###################################################################################"
echo "###################################################################################"
echo "Drupal has bin moved to /var/www/html and can be accessed by typing in the ip of the webserver in your browers"
echo "There you can start installing drupal and setting up a admin account"
echo "###################################################################################"
echo "###################################################################################"

sleep -s 10

clear



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

echo "###################################################################################"
echo "###################################################################################"
echo "------------------------------Time to reboot the server----------------------------
echo "###################################################################################"
echo "###################################################################################"

sudo reboot

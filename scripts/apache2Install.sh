#!/bin/bash
echo "Checking the apache2 status"
sudo systemctl status apache2 > /dev/null 2>&1
if [ $? -gt 0 ]; then
   echo "Updating the apt repository"
   sudo apt -y update > /dev/null 2>&1
   echo "Installing Apache2"
   sudo apt install -y apache2 > /dev/null 2>&1
   echo "Enabling apache2"
   sudo systemctl enable apache2 > /dev/null 2>&1
   echo "---------------------------------------------------------------------------"
   echo "Apache2 installation completed and moving to next step to enable modules"
   echo "---------------------------------------------------------------------------"
   echo "Enabling Apache Header module"
   sudo a2enmod headers > /dev/null 2>&1
   echo "Enabling proxy http module"
   sudo a2enmod proxy_http > /dev/null 2>&1
   sudo systemctl restart apache2
   echo "Modules enabling is completed"
else
   echo " Apache2 is already installed"
fi
echo "Checking node version"
sudo node -v > /dev/null 2>&1
if [ $? -gt 0 ]; then
   echo "Nodejs is not found, installing Nodejs and npm"
   sudo apt install -y nodejs >/dev/null 2>&1
   echo "Nodejs installation is completed"
   sudo apt install -y npm >/dev/null 2>&1
   echo "npm istallation completed"
   echo "---------------------------------------------------------------------------------"
   echo "Nodejs version is"
   sudo node -v
   echo "npm version is"
   sudo npm -v
   echo "---------------------------------------------------------------------------------"
else
   echo "Nodejs and NPM is already installed"
fi

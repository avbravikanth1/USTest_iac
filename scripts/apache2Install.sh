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
   echo "--------------------------------------------"
   echo "Apache2 is installed and ready to use. Good to go"
   echo "--------------------------------------------"
else
   echo " Apache2 is already installed"
fi

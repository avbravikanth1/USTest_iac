#!/bin/bash
echo "Checking the apache2 status"
sudo systemctl status apache2 1> /dev/null
if [ $? -gt 0 ]; then
   echo " Updating the apt repository"
   sudo apt -y update 1> /dev/null
   echo "Installing Apache2"
   sudo apt install -y apache2 1> /dev/null
   sudo systemctl enable apache2
else
   echo " Apache2 is already installed"
fi

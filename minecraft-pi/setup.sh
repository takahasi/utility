#!/bin/bash

sudo apt-get -y install bsdiff

cd /opt/minecraft-pi

sudo wget https://www.dropbox.com/s/iutdy9yrtg3cgic/survival.bsdiff
sudo bspatch minecraft-pi mcpipatched survival.bsdiff
sudo chmod +x mcpipatched
echo "Patched /opt/minecraft-pi/mcpipatched"

sudo sed -e 's/\.\/minecraft-pi/\.\/mcpipatched/g' /usr/bin/minecraft-pi > /usr/bin/minecraft-pi-survival
sudo chmod +x /usr/bin/minecraft-pi-survival
echo "Generate /usr/bin/minecraft-pi-survival"

cd -

exit 0

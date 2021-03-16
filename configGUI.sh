#!/bin/bash
#########################################################
# to run this script                                    #
# you should have exec right                            #
# $ sudo chmod 777 configGUI.sh                         #
#                                                       #
#########################################################

sudo apt remove xserver-xorg-core-hwe-18.04 xserver-xorg-input-all-hwe-18.04 linux-generic-hwe-18.04 xserver-xorg-video-all-hwe-18.04 -y
sudo apt-get purge xdg-desktop-portal -y
sudo apt-get purge xdg-desktop-portal-gtk -y
sudo apt autoremove apt-rdepends -y
#install xorg
sudo apt install gnome-session -y
sudo apt-get install xorg -y
#install gdm3 and start service
sudo apt-get install gdm3 -y
sudo service gdm3 start
echo "configure completed"

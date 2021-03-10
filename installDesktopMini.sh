#!/bin/bash
#########################################################
# to run this script                                    #
# you should have exec right                            #
# $ sudo chmod 777 installDesktopMini.sh                #
#                                                       #
#########################################################

#install xorg
sudo apt install gnome-session -y
sudo apt-get install xorg -y
#install gdm3 and start service
sudo apt-get install gdm3 -y
sudo service gdm3 start
# install dkms and libdrm-dev in the case if the touchscreen driver does not exist
# in the case that displaylink does not exist you should install the driver ( lsusb to check the existance )
sudo apt-get dist-upgrade
sudo apt-get install dkms -y
sudo apt-get install libdrm-dev -y
# install ssh for ssh connection
sudo apt install openssh-server -y


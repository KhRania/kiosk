#!/bin/bash
#########################################################
#                                                       #
# this script should be runned once for set             # 
# the configuration for kiosk mode                      #
# and should have exec right                            #
# $ sudo chmod 777 config.sh                            #
#                                                       #
#########################################################


#Disable passwords
sudo visudo & sed -i 's/%sudo   ALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD: ALL/g'
#disable wayland protocol
cd /etc/gdm3 
sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' custom.conf
#Set the "Blank screen" delay (one hour in our case)
gsettings set org.gnome.desktop.session idle-delay 3600
#Disable the lock screen
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
# Disable Screen Saver Locking
gsettings set org.gnome.desktop.screensaver lock-enabled false
# Disable gnome keyring
sudo chmod -x /usr/bin/gnome-keyring
sudo chmod -x /usr/bin/gnome-keyring-daemon
sudo chmod -x /usr/bin/gnome-keyring-3

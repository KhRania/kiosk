#!/bin/bash
#########################################################
#                                                       #
# this script should be runned once for set             # 
# the configuration for kiosk mode                      #
# and should have exec right                            #
# $ chmod 777 config.sh                                 #
#                                                       #
#########################################################


#Set the "Blank screen" delay (one hour in our case)
gsettings set org.gnome.desktop.session idle-delay 3600
#Disable the lock screen
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
# Disable Screen Saver Locking
gsettings set org.gnome.desktop.screensaver lock-enabled false

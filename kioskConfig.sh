#!/bin/bash
#########################################################
#                                                       #
# this script should be runned once for set             # 
# the configuration for kiosk mode                      #
# and should have exec right                            #
# $ sudo chmod 777 kioskConfig.sh                       #
#                                                       #
#########################################################

UPDATE=/etc/apt/apt.conf.d/10periodic
PW=/etc/sudoers
DISPLAY=/etc/gdm3/custom.conf
SLEEP=/etc/systemd/logind.conf
CRASH=/etc/default/apport
KEYRING_PATH='/usr/bin'
#Disable passwords
if [ -e "$PW" ]; then
    sudo sed -i '/%sudo/s/ALL=(ALL:ALL) ALL/ALL=(ALL:ALL) NOPASSWD: ALL/' $PW
fi
#Disable wayland protocol
if [ -e "$DISPLAY" ]; then
    sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' $DISPLAY
fi
#Disable sleep / suspend / hibernate HP keyboard buttons for Ubuntu 
if [ -e "$SLEEP" ]; then
    sudo sed -i 's/#HandleSuspendKey=suspend/HandleSuspendKey=ignore/g' $SLEEP 
    sudo sed -i 's/#HandleHibernateKey=hibernate/HandleHibernateKey=ignore/g' $SLEEP
    sudo systemctl restart systemd-logind.service
fi
# Disable gnome keyring
sudo chmod -x $KEYRING_PATH/gnome-keyring
sudo chmod -x $KEYRING_PATH/gnome-keyring-daemon
sudo chmod -x $KEYRING_PATH/gnome-keyring-3
# Disable Error Reporting/crash
if [ -e "$CRASH" ]; then
    sudo sed -i 's/enabled=1/enabled=0/g' $CRASH
fi
#Disable updates
if [ -e "$UPDATE" ]; then
    sudo sed -i '/APT::Periodic::Update-Package-Lists/s/"1"/"0"/' $UPDATE
fi
#Set the "Blank screen" delay (one hour in our case)
gsettings set org.gnome.desktop.session idle-delay 3600
#Disable the lock screen
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
# Disable Screen Saver Locking
gsettings set org.gnome.desktop.screensaver lock-enabled false
echo "configuration completed"
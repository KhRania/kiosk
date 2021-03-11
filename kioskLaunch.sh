#!/bin/bash
#########################################################
# Run chrome in KIOSK mode                              #
#                                                       #
# this script should be in the user's home              #
# /home/ubecome/ubecome/kiosk/kioskLaunch.sh            #
# and should have exec right                            #
# $ sudo chmod 777 kioskLaunch.sh                       #
#                                                       #
#########################################################



###if we need to enable services from launching the web application
#sudo cp /home/ubecome/ubecome/system/systemd/ubecome_frontend.service /etc/systemd/system 
#sudo systemctl enable ubecome_frontend.service
#sudo systemctl start ubecome_frontend.service
#sudo cp /home/ubecome/ubecome/system/systemd/ubecome_backend.service /etc/systemd/system 
#sudo systemctl enable ubecome_backend.service
#sudo systemctl start ubecome_backend.service


### This line launches Chromium with our parameters. We will go through each of these parameters so you know what you can modify, and how you can modify it.
### --kiosk : operate in kiosk mode (limited acces to browser and OS e.g. no system bar, no tabs)
### --noerrdialogs : do not show error dialogs
### --disable-infobars : disable info bar (e.g. "chromium is not de default browser")
### --incognito : for private navigation

chromium-browser --noerrdialogs --disable-infobars --kiosk http://151.253.224.74/
#chromium --kiosk --enable-kiosk-mode --enabled --touch-events --touch-events-ui --disable-ipv6 --allow-file-access-from-files --disable-java --disable-restore-session-state --disable-sync --disable-translate --disk-cache-size=1 --media-cache-size=1 "http"
#unclutter -idle 0
#xrefresh
#xscreensaver





# Step 1 : Chromium on kiosk mode /retail store demo mode : (those methods deactivate only the F11 shortcut)
    first of all u should have chromium on your desktop : sudo apt-get install chromium-browser
## GUI

    1) Click on Start menu on top left of the screen and search for “Startup Applications”
    2) Click on “Startup Applications” application icon, this will open “Startup Applications Preferences” window
    3) On the “Startup Applications Preferences” window, click “Add”:
    Fill in the following information for the fields:
                    Name:                   Autostart chromium
                    Command:                chromium-browser http://localhost:3000/ --kiosk
    Next click “Add” to add this new startup program to the list of startup programs.
    4) sudo reboot
    https://specifications.freedesktop.org/autostart-spec/0.5/ar01s02.html
## CLI 

    1) cd ~/.config/autostart ( or mkdir autostart in the directory does not exist)
    2) sudo nano kiosk.desktop
    3) chmod 777 kiosk.desktop
    4) sudo reboot


    => to kill the process ( back from kiosk mode ) : sudo pkill -9 chromium



# Step 2 : Disable shortcuts ( ALT / Super / Ctrl)

    This action is to limit the user of window shortcuts when the kiosk mode is active

    After ctrl+alt+T run :
    1) chmod 777 keyboard_disable.sh 
    2) ./keyboard_disable.sh 

    this solution is more logic of disabling the whole keyboard ( we can unabling the keyboard but when we change the usb port it returns to be enabled )
    for disable keyboard : run in terminal =>
    1) xinput => to show all active keyboards
    2) xinput float <id#>

    to enable it xinput reattach <id#> <master#>


# Step 3 : Disable suspend mode :

## GUI 

    follow instructions in those pictures => images/suspend.png &  images/lock.png

## CLI 

    After Atrl+Alt+T run :

    1) Set the "Blank screen" delay (one hour in our case) :

    gsettings set org.gnome.desktop.session idle-delay 0
    https://superuser.com/questions/727120/make-gnome-screen-lock-after-1-hour-not-15-minutes
    http://manpages.ubuntu.com/manpages/bionic/man1/gsettings.1.html
    2) Disable the lock screen :

    gsettings set org.gnome.desktop.lockdown disable-lock-screen true
 
    3) Disable Screen Saver Locking:

    gsettings set org.gnome.desktop.screensaver lock-enabled false

    4) Disable sleep / suspend / hibernate HP keyboard buttons for Ubuntu 

    a) run : sudo nano /etc/systemd/logind.conf

    b) In logind.conf change (delete the #):

    #HandleSuspendKey=suspend
    #HandleHibernateKey=hibernate
    to
    HandleSuspendKey=ignore
    HandleHibernateKey=ignore

    c) After saving changes either reboot to activate or use : sudo systemctl restart systemd-logind.service


# Step 4 : Disable passwords :

## CLI

    After Ctrl+Alt+T run 

    1)sudo visudo  

    2)change "%sudo   ALL=(ALL:ALL) ALL" with "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" 

    Result : no password when using sudo 

# Step 5 : Disable OS updates/crashes/Error Reporting :

## GUI

    1)Disable updates:

    follow instructions in this picture =>  images/disable_updates.png 

    2)Disable Error Reporting/crashes :

    follow instructions in this picture =>  images/disable_crashes.png 


## CLI 

    1)Disable updates:

        After Atrl+Alt+T run : 
        *)`sudo nano /etc/apt/apt.conf.d/10periodic`
        **)Change "APT::Periodic::Update-Package-Lists" to 0.

    2)Disable Error Reporting/crashes : the Apport service to manage the error report pop-up on Ubuntu Desktop.
        After Atrl+Alt+T run : 
        *)sudo nano /etc/default/apport 
        **)Change "enabled" to 0 so that the system does not start the apport service at boot.
        
# Step 6 : Disable gnome keyring :     

## GUI

    follow instructions in this picture =>  images/disable_gnome_keyring.png
## CLI
     sudo chmod -x /usr/bin/gnome-keyring   
     sudo chmod -x /etc/xdg/autostart/gnome-keyring-ssh.desktop
# Step 7 : Wake up touch screen after blank screen :

## CLI :

    1) add this line "xrefresh" to "kiosk_chromium.sh"
# Step 8 : Hide the mouse pointer :

## CLI :

    1) sudo apt-get install unclutter
    2) add this line "unclutter -idle 0" to "kiosk_chromium.sh"
    3) gsettings set org.gnome.settings-daemon.plugins.cursor active false

# Step 9 : Enable on-screen Keyboard :

## CLI :

    1) sudo apt install onboard
    2) 2) add this line "onboard" to "kiosk_chromium.sh" 

## GUI :

     follow instruction in this picture =>  images/keyboard_touch.png 


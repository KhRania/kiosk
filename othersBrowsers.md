# Setting default browser:
    sudo update-alternatives --config x-www-browser
# 1) Firefox :

## Kiosk mode : 

    firefox -kiosk https://www.youtube.com

## Kill :

    sudo pkill -f firefox

# 2) Chrome :

## Install :

    1) sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    2)  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    3) sudo apt-get update
    4) sudo apt-get install google-chrome-stable

## Kiosk mode :

    google-chrome --kiosk https://www.youtube.com

## Kill :

    sudo pkill -9 chrome

# 3) Konqueror:

## Install : 

    1) sudo apt-get update -y
    2) sudo apt-get install -y konqueror

## Kiosk mode :

    https://www.linux-magazine.com/Issues/2014/159/Command-Line-KDE-Kiosk
    https://mail.kde.org/pipermail/kde-kiosk/2003-November/000580.html

## Kill :

    sudo pkill -9 konqueror
    
# 4) Opera :

## Reference :

    1) http://212.201.36.177/~siebenbfaq/wordpress/wp-content/uploads/2014/07/Opera-Kiosk-mode.pdf
    2) http://web.archive.org/web/20130223014915/http://www.opera.com/support/mastering/kiosk/

## Install : 

    1) wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
    2) sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
    3) sudo apt install opera-stable

## Kiosk mode : 

    opera -kioskmode https://www.youtube.com 

## Kill :

    sudo pkill -9 opera   

# 5) Midori :

## Install :

    1) Choose the right version on : https://astian.org/en/midori-browser/download/
    2) In a terminal : sudo dpkg -i midori_x.x.xx-x_amd64_.deb

## Kiosk Mode :

    midori -e Fullscreen -a https://www.youtube.com 

## Kill : 

    sudo pkill -9 midori

# 6) Dillo :

## Reference:

    http://manpages.ubuntu.com/manpages/bionic/man1/dillo.1.html

## Install :

    1) sudo apt-get update -y
    2) sudo apt-get install -y dillo
    3) dillo - web browser

## Kiosk mode : 

    dillo -f https://www.youtube.com (* normal display of a window not kiosk mode)

## Kill :

    sudo pkill -9 dillo

# 7) Epiphany-browser :

## Reference:

    http://doc.ubuntu-fr.org/epiphany

## Install :

    1) sudo apt-get update -y
    2) sudo apt-get install -y epiphany-browser

## Kiosk mode :

    1) Create a web application from the browser and write the link to access on kiosk mode
    2) Epiphany create a desktop entry with command that execute the web application when Ubuntu get to start. To access to this command line :

      cd ~/.config/epiphany/app-epiphany-youtube.com-xxxx/
      sudo nano epiphany-youtube.com-xxxx.desktop
      copy the text following "Exec="

    the command is : epiphany --application-mode --profile="/home/ubecome/.config/epiphany/app-epiphany-youtube.com-d7e222c8d7ba68d8030080bd470ae2b2f2cbc06d" https://www.youtube.com/


## Kill :

    sudo pkill -9 epiphany

# 8) Lynx :

    this browser is a character-based web browser that can be run inside a terminal or on the console.

## Install :

    1) sudo apt-get update -y
    2) sudo apt-get install lynx -y

# 9) Links :
    does not support kiosk mode
## Reference :
    https://linux.die.net/man/1/links2
## Install :

    1) sudo apt-get update -y
    2) sudo apt-get install -y links2
    3) links2 -g (that makes links run on graphic mode)

## Kill :

    sudo pkill -9 links2

# 10) Ubuntu Web Browser : not supported on ubuntu 18.04 LTS

    https://launchpad.net/ubuntu/bionic/+source/webbrowser-app

# 11) ELinks : 

    ELinks is an advanced text-mode browser.
# 12) brave :
    **Install :** 

    sudo apt install apt-transport-https curl gnupg -y

    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    sudo apt install brave-browser -y
    
    sudo update-alternatives --config x-www-browser
    
    **kiosk mode :**

    brave-browser --kiosk https://www.youtube.com
    
    **Stop kiosk :**

    sudo pkill -9 brave


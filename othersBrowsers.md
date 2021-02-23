# Firefox :

## Kiosk mode : 
    firefox -kiosk https://www.youtube.com
## Kill :
    sudo pkill -f firefox
# Chrome :

## Install :

    1) sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    2)  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    3) sudo apt-get update
    4) sudo apt-get install google-chrome-stable

## Kiosk mode :
    google-chrome --kiosk https://www.youtube.com
## Kill :
    sudo pkill -9 chrome
# Konqueror:

## Install :    
    1) sudo apt-get update -y
    2) sudo apt-get install -y konqueror
## Kiosk mode :
    https://www.linux-magazine.com/Issues/2014/159/Command-Line-KDE-Kiosk
    https://mail.kde.org/pipermail/kde-kiosk/2003-November/000580.html
## Kill :
# Opera (*):

## Install : 
    1) wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
    2) sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
    3) sudo apt install opera-stable
## Kiosk mode : 
    opera -kioskmode -fullscreen https://www.youtube.com (* normal display of a window not kiosk mode)
## Kill :
    sudo pkill -9 opera   
# Midori (*):

## Install :
    1) Choose the right version on : https://astian.org/en/midori-browser/download/
    2) In a terminal : sudo dpkg -i midori_x.x.xx-x_amd64_.deb
## Kiosk Mode :
    midori -e Fullscreen -a https://www.youtube.com (* normal display of a window not kiosk mode)
## Kill : 
    sudo pkill -9 midori
# Dillo (*):
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

# Epiphany-browser :
## Reference:
    http://doc.ubuntu-fr.org/epiphany
## Install :
    1) sudo apt-get update -y
    2) sudo apt-get install -y epiphany-browser
## Kiosk mode :
    epiphany-browser --application-mode --profile=~/.config https://www.youtube.com
## Kill :

# Lynx :
    this browser is a character-based web browser that can be run inside a terminal or on the console.
## Install :
    1) sudo apt-get update -y
    2) sudo apt-get install lynx -y
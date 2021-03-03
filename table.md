| Version Ubuntu    |      Affichage Touchscreen      |  Affichage monitor |  gestionnaire d'affichage |
|----------         |:-------------------------------:|:------------------:|--------------------------:|
| 14.04 LTS         |  normal                         | normal             |lightdm                           |
| 18.04 LTS         |  lent                           | normal             |gdm3                       |
| 20.04 LTS         |  lent                           | normal             |gdm3                       |

https://wiki.debian.org/fr/DisplayManager
https://packages.ubuntu.com/bionic/x-display-manager

# test lightdm :

    sudo apt-get update -y
    sudo apt-get install -y lightdm

    after installing other display manager :
        sudo dpkg-reconfigure lightdm

# test sddm :
    sudo apt-get update -y
    sudo apt-get install -y sddm

    after installing other display manager :
        sudo dpkg-reconfigure sddm

# test gdm3:
    https://doc.ubuntu-fr.org/gdm
    sudo dpkg-reconfigure gdm3
    sudo service gdm3 start
# Test slim :
    sudo apt-get update -y
    sudo apt-get install -y slim

# Test lxde :
    for install lxde :
                        sudo apt-get install lxde
    for install lubuntu :
                        sudo apt-get update
                        sudo apt-get install lubuntu-core
    sudo apt purge --remove lubuntu-*; sudo apt autoremove -y
    sudo apt purge --remove lxde*; sudo apt autoremove -y
# xorg install :
    sudo apt install gnome-session
    sudo apt-get install xorg
# Test lxde sous Ubuntu 18.04 :
    for install lxde :
                        sudo apt-get install lxde
    for install lubuntu :
                        sudo apt-get update
                        sudo apt-get install lubuntu-core
## Rèsultat : Affichage lent

# Test des outils de détection "Multiple Monitors"
    ## dconf-editor : 
        sudo apt install dconf-editor 
        puis configuration comme indique le lien suivant : https://germaniumhq.com/2019/02/19/2019-02-19-Fixing-Virtual-Desktops-on-Multiple-Monitors-in-Ubuntu-18.04/
    ## Tweak Tool : 
        $ sudo add-apt-repository universe
        $ sudo apt install gnome-tweak-tool
        puis faire le choix de configuration : 
    ## Résultat : Affichage toujours lent    

# Test Ubuntu mini (sans GUI):

    Test 1 avec lightDm :

    1) installation de gnome-session :
        sudo apt install gnome-session
    2) installation xorg :
        sudo apt-get install xorg
    => Detection de touchscreen mais pas d'affichage
    3) Réinstallation de DisplayLink :
        https://support.displaylink.com/knowledgebase/articles/684649
    => Detection de touchscreen mais pas d'affichage
    4) Instllation dconf-editor :   
    => changement de paramétrage pas d'affichage

    En conclusion pas d'affichage avec lightdm.

   ## Test 2 avec gdm3:

    Il y a un affichage sur touchscreen qui est fluide mais avec une barre (voir vidéo): [ubuntuMiniGdm.mp4](https://trello-attachments.s3.amazonaws.com/5fe378b60e7edd0a10a098ee/60376c2933f8e85887a21344/5d588fe0937790b98c5f1fde92c590ff/ubuntuMiniGdm.mp4) 




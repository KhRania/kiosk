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

    after installing other dispmlay manager :
        sudo dpkg-reconfigure lightdm

# test sddm :
    sudo apt-get update -y
    sudo apt-get install -y sddm

    after installing other dispmlay manager :
        sudo dpkg-reconfigure sddm

# test gdm:
    https://doc.ubuntu-fr.org/gdm
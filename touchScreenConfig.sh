#!/bin/sh
# XPackages() {
# 	# *** GOOGLE chrome package source
# 	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# 	echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# 	apt-get update
# 	$APT_GET_INSTALL xorg
# 	$APT_GET_INSTALL x11-common
# 	$APT_GET_INSTALL slim
# 	# *** Create /usr/chare/icons/hicolor path for removing google chrome installation error
# 	mkdir -p /usr/share/icons/hicolor
	
# 	$APT_GET_INSTALL google-chrome-stable
# 	# *** Create kiosk_user without password and login
# 	adduser --disabled-password --disabled-login --gecos "" kiosk_user
# 	usermod -a -G cdrom,audio,video,plugdev,users,dialout,dip,netdev kiosk_user
# 	# *** Create .xinitrc file to start only google chrome in fullscreen using USB touchscreen.
# 	echo 'xset s 600 600' > /home/kiosk_user/.xinitrc
# 	echo 'while true; do' >> /home/kiosk_user/.xinitrc
# 	echo '    /usr/bin/google-chrome --kiosk --window-size=1024,600 --window-position=0,0' >> /home/kiosk_user/.xinitrc
# 	echo 'done' >> /home/kiosk_user/.xinitrc
# 	# *** Allow all users to start X (kiosk_user)
# 	echo "allowed_users=anybody" > /etc/X11/Xwrapper.conf
# 	return 0


# }

TouchscreenConfig() {
	# *** Defines USB touchscreen X configuration using framebuffer on /dev/fb1
	echo 'Section "ServerLayout"' > /etc/X11/xorg.conf
	echo 'Identifier "ServerLayout0"' >> /etc/X11/xorg.conf
	echo 'Screen 0 "Screen0" 0 0' >> /etc/X11/xorg.conf
	echo 'EndSection' >> /etc/X11/xorg.conf
	echo '' >> /etc/X11/xorg.conf
	echo 'Section "Files"' >> /etc/X11/xorg.conf
	echo 'ModulePath "/usr/lib/xorg/modules"' >> /etc/X11/xorg.conf
	echo 'ModulePath "/usr/local/lib/xorg/modules"' >> /etc/X11/xorg.conf
	echo 'ModulePath "/usr/local/lib/xorg/modules/drivers"' >> /etc/X11/xorg.conf
	echo 'EndSection' >> /etc/X11/xorg.conf
	echo '' >> /etc/X11/xorg.conf
	echo 'Section "Device"' >> /etc/X11/xorg.conf
	echo 'Identifier "Device0"' >> /etc/X11/xorg.conf
	echo 'Driver "fbdev"' >> /etc/X11/xorg.conf
	echo 'Option "fbdev" "/dev/fb1' >> /etc/X11/xorg.conf
	echo 'Option "DPI" "96x96"' >> /etc/X11/xorg.conf
	echo 'EndSection' >> /etc/X11/xorg.conf
	echo '' >> /etc/X11/xorg.conf
	echo 'Section "Monitor"' >> /etc/X11/xorg.conf
	echo 'Identifier "Monitor0"' >> /etc/X11/xorg.conf
	echo 'EndSection' >> /etc/X11/xorg.conf
	echo '' >> /etc/X11/xorg.conf
	echo 'Section "Screen"' >> /etc/X11/xorg.conf
	echo 'Identifier "Screen0"' >> /etc/X11/xorg.conf
	echo 'Device "Device0"' >> /etc/X11/xorg.conf
	echo 'Monitor "Monitor0"' >> /etc/X11/xorg.conf
	echo 'SubSection "Display"' >> /etc/X11/xorg.conf
	echo 'Depth 24' >> /etc/X11/xorg.conf
	echo 'Modes "1024×600"' >> /etc/X11/xorg.conf
	echo 'EndSubSection' >> /etc/X11/xorg.conf
	echo 'EndSection' >> /etc/X11/xorg.conf
	echo '' >> /etc/X11/xorg.conf
	# *** Remove udlfb from blacklist and blacklist vesafb (no X on internal graphic card
	rm /etc/modprobe.d/blacklist-framebuffer
    	sed '/blacklist udlfb/d' /etc/modprobe.d/blacklist-framebuffer > /etc/modprobe.d/blacklist-framebuffer
    	sed '/^#/d' /etc/slim.conf
    	sed '/^$/d' /etc/slim.conf
}
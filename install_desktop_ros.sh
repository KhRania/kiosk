#!/bin/sh

APT_GET_INSTALL="apt-get --no-install-recommends --yes --force-yes install" 

_TYPE=""
_NAME=""
_IP=""
_GATEWAY=""
_STEP="0"

IsRoot() {
	if [ "$(id -u)" != "0" ]; then
		return 1 
	fi

	return 0
}

AskYes() {
	while true; do
		read -p "$1" yn
		case $yn in
			[Yy]* ) return 0; break;;
			[Nn]* ) break;;
			* ) ;;
		esac
	done

	return 1 
}

Choice() {
	while true; do
		read -p "$1" yn
		case $yn in
			"1" ) return 1; break;;
			"2" ) return 2; break;;
			* ) ;;
		esac
	done

	return 0
}

IPV4Only() {
	# *** Desactivate IPV6
	sysctl -w net.ipv6.conf.all.disable_ipv6="1" > /dev/null
	sysctl -w net.ipv6.conf.all.autoconf="0" > /dev/null
	sysctl -w net.ipv6.conf.default.disable_ipv6="1" > /dev/null
	sysctl -w net.ipv6.conf.default.autoconf="0" > /dev/null 
	sysctl -p

	echo "net.ipv4.ip_forward                = 1"  > /etc/sysctl.conf
	echo "net.ipv6.conf.all.disable_ipv6     = 1" >> /etc/sysctl.conf
	echo "net.ipv6.conf.all.autoconf         = 0" >> /etc/sysctl.conf
	echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
	echo "net.ipv6.conf.default.autoconf     = 0" >> /etc/sysctl.conf 
	echo "net.ipv4.ip_local_reserved_ports   = 40054" >> /etc/sysctl.conf
	
	return 0
}

UpdateLinuxKernel() {
	$APT_GET_INSTALL linux-image-generic-lts-xenial
	$APT_GET_INSTALL linux-headers-generic-lts-xenial
	return 0
}

CommonPackages() {
    # *** LibAv package source
    
	echo " **************************** ppa update                 = 1 *************************************** "
	add-apt-repository ppa:heyarje/libav-11

	# *** Protobuf package source
	"deb http://ppa.launchpad.net/5-james-t/protobuf-ppa/ubuntu trusty main" | tee /etc/apt/sources.list.d/5-james-t-protobuf-ppa-trusty.list
	apt-key adv --keyserver keyserver.ubuntu.com --recv E49303A769479FEE

	# *** EOS package source
	sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
        apt-get update

	# *** Install gcc 
	$APT_GET_INSTALL gcc
	
	# *** ROS base packages
	echo " **************************** Install ros full               = 2 *************************************** "
	$APT_GET_INSTALL ros-indigo-desktop-full
        $APT_GET_INSTALL python-rosinstall
	# *** Install ROS dependencies
	rosdep init
        rosdep update

	# *** ROS indigo packages
	$APT_GET_INSTALL ros-indigo-move-base
	$APT_GET_INSTALL ros-indigo-tf2-geometry-msgs
	$APT_GET_INSTALL ros-indigo-controller-interface
	$APT_GET_INSTALL ros-indigo-teleop-twist-joy
	$APT_GET_INSTALL ros-indigo-realtime-tools
	$APT_GET_INSTALL ros-indigo-controller-manager
	$APT_GET_INSTALL ros-indigo-cv-bridge
	$APT_GET_INSTALL ros-indigo-image-transport
	$APT_GET_INSTALL ros-indigo-diagnostic-aggregator
	$APT_GET_INSTALL ros-indigo-axis-camera
	$APT_GET_INSTALL ros-indigo-robot-state-publisher
	$APT_GET_INSTALL ros-indigo-smach-ros
	$APT_GET_INSTALL ros-indigo-robot-upstart
	
	# *** Common packages
	$APT_GET_INSTALL sysstat
	$APT_GET_INSTALL python-pip
	$APT_GET_INSTALL iptables-persistent
	$APT_GET_INSTALL logrotate
	$APT_GET_INSTALL ssh
	$APT_GET_INSTALL bmon
	$APT_GET_INSTALL tcptrack
	$APT_GET_INSTALL tree
	$APT_GET_INSTALL tmux
	$APT_GET_INSTALL vim
	$APT_GET_INSTALL nano
	$APT_GET_INSTALL htop
	$APT_GET_INSTALL iperf
	$APT_GET_INSTALL linux-sound-base
	$APT_GET_INSTALL alsa-base
	$APT_GET_INSTALL alsa-utils
	$APT_GET_INSTALL pulseaudio 
	$APT_GET_INSTALL libtesseract-dev
        $APT_GET_INSTALL tesseract-ocr-eng
	$APT_GET_INSTALL libsdl1.2-dev
	$APT_GET_INSTALL libsdl-image1.2-dev
	$APT_GET_INSTALL libmodbus-dev
	$APT_GET_INSTALL libunwind8
	$APT_GET_INSTALL libgoogle-glog0
	$APT_GET_INSTALL libgflags2
	$APT_GET_INSTALL libgflags-dev
	$APT_GET_INSTALL libxmlrpc-c++8
	$APT_GET_INSTALL libxmlrpc-c++8-dev
	$APT_GET_INSTALL libprotobuf-dev
	$APT_GET_INSTALL libtinyxml-dev
	$APT_GET_INSTALL libxmlrpc-core-c3
        $APT_GEt_INSTALL libav-tools
        $APT_GEt_INSTALL libgoogle-glog-dev
	$APT_GEt_INSTALL libsdl2-dev
	$APT_GEt_INSTALL libavfilter-dev
	$APT_GEt_INSTALL libav-dbg
	$APT_GEt_INSTALL libavdevice-dev 
	$APT_GEt_INSTALL libao-dev

    ldconfig

    # *** Generate locale fr_FR.UTF-8
    locale-gen fr_FR.UTF-8

	# *** Configure .bashrc for ROS
	echo '# ros configuration' >> .bashrc
	echo 'source /opt/ros/indigo/setup.bash' >> .bashrc
	echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib' >> .bashrc

	# *** Create ROS eos directory
	# mkdir -p /opt/ros/eos
	# mkdir -p /home/eos/.config/eos
	# chown -R eos:eos /opt/ros/eos
	# chown -R eos:eos /home/eos

    # *** update eos groups
    usermod -a -G root,video,audio eos

	return 0
}

XPackages() {
	# *** GOOGLE chrome package source
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

	apt-get update

	$APT_GET_INSTALL xorg 
	$APT_GET_INSTALL x11-common
	$APT_GET_INSTALL slim

	# *** Create /usr/chare/icons/hicolor path for removing google chrome installation error
	mkdir -p /usr/share/icons/hicolor
	
	$APT_GET_INSTALL google-chrome-stable

	# *** Create kiosk_user without password and login
	adduser --disabled-password --disabled-login --gecos "" kiosk_user
	usermod -a -G cdrom,audio,video,plugdev,users,dialout,dip,netdev kiosk_user
	# *** Create .xinitrc file to start only google chrome in fullscreen using USB touchscreen.
	echo 'xset s 600 600' > /home/kiosk_user/.xinitrc 
	echo 'while true; do' >> /home/kiosk_user/.xinitrc
	echo '    /usr/bin/google-chrome --kiosk --window-size=1024,600 --window-position=0,0' >> /home/kiosk_user/.xinitrc 
	echo 'done' >> /home/kiosk_user/.xinitrc

	# *** Allow all users to start X (kiosk_user)
	echo "allowed_users=anybody" > /etc/X11/Xwrapper.conf

	return 0
}

o3d3Packages() {
	wget http://192.168.100.102/cyrille/build_master/raw/master/drivers/libo3d3xx-camera_0.4.2_amd64.deb
	wget http://192.168.100.102/cyrille/build_master/raw/master/drivers/libo3d3xx-framegrabber_0.4.2_amd64.deb
	wget http://192.168.100.102/cyrille/build_master/raw/master/drivers/libo3d3xx-image_0.4.2_amd64.deb

	dpkg -i libo3d3xx-camera_0.4.2_amd64.deb
	dpkg -i libo3d3xx-framegrabber_0.4.2_amd64.deb
	dpkg -i libo3d3xx-image_0.4.2_amd64.deb

	rm -rf libo3d3xx-*
}

EnvConfig() {
	# *** Define general environment / the robot mode is set by default to "prod" value.
	echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"' > /etc/environment
	echo 'EOS_ROBOT_MODE="prod"' >> /etc/environment

	echo "$_NAME" > /etc/hostname
	echo "127.0.0.1	localhost" > /etc/hosts
	echo "127.0.0.1	$_NAME" >> /etc/hosts
}

USBConfig() {
	# *** Accept specific USB Product/Vendor IDs
	echo 'SUBSYSTEM=="usb",                          ATTR{idVendor}=="17e9", MODE:="0666"'                                 > /etc/udev/rules.d/40-displaylink-usb.rules
	echo 'SUBSYSTEM=="usb",                          ATTR{idVendor}=="24e0", MODE:="0666"'                                 > /etc/udev/rules.d/50-yocto-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="0200", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"'  > /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="0300", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="0401", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="0500", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="0600", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="0601", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="0609", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="1250", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="1260", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="1270", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="1280", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="1290", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb", ATTR{idProduct}=="f9db", ATTR{idVendor}=="1d27", MODE:="0666", OWNER:="root", GROUP:="video"' >> /etc/udev/rules.d/51-primesense-usb.rules
	echo 'SUBSYSTEM=="usb",                          ATTR{idVendor}=="8086", MODE:="0666"'                                 > /etc/udev/rules.d/60-realsense-usb.rules
}

Eth0Config() {
	# *** Assign eth0 interface to the e1000e gigabit ethernet adapter (1st physical ethernet port)
	echo 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="e1000e" ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"' > /etc/udev/rules.d/70-persistent-net.rules
}

NetworkConfig() {
	# *** Defines IP configuration for each ethernet port
	echo 'auto lo' > /etc/network/interfaces
	echo 'iface lo inet loopback' >> /etc/network/interfaces

	if [ "2" = "$_TYPE" ]; then
    	echo 'auto eth0' >> /etc/network/interfaces
    	if [ "$_IP" != "DHCP" ]; then
    		echo 'iface eth0 inet static' >> /etc/network/interfaces
    		echo " address $_IP" >> /etc/network/interfaces
    		echo ' netmask 255.255.255.0' >> /etc/network/interfaces
    		echo " gateway $_GATEWAY" >> /etc/network/interfaces
    		echo ' dns-nameservers 8.8.8.8' >> /etc/network/interfaces
    	else
    		echo 'iface eth0 inet dhcp' >> /etc/network/interfaces
    	fi
    	echo 'auto p4p1' >> /etc/network/interfaces
    	echo ' iface p4p1 inet static' >> /etc/network/interfaces
    	echo ' address 192.168.2.1' >> /etc/network/interfaces
    	echo ' netmask 255.255.255.0' >> /etc/network/interfaces
    	echo 'auto p5p1' >> /etc/network/interfaces
    	echo 'iface p5p1 inet static' >> /etc/network/interfaces
    	echo ' address 192.168.3.1' >> /etc/network/interfaces
    	echo ' netmask 255.255.255.0' >> /etc/network/interfaces
    	echo 'auto p6p1' >> /etc/network/interfaces
    	echo ' iface p6p1 inet static' >> /etc/network/interfaces
    	echo ' address 192.168.1.1' >> /etc/network/interfaces
    	echo ' netmask 255.255.255.0' >> /etc/network/interfaces
    else
    	echo 'auto p6p1' >> /etc/network/interfaces
    	if [ "$_IP" != "DHCP" ]; then
    		echo 'iface p6p1 inet static' >> /etc/network/interfaces
    		echo " address $_IP" >> /etc/network/interfaces
    		echo ' netmask 255.255.255.0' >> /etc/network/interfaces
    		echo " gateway $_GATEWAY" >> /etc/network/interfaces
    		echo ' dns-nameservers 8.8.8.8' >> /etc/network/interfaces
    	else
    		echo 'iface p6p1 inet dhcp' >> /etc/network/interfaces
    	fi
    	echo 'auto p4p1' >> /etc/network/interfaces
    	echo ' iface p4p1 inet static' >> /etc/network/interfaces
    	echo ' address 192.168.2.1' >> /etc/network/interfaces
    	echo ' netmask 255.255.255.0' >> /etc/network/interfaces
    	echo 'auto p5p1' >> /etc/network/interfaces
    	echo 'iface p5p1 inet static' >> /etc/network/interfaces
    	echo ' address 192.168.3.1' >> /etc/network/interfaces
    	echo ' netmask 255.255.255.0' >> /etc/network/interfaces
    	echo 'auto eth0' >> /etc/network/interfaces
    	echo ' iface eth0 inet static' >> /etc/network/interfaces
    	echo ' address 192.168.1.1' >> /etc/network/interfaces
    	echo ' netmask 255.255.255.0' >> /etc/network/interfaces
    fi
}

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

SerialConfig() {
	# *** Allow write access to serial ports
	chmod a+rw /dev/ttyS0
	chmod a+rw /dev/ttyS1
}

DIODriver() {
	wget -P /lib/modules/$(uname -r)/kernel/drivers/misc http://192.168.100.102/cyrille/build_master/raw/master/drivers/$(uname -r)/wdt_dio.ko
	insmod /lib/modules/$(uname -r)/kernel/drivers/misc/wdt_dio.ko
	depmod
	chmod 644 /dev/wdt_dio
	# *** Allow wdt_dio driver access
	echo 'KERNEL=="wdt_dio*", MODE="0666"' > /etc/udev/rules.d/60-wdt_dio.rules
	echo 'KERNEL=="ttyS[0-9]*",SYMLINK+="%k",GROUP="uucp",MODE="0666"' >> /etc/udev/rules.d/60-wdt_dio.rules
}

LogRotateConfig() {
	# *** Configure log size
    echo "/var/log/upstart/*.log {" > /etc/logrotate.d/upstart
    echo "    daily" >> /etc/logrotate.d/upstart
    echo "    missingok" >> /etc/logrotate.d/upstart
    echo "    size 100M" >> /etc/logrotate.d/upstart
    echo "    rotate 7" >> /etc/logrotate.d/upstart
    echo "    compress" >> /etc/logrotate.d/upstart
    echo "    notifempty" >> /etc/logrotate.d/upstart
    echo "    create root adm" >> /etc/logrorate.d/upstart
    echo "}" >> /etc/logrotate.d/upstart
}

IpTablesConfig() {
	iptables -F
	if [ "2" = "$_TYPE" ]; then
	    # RTSP AXIS 3365 
    	iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 554   -j DNAT --to-destination 192.168.2.2:554
	    # HTTP AXIS 3365
    	iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 55480 -j DNAT --to-destination 192.168.2.2:80
	    # 4444 YOCTO
    	iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 4444  -j DNAT --to-destination 192.168.3.3:80
    	# HTTP FLIR AX8
	    iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 56480 -j DNAT --to-destination 192.168.3.4:80
    	# RTSP FLIR AX8
	    iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 564   -j DNAT --to-destination 192.168.3.4:554
    else
	    # RTSP AXIS 3365 
    	iptables -t nat -A PREROUTING -i p6p1 -p tcp -m tcp --dport 554   -j DNAT --to-destination 192.168.2.2:554
	    # HTTP AXIS 3365
    	iptables -t nat -A PREROUTING -i p6p1 -p tcp -m tcp --dport 55480 -j DNAT --to-destination 192.168.2.2:80
	    # 4444 YOCTO
    	iptables -t nat -A PREROUTING -i p6p1 -p tcp -m tcp --dport 4444  -j DNAT --to-destination 192.168.3.3:80
    	# HTTP FLIR AX8
	    iptables -t nat -A PREROUTING -i p6p1 -p tcp -m tcp --dport 56480 -j DNAT --to-destination 192.168.3.4:80
    	# RTSP FLIR AX8
	    iptables -t nat -A PREROUTING -i p6p1 -p tcp -m tcp --dport 564   -j DNAT --to-destination 192.168.3.4:554
    fi
	/etc/init.d/iptables-persistent save
}

ServiceConfig() {
	SERVICES="dio hardware software"

	if [ ! "$(ls -A /opt/ros/eos)" ]; then
		echo "The directory /opt/ros/eos is empty!"
		echo "You must copy the code to finish this step."
		exit 4 
	fi

	for SERVICE in ${SERVICES}; do
		if [ "2" = "$_TYPE" ]; then
			sudo su eos -c "rosrun robot_upstart install --job eos_${SERVICE}_service --setup /opt/ros/eos/setup.bash --interface eth0 evolve_bringup/launch/services/evigilante_bringup_${SERVICE}_service.launch"
		else 
			sudo su eos -c "rosrun robot_upstart install --job eos_${SERVICE}_service --setup /opt/ros/eos/setup.bash --interface p6p1 evigilante_bringup/launch/services/evigilante_bringup_${SERVICE}_service.launch"
		fi
	done
}

SftpConfig() {
    # *** Create 'transfert' user
    if [ "2" = "$_TYPE" ]; then
        echo 'transfert password = "y7k5qetd58setguj"'
    else
        echo 'transfert password = "jhfbqx8j72wp9pia"'
    fi
    
    adduser --gecos "" --shell /usr/sbin/nologin transfert
    chown root:transfert /home/transfert
    usermod -a -G transfert eos
   
    # *** Allow sftp ability to 'transfert' user 
    echo 'Subsystem internal-sftp -f AUTH -l VERBOSE' >> /etc/ssh/sshd_config
    echo 'Match User transfert' >> /etc/ssh/sshd_config
    echo '  ChrootDirectory %h' >> /etc/ssh/sshd_config
    echo '  AllowTCPForwarding no' >> /etc/ssh/sshd_config
    echo '  X11Forwarding no' >> /etc/ssh/sshd_config
    echo '  ForceCommand internal-sftp' >> /etc/ssh/sshd_config
    
    mkdir /home/transfert/config_eos_shared
    chmod 775 /home/transfert/config_eos_shared
    chown transfert:transfert /home/transfert/config_eos_shared

    # restart ssh service
    service ssh restart
}

ShutdownConfig() {
    addgroup shutdown
    usermod -a -G shutdown eos
    chown root:shutdown /sbin/shutdown
    chmod 751 /sbin/shutdown
    chmod u+s /sbin/shutdown
}

CreateConfig() {
	#echo "EVIGILANTE R00 192.168.100.72 192.168.100.1 0" >> /etc/install_master.conf
	echo "Type of install : dev desktop"
	
	echo "$_TYPE $_NAME $_IP $_GATEWAY 0" > /etc/install_master.conf
}

Step0() {
	echo "*******************************************************************"
	echo " Step 0 :"
	echo "  - Force 1st physical ethernet port to eth0"
        echo "  - Set DHCP to eth0"
        echo "  - Update linux kernel"
	echo "  - Set environment variables"
	echo "  - Set udev rules"
	echo "  - Allow access to serial ports"
	echo "  - Allow user 'eos' to shutdown"
	echo "*******************************************************************"

	#IPV4Only
	#Eth0Config
	#_IP="DHCP"
	#NetworkConfig
	#UpdateLinuxKernel
	#EnvConfig
	#USBConfig
	#SerialConfig
	#ShutdownConfig
}

Step1() {
	echo "*******************************************************************"
	echo " Step 1 :"
	echo "  - Install ROS packages and common packages"
	echo "  - Install DIO driver"
	echo "  - Install o3d3 packages"
	echo "  - Set log rotate configuration"
	echo "  - Set iptables configuration"
	echo "  - Set sftp configuration"
	if [ "2" = "$_TYPE" ]; then
		echo "  - Install xorg, slim, google-chrome-stable packages"
	fi
    echo "  - You must copy the evigilante/evolve code in /opt/ros/eos"
	echo "*******************************************************************"
	
	CommonPackages
	o3d3Packages
	
 	if [ "2" = "$_TYPE" ]; then
		XPackages
		TouchscreenConfig	
	fi

    echo "WARNING: You must copy the evigilante/evolve code in /opt/ros/eos"
}

Step3() {
	echo "*******************************************************************"
	echo " Step 3 :"
	if [ "1" = "$_TYPE" ]; then
		echo "  - Copy eos configuration and create link to /home/transfert/config_eos_shared"
	fi
    echo "  - Set IP configuration : static IP : $_IP, gateway : $_GATEWAY"
	echo "  - Clean master" 
	echo "*******************************************************************"

    if [ "1" = "$_TYPE" ]; then
	    cd /home/eos
        sudo su eos -c "mkdir -p /home/eos/.config/eos"
        cd /home/eos/.config/eos
        sudo su eos -c "wget http://192.168.100.102/cyrille/build_master/raw/master/evigilante_config.tar.gz"
        sudo su eos -c "tar xzvf evigilante_config.tar.gz"
        sudo su eos -c "rm evigilante_config.tar.gz"
        sudo su eos -c "mv shared dd"
        sudo su eos -c "ln -s /home/transfert/config_eos_shared /home/eos/.config/eos/shared"
        sudo su eos -c "cp dd/* shared/"
        cd /home/eos
    fi

    ServiceConfig
	NetworkConfig
	rm -rf /etc/install_master.conf
}

CheckRoot() {
	if ! IsRoot; then
		echo "This script must be run as root" 1>&2
		exit 1
	fi
}

CheckRoot

if [ ! -f /etc/install_master.conf ]; then
	CreateConfig	
fi  

echo "Current configuration : "
cat /etc/install_master.conf

_TYPE=$(cat /etc/install_master.conf | cut -d ' ' -f1 -s)
_NAME=$(cat /etc/install_master.conf | cut -d ' ' -f2 -s)
_IP=$(cat /etc/install_master.conf | cut -d ' ' -f3 -s)
_GATEWAY=$(cat /etc/install_master.conf | cut -d ' ' -f4 -s)
_STEP=$(cat /etc/install_master.conf | cut -d ' ' -f5 -s)

if [ "2" = "$_TYPE" ]; then
	echo "EVOLVE MASTER - INSTALLATION"
else
	echo "EVIGILANTE MASTER - INSTALLATION"	
fi

if ! AskYes "do you want to continue on step #$_STEP ? (yn) "; then
	exit 2
fi

case $_STEP in
	0 )
		Step1 
		echo "$_TYPE $_NAME $_IP $_GATEWAY 1" > /etc/install_master.conf;; 
	1 ) 
		Step1
		echo "$_TYPE $_NAME $_IP $_GATEWAY 2" > /etc/install_master.conf;;
	2 ) 
		Step1
		echo "$_TYPE $_NAME $_IP $_GATEWAY 3" > /etc/install_master.conf;;
	3 ) 
		Step1;;
	* ) ;;	
esac	


if AskYes "Do you want to reboot ? "; then
	reboot
	exit 3
fi

return 0

# *** Add manually

# *** set sftp transfert user password (sudo passwd sftp_user)
# EVOLVE     -> password = "y7k5qetd58setguj"
# EVIGILANTE -> password = "jhfbqx8j72wp9pia"

# *** create .bashrc with following lines

# ****************************************************************************
# file .bashrc                                             [beginning of file]
# ****************************************************************************

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
if [ -n "$EOS_ROBOT_MODE" ]; then
	force_color_prompt=yes
fi

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

current_ip=`ifconfig p6p1 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`

PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

if [ "$color_prompt" = yes ]; then
    if [ "$EOS_ROBOT_MODE" == "dev" ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\h-$current_ip\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    fi
    
    if [ "$EOS_ROBOT_MODE" == "prod" ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h-$current_ip\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    fi
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ros configuration

if [ "$EOS_ROBOT_MODE" == "dev" ]; then
	export ROS_IP=$current_ip
fi

if [ "$EOS_ROBOT_MODE" == "prod" ]; then
	export ROS_IP="127.0.0.1"
fi

source /opt/ros/indigo/setup.bash
source /opt/ros/eos/setup.bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# ****************************************************************************
# file .bashrc                                                   [end of file]
# ****************************************************************************

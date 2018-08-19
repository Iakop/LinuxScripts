#!/bin/bash

# Must be run as Superuser, check for sudo:
if [ "$(whoami)" != "root" ]; then
	echo "You must run this install-script as root!"
	exit 1
fi

# TODO: Add netctl config, and netctl enable, start ethernet

# Prompt for username, and create the user:
read -p "Please enter you desired username: " username
useradd -m -U -G wheel,ftp,games,http,log,rfkill,sys,systemd-journal,users,uucp -s /bin/bash $iakop

# TODO: Add a grep that finds the %wheel line in sudoers and allows ALL for it

# Install needed packages
pacman -S nvidia xorg-server xorg-xinit xorg-apps i3-gaps i3status i3blocks rxvt-unicode dmenu neofetch ranger python-pywal vlc w3m firefox git

# Sets Xorg up for the multi-monitor display:
echo "Setting up Xorg Monitor configuration in /etc/X11/xorg.conf.d/10-monitor.conf..."
echo -e "Section \"Monitor\"
\tIdentifier \"HDMI-0\"
\tOption \"PreferredMode\" \"1680x1050\"
\tOption \"Position\" \"0 262\"
EndSection

Section \"Monitor\"
\tIdentifier \"HDMI-1\"
\tOption \"PreferredMode\" \"1680x1050\"
\tOption \"Rotate\" \"Left\"
\tOption \"Position\" \"1680 0\"
EndSection" >> /etc/X11/xorg.conf.d/10-monitor.conf
retval=$?
if [ $retval -eq 0 ]; then
	echo "Set up display configuration successfully!"
else
	echo "Couldn't set up monitors. Return code $retval"
	exit 1
fi

# Sets Xorg keyboard language to danish:
echo "Setting up Xorg Keyboard configuration in /etc/X11/xorg.conf.d/00-keyboard.conf..."

echo -e "Section \"InputClass\"
\tIdentifier \"system-keyboard\"
\tMatchIsKeyboard \"on\"
\tOption \"XkbLayout\" \"dk\"
EndSection" >> /etc/X11/xorg.conf.d/00-keyboard.conf

retval=$?
if [ $retval -eq 0 ]; then
	echo "Set up keyboard configuration successfully!"
else
	echo "Couldn't set up keyboard. Return code $retval"
	exit 1
fi

# Sets the alsa settings to enable sound on the correct devices:
echo "Setting up ALSA device configuration in /etc/modprobe.d/alsa-base.conf..."
echo -e "options bt87x index=-2
options cx88_alsa index=-2
options saa7134-alsa index=-2
options snd-atiixp-modem index=-2
options snd-intel8x0m index=-2
options snd-via82xx-modem index=-2
options snd-usb-caiaq index=-2
options snd-usb-ua101 index=-2
options snd-usb-us122l index=-2
options snd-usb-usx2y index=-2
options snd-pcsp index=-2
options snd-usb-audio index=-2" >> /etc/modprobe.d/alsa-base.conf
retval=$?
if [ $retval -eq 0 ]; then
	echo "Set up ALSA configuration successfully!"
else
	echo "Couldn't set up ALSA config. Return code $retval"
	exit 1
fi

# Unmute and set the Master control with amixer:
echo "Setting the amixer Master control to unmute and 50% output..."
amixer set Master unmute 32
retval=$?
if [ $retval -eq 0 ]; then
	echo "Set amixer volume!"
else
	echo "Couldn't set sound on master. Return code $retval"
	exit 1
fi

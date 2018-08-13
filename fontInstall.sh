#!/bin/bash

# Must be run as Superuser, check for sudo:
if [ "$(whoami)" != "root" ]; then
	echo "You must run this install-script as root!"
	exit 1
fi

# First, bitmap fonts must be enabled by the script
# The 70-no-bitmaps.conf file is deleted from its directory,
# Then, a symbolic link is made to the 70-yes-bitmaps.conf file in conf.avail 
rm -rf /etc/fonts/conf.d/70-no-bitmaps.conf && ln -s /etc/fonts/conf.avail/70-yes-bitmaps.conf
retval=$?
if [ $retval -eq 0 ]; then
	echo "Changed conf-files to enable bitmap fonts!"
else
	echo "Couldn't enable bitmap fonts. Return code $retval"
	exit 1
fi

# To finalize the confifuration, dpkg-reconfigure is run on fontconfig:
dpkg-reconfigure fontconfig
retval=$?
if [ $retval -eq 0 ]; then
	echo "Reconfigured fontconfig succesfully!"
else
	echo "Reconfigure failed. Return code $retval"
	exit 1
fi

# Then, the new fonts can be installed:
# First, a user directory must be made for the fonts, to be installed:



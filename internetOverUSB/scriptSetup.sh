#!/bin/bash
#
# Author : Jacob Bechmann Pedersen
# Date   : 18-10-2017
# Purpose: Sets up the BBB internet script in the relevant directories
#

echo "Setting up internetOverUSB"

cp /bin/internetOverUSB /root/bin
if [ $? -eq 0 ]; then
	echo "Error in copying, are you root?"
	break
fi

chmod 755 /root/bin/internetOverUSB
if [ $? -eq 0 ]; then
	echo "Error in changing file permissions"
	break
fi

cp /init/internetOverUSB /etc/init.d
if [ $? -eq 0 ]; then
        echo "Error in copying, are you root?"
        break
fi

chmod 755 /etc/init.d/internetOverUSB
if [ $? -eq 0 ]; then
        echo "Error in changing file permissions"
        break
fi

update-rc.d internetOverUSB defaults
if [ $? -eq 0 ]; then
        echo "Error in updating startup routine with script"
        break
fi

echo "End of setup script"

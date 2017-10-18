#!/bin/bash
#
# Author : Jacob Bechmann Pedersen
# Date   : 18-10-2017
# Purpose: Sets up the BBB internet script in the relevant directories
#

echo "Setting up internetOverUSB"

## Copies the internetOverUSB script to the actual bin directory
cp ./bin/internetOverUSB /bin

## Changes the file permission to allow execution
chmod 755 /bin/internetOverUSB

## Copies the initialization scripts to the init.d folder
cp ./init/internetOverUSB /etc/init.d

## Changes file permissions to allow execution
chmod 755 /etc/init.d/internetOverUSB

## Updates the initializtion routine list to include internetOverUSB
update-rc.d internetOverUSB defaults

echo "End of setup script"

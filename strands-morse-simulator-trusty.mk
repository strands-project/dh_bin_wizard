##############################################################################
### CONFIGURATION ###
# package name
PKG_NAME:=strands-morse-simulator

# version	
VERSION:=1.3.STRANDS.0.trusty

# Debian increment (to be bumped when the same version is packaged again)	
DEBINC:=1

# architecture to be build
ARCH:=amd64

# license (apache|artistic|bsd|gpl|gpl2|gpl3|lgpl|lgpl2|lgpl3|x11)
LICENSE:=gpl3

# maintainer email address
MAINTAINER:=cburbridge@gmail.com
DEBFULLNAME=Chris Burbridge
DEBEMAIL=cburbridge@gmail.com

# all deb packages needed to build this
APT_INSTALL:=cmake git zlib1g-dev ros-indigo-desktop-full ros-indigo-rospy git-cvs python3-yaml python3-numpy libpython3.4-dev blender

## Install prefix WITHOUT leading '/', e.g. 'opt' for '/opt'
INSTALL_PREFIX:=opt


## This is the install command that will install the package unter the INSTALL_PREFIX 
INSTALL_COMMAND=bash ./strands-morse-setup-trusty.sh

##############################################################################

include dh_bin_wizard.mk

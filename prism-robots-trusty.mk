##############################################################################
### CONFIGURATION ###
# package name
PKG_NAME:=prism-robots

# version	
VERSION:=4.2.1trusty

# Debian increment (to be bumped when the same version is packaged again)	
DEBINC:=1

# architecture to be build
ARCH:=amd64

# license (apache|artistic|bsd|gpl|gpl2|gpl3|lgpl|lgpl2|lgpl3|x11)
LICENSE:=gpl3

# maintainer email address
MAINTAINER:=b.lacerda@cs.bham.ac.uk

# all deb packages needed to build this
APT_INSTALL:=openjdk-7-jre openjdk-7-jdk

## Install prefix WITHOUT leading '/', e.g. 'opt' for '/opt'
INSTALL_PREFIX:=opt

## This is the install command that will install the package unter the INSTALL_PREFIX 
INSTALL_COMMAND=

##############################################################################

include dh_bin_wizard.mk

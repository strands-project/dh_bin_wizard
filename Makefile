##############################################################################
### CONFIGURATION ###
# package name
PKG_NAME:=mira-scitos

# version	
VERSION:=0.2

# architecture to be build
ARCH:=amd64

# license (apache|artistic|bsd|gpl|gpl2|gpl3|lgpl|lgpl2|lgpl3|x11)
LICENSE:=gpl3

# maintainer email address
MAINTAINER:=marc@hanheide.net

# all deb packages needed to build this
APT_INSTALL:=libboost-all-dev \
	libncurses5-dev libogre-dev libqwt5-qt4-dev libsqlite3-dev libssl-dev libxml2-dev \
	libxrandr-dev pyqt4-dev-tools qt4-dev-tools ros-hydro-opencv2 subversion libsvn-dev

## Install prefix WITHOUT leading '/', e.g. 'opt' for '/opt'
INSTALL_PREFIX:=opt

## This is the install command that will install the package unter the INSTALL_PREFIX 
INSTALL_COMMAND=bash ./mira-installer-binary.sh ubuntu-1204lts-x64 $(GLOBAL_ROOT)

##############################################################################

include bin-deb.mk

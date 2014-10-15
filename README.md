dh_bin_wizard
==============


This tool allows to pack up exotic packages into a Debian format from an actual install tree. Hence, it is the simple way of taking some existing install routine to create Ubuntu packages. It's simple a set of Makefiles around tools like `dh_make` and `dpkg-buildpackage` with a little fairy dust.

# File `dh_bin_wizard.mk`

This is the fairy dust. It's a make file that should be included at the end of the package makefiles and has all the Makefile magic in it to run the right tools based on the variables defined in the package makefiles.

# Package Makefiles (e.g. `mira.mk`, see below)

These Makefiles define all the variables need for `dh_bin_wizard.mk` to do its magic. Here's an example with documentation:

```
##############################################################################

### CONFIGURATION ###
# PKG_NAME: this determines both the name of the install tree under the 
# $INSTALL_PREFIX (see below) and the resulting Debian package. 
# E.g. This file defines an installation under /opt/mira-scitos and the 
# Debian package name will be `scitos-mira_$(VERSION)-$(DEBINC)_$(ARCH).deb`
# See below for the other variables!

PKG_NAME:=mira-scitos

# VERSION: obviously the version of the package created. Should reflect
# the upstream version!	
VERSION:=0.2

# Debian increment (to be bumped when the same version is packaged again)	
DEBINC:=1

# architecture to be build (e.g. i386 or amd64)
ARCH:=amd64

# license (apache|artistic|bsd|gpl|gpl2|gpl3|lgpl|lgpl2|lgpl3|x11)
LICENSE:=gpl3

# maintainer email address
MAINTAINER:=marc@hanheide.net

# all deb packages needed to build this
APT_INSTALL:=libboost-all-dev \
	libncurses5-dev libogre-dev libqwt5-qt4-dev libsqlite3-dev libssl-dev libxml2-dev \
	libxrandr-dev pyqt4-dev-tools qt4-dev-tools ros-hydro-opencv2 subversion libsvn-dev

# Install prefix WITHOUT leading '/', e.g. 'opt' for '/opt'. This 
# is both the tree that is being packed up by this script and the 
# place where it is extracted when installing the package.

INSTALL_PREFIX:=opt

# This is the install command that will install the package unter the INSTALL_PREFIX 
# If you don't want to run an installer (e.g. it's all installed under the right dir
# already then just put `true` here)
INSTALL_COMMAND=bash ./mira-installer-binary.sh ubuntu-1204lts-x64 $(GLOBAL_ROOT)

##############################################################################
# This is always needed:
include dh_bin_wizard.mk
```

## Packing up MIRA
This tool evolved from the need to pack up [MIRA](http://www.mira-project.org/) for our SCITOS G5 robots in the context of the [STRANDS FP7 project](http://strands-project.eu). So, this was the first use case.
Simply running `make -f mira.mk` will create a Debian package for mira-scitos including everything for the STRANDS system to run, based on the binary installer of MIRA.

## Packing up MORSE
The [STRANDS simulation environment](https://github.com/strands-project/strands_morse) depends on a specific version of [MORSE](http://www.openrobots.org/wiki/morse/). As MORSE has quite some specific dependencies, a Debian package containing all the specific versions of Python, Blender, etc is created running `make -f morse-strands.mk`




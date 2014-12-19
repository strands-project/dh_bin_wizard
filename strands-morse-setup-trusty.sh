#!/bin/sh
#
# This script installs STRANDS MORSE on Ubuntu 14.04. 
# It is to be used in conjuction with dh_bin_wizard.
#

PACKAGE=strands-morse-simulator
VERSION=1.3.STRANDS.0

sudo apt-get install cmake git  zlib1g-dev


echo "Install MORSE from STRANDS fork"
(cd /tmp && git clone --depth 1 --branch $VERSION https://github.com/strands-project/morse.git && \
 cd /tmp/morse && mkdir -p build && cd build && \
cmake -DCMAKE_INSTALL_PREFIX=/opt/$PACKAGE -DPYMORSE_SUPPORT=ON \
 -DBUILD_ROS_SUPPORT=ON .. && \
make install)



echo "Install python 3 rospkg into morse dist-pkgs"
cd /tmp && git clone --depth 1 --branch 1.0.33 https://github.com/ros/rospkg.git
cp -r /tmp/rospkg/src/rospkg /opt/$PACKAGE/lib/python3/dist-packages

echo "Install python 3 catkin_pkg into morse dist-pkgs"
cd /tmp && git clone --depth 1 --branch 0.2.6 https://github.com/ros-infrastructure/catkin_pkg.git
cp -r /tmp/catkin_pkg/src/catkin_pkg /opt/$PACKAGE/lib/python3/dist-packages


echo "done."
cd ${workspace}

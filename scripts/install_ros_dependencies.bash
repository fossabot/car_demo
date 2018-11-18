#!/bin/bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# get UBUNTU_CODENAME, ROS_DISTRO, REPO_DIR, CATKIN_DIR
source $SCRIPT_DIR/identify_environment.bash

export DEBIAN_FRONTEND=noninteractive

sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu $UBUNTU_CODENAME main\" > /etc/apt/sources.list.d/ros-latest.list"
wget -qO - http://packages.ros.org/ros.key | sudo apt-key add -

echo "Updating package lists ..."
sudo apt-get -qq update

echo "Installing additional ROS $ROS_DISTRO packages ..."

sudo apt-get -qq install ros-$ROS_DISTRO-rviz ros-$ROS_DISTRO-gazebo-* ros-$ROS_DISTRO-joy ros-$ROS_DISTRO-fake-localization ros-$ROS_DISTRO-robot-state-publisher > /dev/null

source /opt/ros/$ROS_DISTRO/setup.bash

# Install ign_msg0 for citysim support
echo "Installing ign_msg0 packages"

sudo apt-get -qq install libignition-common libignition-fuel-tools1-1 libignition-math4 libignition-math4-dev libignition-msgs libignition-msgs-dev libignition-transport4

hg clone https://bitbucket.org/ignitionrobotics/ign-math /tmp/ign-math
cd /tmp/ign-math/
hg pull && hg update ign-math3
mkdir build
cd build
cmake ..
make -j4
sudo make install

hg clone https://bitbucket.org/ignitionrobotics/ign-msgs /tmp/ign-msgs
cd /tmp/ign-msgs
hg pull && hg update ign-msgs0
mkdir build
cd build
cmake ..
make -j4
sudo make install

echo "Completed ign_msgs0 install"



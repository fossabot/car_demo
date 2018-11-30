#!/bin/bash
set -e

# Set Environment Variables
export UBUNTU_CODENAME=$(lsb_release -s -c)
case $UBUNTU_CODENAME in
  trusty)
    export ROS_DISTRO=indigo;;
  xenial)
    export ROS_DISTRO=kinetic;;
  bionic)
    export ROS_DISTRO=melodic;;
  *)
    echo "Unsupported version of Ubuntu detected. Only trusty (14.04.*), xenial (16.04.*), and bionic (18.04.*) are currently supported."
    exit 1
esac
export REPO_DIR=$(dirname "$SCRIPT_DIR")
export CATKIN_DIR="$HOME/catkin_ws"

# Install dependencies
apt-get update
apt-get install libignition-common libignition-fuel-tools1-1 libignition-math4 libignition-math4-dev libignition-msgs libignition-msgs-dev libignition-transport4 libprotobuf10 libprotoc10 -y

# Install ign_msg0 for citysim support
hg clone https://bitbucket.org/ignitionrobotics/ign-math /tmp/ign-math
cd /tmp/ign-math/
hg pull && hg update ign-math3
mkdir build
cd build
cmake ..
make -j4
make install

hg clone https://bitbucket.org/ignitionrobotics/ign-msgs /tmp/ign-msgs
cd /tmp/ign-msgs
hg pull && hg update ign-msgs0
mkdir build
cd build
cmake ..
make -j4
make install

# Install ouster_example
cd /root/catkin_ws/src
git clone https://github.com/wilselby/ouster_example.git

# Building the Sample ROS Node
echo "building the sample ROS node"
cd /root/catkin_ws
catkin build ouster_ros
echo "built the sample ROS node"

# Copy model files into Gazebo directory
cp -R /root/catkin_ws/src/car_demo/car_demo/models/* /usr/share/gazebo-9/models

# Build OSRF City Sim
echo "Install OSRF City Sim package..."
hg clone https://bitbucket.org/osrf/citysim
cd citysim
mkdir build
cd build
cmake ..
make install
echo "Installed OSRF City Sim"

# Setup ROS Environment
source /opt/ros/$ROS_DISTRO/setup.bash
source /root/catkin_ws/devel/setup.bash
source /usr/local/share/citysim-0/setup.sh



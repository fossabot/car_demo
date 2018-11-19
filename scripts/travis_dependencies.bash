#!/bin/bash
set -e

# Install ign_msg0 for citysim support
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

# Install ouster_example
cd /root/catkin_ws/src
git clone https://github.com/wilselby/ouster_example.git
# Building the Sample ROS Node
echo "building the sample ROS node"
cd /root/catkin_ws
catkin_make
echo "built the sample ROS node"

# Copy model files into Gazebo directory
sudo cp -R /root/catkin_ws/src/car_demo/car_demo/models/* /usr/share/gazebo-9/models

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
source ~/catkin_ws/devel/setup.bash
source /usr/local/share/citysim-0/setup.sh



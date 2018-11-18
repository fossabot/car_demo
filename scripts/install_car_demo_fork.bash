#!/bin/bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# get UBUNTU_CODENAME, ROS_DISTRO, REPO_DIR, CATKIN_DIR
source $SCRIPT_DIR/identify_environment.bash

if [ ! -d "$HOME/catkin_ws/src/car_demo" ]; then
    echo "car_demo repository not detected"
    cd "$HOME/catkin_ws/src"
    git clone https://github.com/wilselby/car_demo.git
    cd "$HOME/catkin_ws"
    catkin_make
    echo "Package built successfully"
else
    echo "car_demo already installed"
fi

# Source the workspace
source $HOME/catkin_ws/devel/setup.bash

# Copy model files into Gazebo directory
sudo cp -R $HOME/catkin_ws/src/car_demo/car_demo/models/* /usr/share/gazebo-9/models

# Build OSRF City Sim
echo "Install OSRF City Sim package..."
hg clone https://bitbucket.org/osrf/citysim
cd citysim
mkdir build
cd build
cmake ..
make install

#Source setup file
source /usr/local/share/citysim-0/setup.sh


#!/bin/bash

xhost +local:root
IMG=wilselby/ros_melodic:city_sim

# If NVIDIA is present, use Nvidia-docker
if test -c /dev/nvidia0
then
    docker run --rm -it \
      --runtime=nvidia \
      --privileged \
      --device /dev/dri:/dev/dri \
      --env="DISPLAY" \
      --env="QT_X11_NO_MITSHM=1" \
      -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
      -v "/dev/input:/dev/input" \
      $IMG \
      bash
else
    docker run --rm -it \
      -e DISPLAY \
      --device=/dev/dri:/dev/dri \
      -v "/tmp/.X11-unix:/tmp/.X11-unix" \
      -v "/dev/input:/dev/input" \
      $IMG \
      bash
fi

# Check Joystick
# ls /dev/input/j*
#jstest-gtk

# Run City demo
#roslaunch car_demo demo_os1_mcity.launch

# Run City Sim demo
#roslaunch car_demo demo_os1_simcity.launch

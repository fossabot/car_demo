[![Docker Stars](https://img.shields.io/docker/stars/wilselby/car_demo.svg)](https://hub.docker.com/r/wilselby/car_demo/)
[![Docker Pulls](https://img.shields.io/docker/pulls/wilselby/car_demo.svg)](https://hub.docker.com/r/wilselby/car_demo/)
[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/wilselby/car_demo/blob/master/LICENSE)

# Demo of Prius in ROS/GAZEBO
This project is a fork of the [OSRF Car Demo](https://github.com/osrf/car_demo) and also includes the SimCity model from [here](https://bitbucket.org/osrf/citysim/src/default/). 

This is a simulation of a Prius in [gazebo 8](http://gazebosim.org) with sensor data being published using [ROS kinetic](http://wiki.ros.org/kinetic/Installation).

The car's throttle, brake, steering, and gear shifting are controlled by publishing a ROS message.
A ROS node allows driving with a gamepad or joystick.

The model has been updated to contain an Ouster OS-1-64 LIDAR sensor using a fork of Ouster's open source client [here](https://github.com/wilselby/ouster_example).

# Video + Pictures

A video and screenshots of the demo can be seen in this blog post: https://www.osrfoundation.org/simulated-car-demo/

![Prius Image](https://www.osrfoundation.org/wordpress2/wp-content/uploads/2017/06/prius_roundabout_exit.png)

# Requirements

This demo has been tested on Ubuntu Xenial (16.04)

* An X server
* [Docker](https://www.docker.com/get-docker)

# Recommended

* A joystick
* A joystick driver which creates links to `/dev/input/js0` or `/dev/input/js1`

This has been tested with an Xbox 360 controller. If you have a different joystick you may need to adjust the parameters for the very basic joystick_translator node: https://github.com/wilselby/car_demo/blob/master/car_demo/nodes/joystick_translator

# Building

First clone the repo, then run the script `run-docker.sh`.
It builds a docker image with the local source code inside.

```
$ cd car_demo
$ ./run-docker.sh
```

# Running

Connect a game controller to your PC.

Source the catkin workspace
```
$ source ~/catkin_ws/devel/setup.bash
```

Source setup file
```
$ source /usr/local/share/citysim-0/setup.sh
```

## Run City demo
You can launch the MCity world in Gazebo with a Pruis as well as RVIZ for visualizations with the following command:
```
$ roslaunch car_demo demo_os1_mcity.launch
```

## Run City Sim demo
You can launch the City Sim world in Gazebo with a Prius as well as RVIZ for visualizations with the following command:

```
$ roslaunch car_demo demo_os1_simcity.launch
```

## Vehicle Control
Either use the controller to drive the prius around the world, or click on the gazebo window and use the `WASD` keys to drive the car.

* The right stick controls throttle and brake
* The left stick controls steering
* Y puts the car into DRIVE
* A puts the car into REVERSE
* B puts the car into NEUTRAL

#!/bin/bash

sudo apt update && sudo apt install curl
curl http://repo.ros2.org/repos.key | sudo apt-key add -
sudo sh -c 'echo "deb http://repo.ros2.org/ubuntu/main xenial main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo apt update
sudo apt install `apt list ros-r2b3-* 2> /dev/null | grep "/" | awk -F/ '{print $1}' | grep -v -e ros-r2b3-ros1-bridge -e ros-r2b3-turtlebot2- | tr "\n" " "`
sudo apt install ros-r2b3-ros1-bridge ros-r2b3-turtlebot2-*

exit 0

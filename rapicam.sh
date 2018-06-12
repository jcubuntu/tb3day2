#!/bin/bash

echo "[Install raspicam node]
cd ~/catkin_ws/src
git clone https://github.com/UbiquityRobotics/raspicam_node.git
sudo apt-get install -y ros-kinetic-compressed-image-transport ros-kinetic-camera-info-manager
cd ~/catkin_ws && catkin_make

#!/bin/bash
# Apache License 2.0
# Copyright (c) 2017, ROBOTIS CO., LTD.

echo ""
echo "[Note] Target OS version  >>> Ubuntu Mate for the Raspberry Pi"
echo "[Note] Target ROS version >>> ROS Kinetic Kame"
echo "[Note] Catkin workspace   >>> $HOME/catkin_ws"
echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read

echo "[Set the target OS, ROS version and name of catkin workspace]"
name_os_version=${name_os_version:="xenial"}
name_ros_version=${name_ros_version:="kinetic"}
name_catkin_workspace=${name_catkin_workspace:="catkin_ws"}

echo "[Update the package lists and upgrade them]"
sudo apt-get update -y
sudo apt-get upgrade -y

echo "[Install build environment, the chrony, ntpdate and set the ntpdate]"
sudo apt-get install -y chrony ntpdate build-essential
sudo ntpdate ntp.ubuntu.com

echo "[Add the ROS repository]"
if [ ! -e /etc/apt/sources.list.d/ros-latest.list ]; then
  sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu ${name_os_version} main\" > /etc/apt/sources.list.d/ros-latest.list"
fi

echo "[Download the ROS keys]"
roskey=`apt-key list | grep "ROS Builder"`
if [ -z "$roskey" ]; then
  sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
fi

echo "[Check the ROS keys]"
roskey=`apt-key list | grep "ROS Builder"`
if [ -n "$roskey" ]; then
  echo "[ROS key exists in the list]"
else
  echo "[Failed to receive the ROS key, aborts the installation]"
  exit 0
fi

echo "[Update the package lists and upgrade them]"
sudo apt-get update -y
sudo apt-get upgrade -y

echo "[Install the ros-base]"
sudo apt-get install -y ros-$name_ros_version-ros-base

echo "[Initialize rosdep]"
sudo sh -c "rosdep init"
rosdep update

echo "[Environment setup and getting rosinstall]"
source /opt/ros/$name_ros_version/setup.sh
sudo apt-get install -y python-rosinstall

echo "[Make the catkin workspace and test the catkin_make]"
sudo rm -rf ~/catkin_ws
mkdir -p $HOME/$name_catkin_workspace/src
cd $HOME/$name_catkin_workspace/src
catkin_init_workspace
cd $HOME/$name_catkin_workspace
catkin_make

source $HOME/.bashrc
sh -c "echo \"alias eb='nano ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias sb='source ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias gs='git status'\" >> ~/.bashrc"
sh -c "echo \"alias gp='git pull'\" >> ~/.bashrc"
sh -c "echo \"alias cw='cd ~/$name_catkin_workspace'\" >> ~/.bashrc"
sh -c "echo \"alias cs='cd ~/$name_catkin_workspace/src'\" >> ~/.bashrc"
sh -c "echo \"alias cm='cd ~/$name_catkin_workspace && catkin_make'\" >> ~/.bashrc"

sh -c "echo \"source /opt/ros/$name_ros_version/setup.bash\" >> ~/.bashrc"
sh -c "echo \"source ~/$name_catkin_workspace/devel/setup.bash\" >> ~/.bashrc"

sh -c "echo \"export ROS_MASTER_URI=http://localhost:11311\" >> ~/.bashrc"
sh -c "echo \"export ROS_HOSTNAME=localhost\" >> ~/.bashrc"
sh -c "echo \"export TURTLEBOT3_MODEL=burger\" >> ~/.bashrc"
sh -c "echo \"export PATH=$PATH:$HOME/easyscript\" >> ~/.bashrc"

echo "[Install Turtlebot 3 Source]"

cd $HOME/catkin_ws/src
git clone https://github.com/ROBOTIS-GIT/hls_lfcd_lds_driver.git
git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone https://github.com/ROBOTIS-GIT/turtlebot3.git
cd $HOME/catkin_ws/src/turtlebot3
sudo rm -r turtlebot3_description/ turtlebot3_teleop/ turtlebot3_navigation/ turtlebot3_slam/ turtlebot3_example/
cd $HOME/catkin_ws && catkin_make

sudo apt-get install -y ros-kinetic-compressed-image-transport ros-kinetic-camera-info-manager


sudo apt-get install -y ros-kinetic-rosserial-python ros-kinetic-tf
sudo apt-get install -y ros-kinetic-image-transport ros-kinetic-cv-bridge ros-kinetic-vision-opencv python-opencv libopencv-dev ros-kinetic-image-proc


echo "[Complete!!!]"
exit 0

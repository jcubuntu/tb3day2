cd $HOME/catkin_ws/src
git clone https://github.com/UbiquityRobotics/raspicam_node.git
git clone https://github.com/ROBOTIS-GIT/turtlebot3_autorace.git
cd $HOME/catkin_ws && catkin_make

rosrun turtlebot3_bringup create_udev_rules

#!/bin/bash
# Apache License 2.0
# Copyright (c) 2017, JCUBUNTU CO., LTD.

echo "Setting Lane Dettect to Calibrate Mode"
export AUTO_DT_CALIB=action
roslaunch turtlebot3_autorace_detect turtlebot3_autorace_detect_lane.launch

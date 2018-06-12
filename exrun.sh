#!/bin/bash
# Apache License 2.0
# Copyright (c) 2017, JCUBUNTU CO., LTD.

echo "Setting Extrinsic to Calibrate Mode"
export AUTO_EX_CALIB=action
roslaunch turtlebot3_autorace_camera turtlebot3_autorace_extrinsic_camera_calibration.launch




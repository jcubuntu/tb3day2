#!/bin/bash
# Apache License 2.0
# Copyright (c) 2017, JCUBUNTU CO., LTD.

echo "Setting Intrinsic to Calibrate Mode"
export AUTO_IN_CALIB=calibrate
roslaunch turtlebot3_autorace_camera turtlebot3_autorace_intrinsic_camera_calibration.launch




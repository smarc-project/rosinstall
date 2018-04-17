# rosinstall
Installation instructions and rosinstall configuration for the SMARC software packages

```
sudo apt-get install python-wstool ros-kinetic-gazebo-msgs ros-kinetic-gazebo-plugins ros-kinetic-gazebo-ros ros-kinetic-gazebo-ros-pkgs ros-kinetic-ros-control ros-kinetic-gazebo-ros-control ros-kinetic-joint-state-controller ros-kinetic-effort-controllers python-pygame protobuf-c-compiler protobuf-compiler ros-kinetic-joy ros-kinetic-joy-teleop ros-kinetic-robot-state-publisher 
```

```
mkdir catkin_ws
cd catkin_ws
wstool init src
catkin_init_workspace src
cd src
wstool merge https://raw.githubusercontent.com/smarc-project/rosinstall/master/smarc_system.rosinstall
wstool update
```

```
cd ..
catkin_make
```

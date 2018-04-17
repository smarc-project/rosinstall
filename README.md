# rosinstall
Installation instructions and rosinstall configuration for the SMARC software packages

## Installation instructions

Follow the instructions here to install the SMARC ros packages.

## Install binary packages

Just execute the following command to get all the necessary binary packages for the SMARC system:
```
sudo apt-get install python-wstool ros-kinetic-gazebo-msgs ros-kinetic-gazebo-plugins ros-kinetic-gazebo-ros ros-kinetic-gazebo-ros-pkgs ros-kinetic-ros-control ros-kinetic-gazebo-ros-control ros-kinetic-joint-state-controller ros-kinetic-effort-controllers python-pygame protobuf-c-compiler protobuf-compiler ros-kinetic-joy ros-kinetic-joy-teleop ros-kinetic-robot-state-publisher 
```

## Setup a catkin workspace

Start by setting up workspace in a directory of your choosing.
Note that you can name it something else than `catkin_ws` if you wish:
```
mkdir catkin_ws
cd catkin_ws
wstool init src
catkin_init_workspace src
```

Now let's add the SMARC software to the workspace using `wstool`:
```
cd src
wstool merge https://raw.githubusercontent.com/smarc-project/rosinstall/master/smarc_system.rosinstall
wstool update
```

Now we should have fetched all the packages from github. If you inspect
the current directory (`src`) it should contain a bunch of folders.
Now we should be able to build the packages:
```
cd ..
catkin_make
catkin_make install
```

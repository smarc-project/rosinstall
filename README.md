# rosinstall
Installation instructions and rosinstall configuration for the SMARC software packages

## Installation instructions

Follow the instructions here to install the SMARC ros packages.
The instructions assume that you are running Ubuntu 16.04, and have already
installed ROS Kinetic by following the instructions at http://wiki.ros.org/kinetic/Installation/Ubuntu .

### Install binary packages

Just execute the following command to get all the necessary binary packages for the SMARC system:
```
sudo apt-get install python-wstool ros-kinetic-gazebo-msgs ros-kinetic-gazebo-plugins ros-kinetic-gazebo-ros ros-kinetic-gazebo-ros-pkgs ros-kinetic-ros-control ros-kinetic-gazebo-ros-control ros-kinetic-joint-state-controller ros-kinetic-effort-controllers python-pygame protobuf-c-compiler protobuf-compiler ros-kinetic-joy ros-kinetic-joy-teleop ros-kinetic-robot-state-publisher ros-kinetic-costmap-2d ros-kinetic-tf2-geometry-msgs
```

### Setup a catkin workspace

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

### (Optional) Clone additional packages

If you have access to the `smarc_private_auvs` package, you can clone
that with git in this step. If you have a copy of the package, make
sure to paste it in the current directory (i.e. `catkin_ws/src`).

### Building the packages

Now we should be able to build the packages:
```
cd ..
catkin_make
catkin_make install
```
## Running a simple example

When running the files, we first need to source the catkin workspace.
If you are in the `catkin_ws` folder, do this by:
```
source devel/setup.bash
```
You might want to add `source /path/to/catkin_ws/devel/setup.bash` to your `~/.bashrc`.

You should now be able to run a simple simulator example.
First, let's launch a gazebo world using:
```
roslaunch smarc_bringup auv_scenarios.launch
```
Now, let's launch an AUV using:
```
roslaunch smarc_bringup auv_model.launch
```
For more info on these launch files, see https://github.com/smarc-project/smarc_utils/tree/master/smarc_bringup

You should now have a gazebo window and an AUV floating somewhere in the world!

## Updating the software packages

You can use wstool to update the SMARC packages of your workspace
to the newest version by running `wstool update` inside the `catkin_ws/src` folder.

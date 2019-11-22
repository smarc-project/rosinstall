# rosinstall
Installation instructions and rosinstall configuration for the SMARC software packages

## ROS Install

Follow the instructions here to install the SMARC ros packages.
The instructions assume that you are running Ubuntu 16.04 and ROS Kinetic,
or Ubuntu 18.04 and ROS Melodic. You can go to the ROS packages to find
detailed installation instructions for
[Kinetic](http://wiki.ros.org/kinetic/Installation/Ubuntu)
and [Melodic](http://wiki.ros.org/melodic/Installation/Ubuntu).
We will assume that you have set up a [catkin workspace](http://wiki.ros.org/catkin/Tutorials/create_a_workspace)
somewhere and we will refer to the path there as `catkin_ws`.

## Dependencies

```
sudo apt install sudo apt install python3-vcstool libsdl2-dev libglew-dev libfreetype6-dev ros-${ROS_DISTRO}-py-trees-ros ros-${ROS_DISTRO}-tf2-geometry-msgs
```

## Get packages

The following steps assumes that you have create your [catkin workspace](http://wiki.ros.org/catkin/Tutorials/create_a_workspace)
and that you have gone to the `catkin_ws/src` folder, where we will place the packages.
You may execute several of these commands if you want to have all packages in the same place,
but note that the private SAM sim is a strict superset of the public one,
so **no need to install both**.

### Open SAM AUV simulation

To get the packages needed for the open SAM simulation, execute:
```
curl https://raw.githubusercontent.com/smarc-project/rosinstall/master/sam_sim.rosinstall | vcs import --recursive
```
Note that this may take some time, so be patient.

### Private high-def SAM AUV simulation

For this step you need to be a member of the SMaRC project and have access to [KTH gitr](https://gitr.sys.kth.se).
To get the packages needed for higher-definition SAM simulation, execute:
```
curl https://raw.githubusercontent.com/smarc-project/rosinstall/master/sam_sim_private.rosinstall | vcs import --recursive --w 1
```
Note that this may take some time. You will also need to enter your account name and password several times
unless you have added them to your keychain.

### Private SAM AUV drivers

For this step you need to be a member of the SMaRC project and have access to [KTH gitr](https://gitr.sys.kth.se).
To get the packages necessary for running the robot, execute:
```
curl https://raw.githubusercontent.com/smarc-project/rosinstall/master/sam_robot.rosinstall | vcs import --recursive --w 1
```
Note that this may take some time. You will also need to enter your account name and password several times
unless you have added them to your keychain.

## Compile

Within the `catkin_ws` folder, execute:
```
catkin_make -DCMAKE_BUILD_TYPE=Release
```

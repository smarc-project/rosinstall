# rosinstall
Installation instructions and rosinstall configuration for the SMARC software packages

## Binary install

We currently support binary packages for ROS melodic on x86-64 Ubuntu 18.04 and ROS noetic on x86-64 Ubuntu 20.04.
The following steps require first installing ROS [melodic](http://wiki.ros.org/melodic/Installation/Ubuntu)
or [noetic](http://wiki.ros.org/noetic/Installation/Ubuntu), including sourcing the ROS environment
([melodic](http://wiki.ros.org/melodic/Installation/Ubuntu#melodic.2FInstallation.2FDebEnvironment.Environment_setup), [noetic](http://wiki.ros.org/noetic/Installation/Ubuntu#noetic.2FInstallation.2FDebEnvironment.Environment_setup)) and setting up rosdep ([melodic](http://wiki.ros.org/melodic/Installation/Ubuntu#Installation.2FUbuntu.2FBinariesBuildDependencies.Dependencies_for_building_packages), [noetic](http://wiki.ros.org/noetic/Installation/Ubuntu#Dependencies_for_building_packages)).
Execute them one-by-one, in order:

```
sudo curl https://raw.githubusercontent.com/smarc-project/rosinstall/master/sources.list.d/smarc-$ROS_DISTRO-latest.list -o /etc/apt/sources.list.d/smarc-latest.list
sudo curl https://raw.githubusercontent.com/smarc-project/rosinstall/master/rosdep/50-smarc-$ROS_DISTRO.list -o /etc/ros/rosdep/sources.list.d/50-smarc.list  
sudo apt update
sudo apt upgrade
rosdep update
```

When complete, any of the [released SMARC packages](https://github.com/smarc-project/rosinstall/blob/master/rosdep/melodic/smarc.yaml)
can be installed via `apt`. For example, to install the SAM or LOLO stonefish simulators, type `sudo apt install ros-$ROS_DISTRO-sam-stonefish-sim` or `sudo apt install ros-$ROS_DISTRO-lolo-stonefish-sim`.
Running these nodes does not require sourcing any workspace.
If you want to install **all** SMARC packages released for the desktop install, use `sudo apt install ros-$ROS_DISTRO-smarc-desktop`.

To run the simulation with the GUI, run `rosrun <vehicle>_stonefish_sim bringup.sh` where `<vehicle>` is either `sam` or `lolo`.
To kill everything started by the bringup script, `tmux kill-session` can be used in any terminal.
To install and run custom or non-apt packages, install catkin: `apt install python3-catkin-tools`, configure it to install packages into the install directories: `catkin config --install` (where you have the custom packages in `catkin_ws/src`) and then build and install things in your catkin workspace with `catkin build <package name>` where `<package name>` could be omitted to build everything. These custom installed packages will override the apt-installed ones when you run the bringups. 

If you want to test the install by running a simple simulation, follow the [SAM instructions here](https://github.com/smarc-project/smarc_stonefish_sims/tree/noetic-devel/sam_stonefish_sim#running)
or the [LOLO instructions here](https://github.com/smarc-project/smarc_stonefish_sims/tree/noetic-devel/lolo_stonefish_sim#running).

### Package status

You can check [the released SMARC package](https://github.com/smarc-project/rosinstall/blob/master/rosdep/melodic/smarc.yaml)
to see if your package has been released.

If you want to update one of them or release a new package, have a look at the [release repo](https://github.com/smarc-project/smarc_releases).

## Manual Install

**NOTE**: It is recommanded to use the [binary install instructions](https://github.com/smarc-project/rosinstall#binary-install)
for your personal `x86-64` computer. However, if your OS is not supported or if you are installing
on a robot with an `arm` computer, follow the instructions below.

Follow the instructions here to install the SMARC ros packages.
The instructions assume that you are running Ubuntu 16.04 and ROS Kinetic,
or Ubuntu 18.04 and ROS Melodic, with at least `ros-${ROS_DISTRO}-desktop` packages.
You can go to the ROS packages to find detailed installation instructions for
[Kinetic](http://wiki.ros.org/kinetic/Installation/Ubuntu)
and [Melodic](http://wiki.ros.org/melodic/Installation/Ubuntu).
We will assume that you have set up a [catkin workspace](http://wiki.ros.org/catkin/Tutorials/create_a_workspace)
somewhere and we will refer to the path there as `catkin_ws`.

### Dependencies

Start by installing packages needed for both the simulator and the robot:
```
sudo apt install tmux python3-vcstool libsdl2-dev libglew-dev python3-pip libfreetype6-dev ros-${ROS_DISTRO}-rosmon ros-${ROS_DISTRO}-py-trees-ros ros-${ROS_DISTRO}-tf2-geometry-msgs ros-${ROS_DISTRO}-pid ros-${ROS_DISTRO}-geodesy ros-${ROS_DISTRO}-nmea-navsat-driver ros-${ROS_DISTRO}-robot-localization ros-${ROS_DISTRO}-sbg-driver
```

If you want to use the web interface you will also need to install these packages with pip3:
```
pip3 install flexx rospkg
```

### Get packages

The following steps assumes that you have create your [catkin workspace](http://wiki.ros.org/catkin/Tutorials/create_a_workspace)
and that you have gone to the `catkin_ws/src` folder, where we will place the packages.
You may execute several of these commands if you want to have all packages in the same place,
but note that the private SAM sim is a strict superset of the public one,
so **no need to install both**.

#### Open SAM AUV simulation

To get the packages needed for the open SAM simulation, execute:
```
curl https://raw.githubusercontent.com/smarc-project/rosinstall/master/sam_sim.rosinstall | vcs import --recursive
```
Note that this may take some time, so be patient.

#### Private high-def SAM AUV simulation

For this step you need to be a member of the SMaRC project and have access to [KTH gitr](https://gitr.sys.kth.se).
To get the packages needed for higher-definition SAM simulation, execute:
```
curl https://raw.githubusercontent.com/smarc-project/rosinstall/master/sam_sim_private.rosinstall | vcs import --recursive --w 1
```
Note that this may take some time. You will also need to enter your account name and password several times
unless you have added them to your keychain.

#### Private SAM AUV drivers

For this step you need to be a member of the SMaRC project and have access to [KTH gitr](https://gitr.sys.kth.se).
The SAM AUV drivers requires a few extra dependencies:
```
sudo apt install ros-${ROS_DISTRO}-pcl-ros ros-${ROS_DISTRO}-gazebo-msgs ros-${ROS_DISTRO}-rqt-py-trees
```
You will also need to follow the [instructions here](https://github.com/smarc-project/uavcan_ros_bridge#dependencies--building) to install libuavcan.


To get the packages necessary for running the robot, execute:
```
curl https://raw.githubusercontent.com/smarc-project/rosinstall/master/sam_robot.rosinstall | vcs import --recursive --w 1
```
Note that this may take some time. You will also need to enter your account name and password several times
unless you have added them to your keychain.

### Compile and export

Within the `catkin_ws` folder, execute:
```
catkin_make -DCMAKE_BUILD_TYPE=Release
```
When finished, you may want to add the workspace to
your `~/.bashrc`. Note that you need to modify the path to the workspace:
```
echo "source /path/to/catkin_ws/devel/setup.bash" >> ~/.bashrc
```
### Running the simulation

These instructions assume that you have installed flexx and rospkg from the
instructions above. You may encounter problems if you have installed
an older version of `robot-webtools` under `Kinetic`. In that case, you
may need to explicitly install a certain version of tornado, e.g. using `pip3 install tornado==5`.

Run the simulator with the web GUI using:
```
rosrun sam_stonefish_sim bringup.sh
```
This will open a tmux session with everything needed to run
the base simulator, including mission planning and execution.
If you also want to run the attitude controllers (only available in private version),
you need to go into tab number 3 in the tmux session and press enter to execute those.

Open a web browser and go to the address [`http://localhost:8097/`](http://localhost:8097/).

1. Press the `start` button next to `p2_sam_sim` to run the simulation. You can now move the `Actuator setpoint` sliders of the LCG and VBS actuators in the web gui. You can see the effect of this on the vehicle in the simulatio window
2. Press the `start` button next to `p4_sam_nav` to run the mission executor. If you want to plan and run a plan using [Neptus](https://lsts.fe.up.pt/toolchain/neptus), follow the instructions [here](https://github.com/smarc-project/imc_ros_bridge#neptus-auv-integration).
3. If you start the attitude controllers in tab 3 of the tmux section, you can also press `start` next to `p3_sam_att_ctrl`. You can then change the `Controller setpoint` slider to change the pitch and depth directly

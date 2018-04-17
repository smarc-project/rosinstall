# rosinstall
Installation instructions and rosinstall configuration for the SMARC software packages

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

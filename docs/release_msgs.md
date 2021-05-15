Re-releasing after a ROS point release
======================================

The message definitions need to be re-released every time
the upstream ROS distribution issues a point release.
This list includes all the packages that contain message definitions:

* `smarc-project/uavcan_ros_bridge/uavcan_ros_msgs`
* `smarc-project/imc_ros_bridge`
* `smarc-project/sam_common/sam_msgs`
* `smarc-project/smarc_msgs`
* `smarc-project/lolo_common/lolo_msgs`
* `nilsbore/geographic_info/geographic_msgs`
* `nilsbore/cola2_msgs_mirror`

Signs of the released packages not being up to date with the
upstream ROS release includes topics being published but not being
able to subscribe to them in a node or using `rostopic echo`.

User guide
----------

If the administrator has already re-releases the packages above,
uninstall them using
`sudo apt remove ros-melodic-smarc-msgs ros-melodic-cola2-msgs ros-melodic-geographic-msgs ros-melodic-imc-ros-bridge ros-melodic-sam-msgs ros-melodic-lolo-msgs`
then reinstall any package you want e.g. using `sudo apt install ros-melodic-sam-stonefish-sim`.
This will reinstall any necessary package that you just uninstalled.

Administrator guide
-------------------

Simply tag a new release in each of the repos listed above.
When the `release-deb` builds have finished in all repos, go
to the package server computer and run `make_package_repository.sh msg_sources.yaml`,
similar to when running a full release. However, in this case only the packages
listed above are re-releases. If a user has already installed these packages,
he/she needs to reinstall them using the steps described above.

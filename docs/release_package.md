# Releasing packages into the SMARC package repository

## User guide

### Install rules

All executables and libraries need install rules in order to be release.
See the bottom of [the catkin cmake docs](http://wiki.ros.org/catkin/CMakeLists.txt) for instructions.
Or look at [an example](https://github.com/smarc-project/sam_stonefish_sim/blob/noetic-devel/CMakeLists.txt).
Test locally by configuring your workspace with `catkin config --install`.
After sourcing `install/setup.bash`, your package should run as normal.

### Add package (not needed for updates)

#### Release file

For a multi-package repo, you need to add your package to the `release_packages.yaml` file in the root of
the repo. If the package depends on other packages in the repo, they also need to be released in this file.
The order matters, packages that are dependencies of others need to appear before those in the file.
See [this file](https://github.com/smarc-project/lolo_common/blob/noetic-devel/release_packages.yaml) for an example setup.
Here, `lolo_drivers` depends on `lolo_msgs`, and therefore appears later in the file.

#### Rosdep file

The first time you release a package, you also need to add an
entry to [the rosdep registry](https://github.com/smarc-project/rosinstall/blob/master/rosdep/melodic/smarc.yaml)
and submit a PR with the change. See the other entries for examples on how it should look.

### Build and add new package or update

Ping @nilsbore, preferrably when submitting the pull request with the new changes.
Since the package might not build on the release server if there errors, this may take a few iterations back and forth.

## Administrator guide

### Tag a release

The `.github/workflows/release.yml` workflow (named `release-deb`) in the respective repos
is triggered on tagging a new release. This can be done in the interface on the right in the online github interface.
In the actions menu, the state of the build can be monitored. If successful, a new `ros-melodic-*.deb` file should
be attached to the newly created release.

### Build the package repo

The package repository hosts the deb files together with the package registry.

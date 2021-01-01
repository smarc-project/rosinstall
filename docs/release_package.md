# Releasing packages into the SMARC package repository

## User guide

### Install rules

All executables and libraries need install rules in order to be released.
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

### Update package version (only needed for updates)

Increment the version in your package's `package.xml` file. It contains three numbers: `X.Y.Z`.
The following number should be incremented depending on the size of the update:
* `X` if a major breaking change (very unusual, do with caution)
* `Y` if the update is major
* `Z` if it is a bug fix or small improvement

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
The [`make_package_repository.sh` script](https://github.com/smarc-project/rosinstall/blob/master/scripts/make_package_repository.sh)
downloads the debs associated with the latest releases in the repos given by
[this file](https://github.com/smarc-project/rosinstall/blob/master/scripts/package_repo/sources.yaml).
They are stored in the `debian` folder. Make sure to remove that before re-running this script.
The script will also run `dpkg-scanpackages` to create a package registry file within this folder.
The [`serve_package_repository_py.sh` script](https://github.com/smarc-project/rosinstall/blob/master/scripts/serve_package_repository_py3.sh)
is used to serve the `package_repo` folder as a website than can be added to the local
apt config via [the steps described here](https://github.com/smarc-project/rosinstall#binary-install).

On the server, there should usually be a tmux server called `webserver` where the `serve_package_repository_py.sh` script is running.


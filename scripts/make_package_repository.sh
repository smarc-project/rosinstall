mkdir -p simple_debian_repo
cd simple_debian_repo
mkdir -p debian

curl -s https://api.github.com/repos/nilsbore/smarc_msgs/releases/latest \
| grep "bloom-release-deb.zip" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -

unzip bloom-release-deb.zip -d debian #-o

dpkg-scanpackages debian /dev/null | gzip -9c > debian/Packages.gz

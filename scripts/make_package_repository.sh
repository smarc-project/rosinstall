cd package_repo
    
for distro in debian noetic; do
    mkdir -p ${distro}
done

mv debian melodic # for backwards compatibility

while read line; do
    pkg=$(echo $line | cut -c3-)
    echo "Doing ${pkg}"
    for distro in melodic noetic; do
        curl -s https://api.github.com/repos/${pkg}/releases/latest \
        | grep "bloom-${distro}-release-deb.zip" \
        | cut -d : -f 2,3 \
        | tr -d \" \
        | wget -qi -

        unzip bloom-${distro}-release-deb.zip -d ${distro}/ #--out
        rm bloom-${distro}-release-deb.zip
    done
done < sources.yaml

mv melodic debian # for backwards compatibility

for distro in debian noetic; do
    dpkg-scanpackages ${distro} /dev/null | gzip -9c > ${distro}/Packages.gz
done


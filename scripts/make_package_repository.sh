cd package_repo
mkdir -p debian

while read line; do
    pkg=$(echo $line | cut -c3-)
    echo "Doing ${pkg}"
    curl -s https://api.github.com/repos/${pkg}/releases/latest \
    | grep "bloom-release-deb.zip" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -qi -

    unzip bloom-release-deb.zip -d debian/ #--out
    rm bloom-release-deb.zip
done < sources.yaml

dpkg-scanpackages debian /dev/null | gzip -9c > debian/Packages.gz

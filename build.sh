# #!/bin/bash

[ ! "$SUDO_USER" ] && {
  echo "Execute esse script como root:"
  echo
  echo "  sudo $0"
  echo
  exit 1
}

caminho=$(pwd)

mkdir build
cp -vrp $caminho/DEBIAN/ $caminho/build/
cp -vrp $caminho/usr/ $caminho/build/

cd build

sudo chown -R root:root $caminho/build/
sudo chmod 755 -Rf $caminho/build/

dpkg-deb -b $caminho/build/ $caminho

mv $caminho/*.deb $caminho/gestorKernel.deb

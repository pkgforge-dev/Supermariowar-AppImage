#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm libdecor

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
PRE_BUILD_CMDS="sed -i 's|-DSMW_DATADIR:path=\"/var/lib/smw\"|-DSMW_DATADIR:path=\"\$APPDIR/bin/data\"|' ./PKGBUILD" make-aur-package supermariowar-git

# If the application needs to be manually built that has to be done down here
mkdir -p ./AppDir/bin
#mv -v /var/lib/smw/* ./AppDir/bin

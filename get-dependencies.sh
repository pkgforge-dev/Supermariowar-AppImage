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
make-aur-package sdl2
PRE_BUILD_CMDS="sed -i '\|-DSMW_DATADIR:path=\"/var/lib/smw\"|d' ./PKGBUILD" make-aur-package supermariowar-git

# If the application needs to be manually built that has to be done down here
mkdir -p ./AppDir/bin/data
mv -v /usr/share/games/smw/* ./AppDir/bin/data

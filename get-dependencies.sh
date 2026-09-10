#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake      \
    enet       \
    pkgconf    \
    sdl3_image \
    sdl3_mixer \
    toml11

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

# Comment this out if you need an AUR package
#make-aur-package sdl2
#PRE_BUILD_CMDS="sed -i '\|-DSMW_DATADIR|d; s/.\?enet.\?\s//' ./PKGBUILD" make-aur-package supermariowar-git

# If the application needs to be manually built that has to be done down here
#mkdir -p ./AppDir/bin/data
#mv -v /usr/share/games/smw/* ./AppDir/bin/data

echo "Building Super Mario War..."
echo "---------------------------------------------------------------"
REPO="https://github.com/mmatyas/supermariowar"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive -b sdl3 --depth 1 "$REPO" ./supermariowar
echo "$VERSION" > ~/version


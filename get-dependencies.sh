#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake      \
    enet       \
    sdl3_image \
    sdl3_mixer \
    toml11

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

echo "Building Super Mario War..."
echo "---------------------------------------------------------------"
REPO="https://github.com/mmatyas/supermariowar"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive -b sdl3 --depth 1 "$REPO" ./supermariowar
echo "$VERSION" > ~/version

cmake -B build -S supermariowar \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/ \
    -DBUILD_STATIC_LIBS=OFF
cmake --build build -j$(nproc)
cmake --install build

mkdir -p ./AppDir/bin/data
mv -v /usr/share/games/smw/* ./AppDir/bin/data

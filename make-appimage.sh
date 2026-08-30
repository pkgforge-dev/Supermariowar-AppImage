#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q supermariowar-git | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/32x32/apps/smw.png
export DESKTOP=/usr/share/applications/supermariowar.desktop
export STARTUPWMCLASS=smw
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun /usr/bin/smw /usr/bin/smw-leveledit /usr/bin/smw-server /usr/bin/smw-worldedit /usr/lib/libvorbisfile.so.3

# Turn AppDir into AppImage
quick-sharun --make-appimage

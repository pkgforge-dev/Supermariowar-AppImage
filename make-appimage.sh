#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q supermariowar-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/32x32/apps/smw.png
export DESKTOP=/usr/share/applications/supermariowar.desktop
export STARTUPWMCLASS=smw
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/smw /usr/bin/smw-leveledit /usr/bin/smw-server /usr/bin/smw-worldedit /usr/lib/libvorbisfile.so.3

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --simple-test ./dist/*.AppImage

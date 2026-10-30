#! /usr/bin/env bash
# This script prints out the desktop entry of the selected app
# It's meant for copying attributes like categories and mimeTypes

read -p "Maintainer: " MAINTAINER
read -p "Package name: " APP
read -p "Version: " VER

cd /tmp
curl -LO "https://github.com/${MAINTAINER}/${APP}/releases/download/v${VER}/${APP}-${VER}-linux-x86_64.AppImage"
nix shell nixpkgs#p7zip -c 7z x -osquashfs-root ${APP}-${VER}-linux-x86_64.AppImage
# Note: this probably won't work for different maintainers, you will have to find the .desktop file name yourself
cat /tmp/squashfs-root/ai.storyteller.${APP}.desktop

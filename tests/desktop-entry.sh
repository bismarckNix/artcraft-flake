#! /usr/bin/env bash
# This script prints out the desktop entry of the selected app
# It's meant for copying attributes like categories and mimeTypes

read -p "Package name: " APP
read -p "Version: " VER

cd /tmp
curl -LO "https://github.com/storytold/${APP}/releases/download/v${VER}/${APP}-${VER}-linux-x86_64.AppImage"
nix shell nixpkgs#p7zip -c 7z x -osquashfs-root ${APP}-${VER}-linux-x86_64.AppImage
cat /tmp/squashfs-root/ai.storyteller.${APP}.desktop

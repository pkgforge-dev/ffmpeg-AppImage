#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q ffmpeg | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://github.com/FFmpeg.png
export DESKTOP=DUMMY
export MAIN_BIN=ffmpeg

# Deploy dependencies
quick-sharun \
	/usr/bin/ffmpeg       \
	/usr/bin/ffplay       \
	/usr/bin/ffprobe      \
	/usr/bin/qt-faststart \
	/usr/share/ffmpeg

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

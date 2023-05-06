#!/bin/bash

set -e

source ./include/version.sh

mkdir -p downloads

pushd downloads

if [[ -f $NDK_FILE ]]; then
	# We've already downloaded it
	exit 0
fi

wget "https://github.com/Sisah2/openmw-android/releases/download/2019-05-01/android-ndk-10078971-linux-x86_64.zip"

popd

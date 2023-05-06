#!/bin/bash

set -e

source ./include/version.sh

mkdir -p downloads

pushd downloads

if [[ -f $NDK_FILE ]]; then
	# We've already downloaded it
	exit 0
fi

curl --http1.1 "https://ci.android.com/builds/submitted/10078971/linux/latest/android-ndk-10078971-linux-x86_64.zip" > $NDK_FILE



popd

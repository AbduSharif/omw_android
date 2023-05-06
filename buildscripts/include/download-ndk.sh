#!/bin/bash

set -e

source ./include/version.sh

mkdir -p downloads

pushd downloads

if [[ -f $NDK_FILE ]]; then
	# We've already downloaded it
	exit 0
fi

curl --http1.1 "https://www.mediafire.com/file/y5dr1bj869b8622/android-ndk-10078971-linux-x86_64.zip" > $NDK_FILE

popd

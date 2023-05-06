#!/bin/bash

set -e

source ./include/version.sh

mkdir -p downloads

pushd downloads

if [[ -f $NDK_FILE ]]; then
	# We've already downloaded it
	exit 0
fi

curl --http1.1 "https://www.mediafire.com/file/y5dr1bj869b8622/android-ndk-10078971-linux-x86_64.zip?dkey=x3ya3qvgyx6&r=649" > $NDK_FILE

echo "==> Checking NDK zip file integrity"
FILE_HASH=$(sha256sum $NDK_FILE | awk '{print $1}' )

popd

#!/bin/bash

set -e

source ./include/version.sh

mkdir -p downloads

pushd downloads

if [[ -f $NDK_FILE ]]; then
	# We've already downloaded it
	exit 0
fi

curl --http1.1 "https://storage.googleapis.com/android-build/builds/aosp-master-ndk-linux-linux/10078971/61aee9fee51b8b6ea294ee332c33a4a22f401d6f11f730e39a43d5970f71210a/android-ndk-10078971-linux-x86_64.zip?GoogleAccessId=gcs-sign@android-builds-project.google.com.iam.gserviceaccount.com&Expires=1683383901&Signature=RY1HSkHCqN2FgDrxVB88EZA0uJj17%2Blq0bs6Qz59d3vg1LnSeyUSSPLyxjG7vZhAUDmoveGPI3O5D1%2BO4DRo59efCVDgx8OcvNGEJPdsVHxFSkW7iTuO6wP9NRaYVofZseIncj1Yy9sKVZD1USejxSDG0HSkir2b7tB6ADDDtdLmA9myLybLgkzT6TIjTl5pJkx8kwl8Z3hcT3ts8ltO%2BWTlVCSqHijec0Vr/FFyjpVsw48hUOf7dfzvNL6dMvE7Q0ruda830rru/eGLZ2qlGLVT19LFT0JHd%2BpkAINbltvjXoT/CoiDixcGOYqQQ5o%2B4MZM3Vv9f7e6aQAg7W90mA%3D%3D" > $NDK_FILE

echo "==> Checking NDK zip file integrity"
FILE_HASH=$(sha256sum $NDK_FILE | awk '{print $1}' )

popd

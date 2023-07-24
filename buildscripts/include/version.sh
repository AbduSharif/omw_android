#!/bin/bash

NDK_VERSION="r26-beta1"
NDK_HASH="0d5591dbcc6f5435b6dc4145f5a3c7db832007dede15aba9991bd81ad2324491"
ANDROID_API="21"

# End of configurable options
NDK_FILE="ndk-$NDK_VERSION.zip"

if [[ $ARCH = "arm" ]]; then
	ABI="armeabi-v7a"
	NDK_TRIPLET="arm-linux-androideabi"
	FFMPEG_CPU="armv7-a"
	BOOST_ARCH="arm"
	BOOST_ADDRESS_MODEL="32"
	LUAJIT_HOST_CC="gcc -m32"
	ASAN_ARCH="arm"
elif [[ $ARCH = "arm64" ]]; then
	ABI="arm64-v8a"
	NDK_TRIPLET="aarch64-linux-android"
	FFMPEG_CPU="armv8-a"
	BOOST_ARCH="arm"
	BOOST_ADDRESS_MODEL="64"
	LUAJIT_HOST_CC="gcc -m64"
	ASAN_ARCH="aarch64"
elif [[ $ARCH = "x86_64" ]]; then
	ABI="x86_64"
	NDK_TRIPLET="x86_64-linux-android"
	FFMPEG_CPU="intel"
	BOOST_ARCH="x86"
	BOOST_ADDRESS_MODEL="64"
	LUAJIT_HOST_CC="gcc -m64"
elif [[ $ARCH = "x86" ]]; then
	ABI="x86"
	NDK_TRIPLET="i686-linux-android"
	FFMPEG_CPU="intel"
	BOOST_ARCH="x86"
	BOOST_ADDRESS_MODEL="32"
	LUAJIT_HOST_CC="gcc -m32"
else
	echo "Unknown architecture: $ARCH"
	exit 1
fi

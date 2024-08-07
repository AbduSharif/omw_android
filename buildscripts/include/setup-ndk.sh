#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ./include/version.sh

if [[ ! -d toolchain ]]; then
	# Unzip ndk.zip
	mkdir -p toolchain

	echo "(Extracting, this will take a while...)"
	unzip -q downloads/$NDK_FILE -d toolchain/
	mv toolchain/android-ndk-* toolchain/ndk/

	if [[ $CCACHE = "true" ]]; then
		echo "==> Patching common toolchain for ccache support"

		pushd NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/

		mv "clang" "clangX"
		mv "clang++" "clangX++"
		cp "$DIR/../patches/clang-ccache.sh" "clang"
		cp "$DIR/../patches/clang++-ccache.sh" "clang++"
		chmod +x "clang"
		chmod +x "clang++"

		popd
	fi

fi

pushd toolchain

if [[ ! -d $ARCH ]]; then
	echo "==> Making standalone toolchain for architecture $ARCH"

	./ndk/build/tools/make_standalone_toolchain.py \
		--arch $ARCH \
		--api $ANDROID_API \
		--stl libc++ \
		--install-dir ./$ARCH

	# Patch it to ensure gcc is never ever never used
	rm -f $ARCH/bin/$NDK_TRIPLET-gcc
	rm -f $ARCH/bin/$NDK_TRIPLET-g++

	# symlink gcc to clang
	ln -s $NDK_TRIPLET-clang $ARCH/bin/$NDK_TRIPLET-gcc
	ln -s $NDK_TRIPLET-clang++ $ARCH/bin/$NDK_TRIPLET-g++

	# copy over gas-preprocessor for ffmpeg
	cp ../patches/gas-preprocessor.pl $ARCH/bin/

	if [[ $CCACHE = "true" ]]; then
		echo "==> Patching '$ARCH' toolchain for ccache support"
		pushd $ARCH/bin/

		sed -i "s|\`dirname \$0\`/clang|ccache \\0|" "$NDK_TRIPLET-clang"
		sed -i "s|\`dirname \$0\`/clang|ccache \\0|" "$NDK_TRIPLET-clang++"

		popd
	fi
fi

popd

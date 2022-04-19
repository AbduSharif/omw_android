#!/bin/bash

set -e

mkdir -p ${prefi}/icu-host-build/
cd ${prefix}/icu-host-build/
wget https://github.com/unicode-org/icu/archive/refs/tags/release-70-1.zip
unzip release-70-1.zip
ICU_SOURCE_DIR=${prefix}/icu-host-build/icu-release-70-1/icu4c/source
${ICU_SOURCE_DIR}/configure --disable-tests --disable-samples --disable-icuio --disable-extras
make -j $(nproc)
cd ..

#!/bin/sh

set -ex

VENDORED_PATH=vendor/libssh2

OPENSSL_ROOT_DIR=`pwd`/vendor/openssl

cd $VENDORED_PATH &&
mkdir -p install/lib &&
mkdir -p build &&
cd build &&
cmake -DTHREADSAFE=ON \
      -DBUILD_CLAR=OFF \
      -DOPENSSL_ROOT_DIR=$OPENSSL_ROOT_DIR \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_C_FLAGS=-fPIC \
      -DCMAKE_BUILD_TYPE="RelWithDebInfo" \
      -DCMAKE_INSTALL_PREFIX=../install \
      .. &&

cmake --build .

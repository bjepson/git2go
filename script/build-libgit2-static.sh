#!/bin/sh

set -ex

VENDORED_PATH=vendor/libgit2
export LIBSSH2="`pwd`/vendor/libssh2"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$LIBSSH2/build/src"

FLAGS=$(pkg-config --static --libs --cflags libssh2) || exit 1
export CGO_LDFLAGS="-L$LIBSSH2/build/src ${FLAGS}"
export CGO_CFLAGS="-I$LIBSSH2/include"

cd $VENDORED_PATH &&
mkdir -p install/lib &&
mkdir -p build &&
cd build &&
cmake -DTHREADSAFE=ON \
      -DBUILD_CLAR=OFF \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_C_FLAGS="-fPIC $CGO_CFLAGS" \
      -DCMAKE_BUILD_TYPE="RelWithDebInfo" \
      -DCMAKE_INSTALL_PREFIX=../install \
      .. &&

cmake --build .

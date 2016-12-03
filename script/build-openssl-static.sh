#!/bin/sh

set -ex

VENDORED_PATH=vendor/openssl

cd $VENDORED_PATH &&
mkdir -p build/lib &&

# Switch to a stable version
git checkout OpenSSL_1_1_0-stable &&
./config threads no-shared --prefix=`pwd`/build -fPIC -DOPENSSL_PIC &&
make depend &&
make &&
make install

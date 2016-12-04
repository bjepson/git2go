#!/bin/sh

set -ex


export VENDOR="$PWD/vendor"
export LIBGIT2="$VENDOR/libgit2"
export LIBSSH2="$VENDOR/libssh2"
export OPENSSL="$VENDOR/openssl"
export PARSER="$VENDOR/http-parser"
export BUILD="$VENDOR/libgit2/build"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$LIBGIT2/build:$LIBSSH2/build/src:$OPENSSL/build/lib/pkgconfig:$PARSER"

FLAGS=$(pkg-config --static --libs --cflags libcrypto openssl libssh2 libgit2) || exit 1
export CGO_LDFLAGS="$PARSER/libhttp_parser.a -L$LIBGIT2/build -L$OPENSSL -L$LIBSSH2/build/src -L$BUILD ${FLAGS}"
export CGO_CFLAGS="-I$LIBGIT2/include:$OPENSSL/include:$LIBSSH2/include"

$@

#!/bin/sh

# Usage
#
# Debug Build
#     $ ./script/build_linux.sh
# Release Build
#     $ ./script/build_linux.sh --release
#
# Build and Run
#     $ ./script/build_linux.sh && ./bin/debug/app

EXE=app
OUTDIR=bin

CC=gcc
SRC="src/main.c"
CFLAGS="${CFLAGS} -Wall"
CFLAGS="${CFLAGS} -Wextra"
CFLAGS="${CFLAGS} -Wpedantic"
CFLAGS="${CFLAGS} -Wconversion"
CFLAGS="${CFLAGS} -Wdouble-promotion"
CFLAGS="${CFLAGS} -Wno-unused-parameter"
CFLAGS="${CFLAGS} -Wno-unused-function"
CFLAGS="${CFLAGS} -Wno-sign-conversion"
INCLUDE="${INCLUDE} -Ivendor/raylib/include"
LDFLAGS="${LDFLAGS} -Lvendor/raylib/bin/linux"
LDFLAGS="${LDFLAGS} -Wl,-rpath=vendor/raylib/bin/linux"
LIBS="-lraylib"

if [ "$1" = "--release" ]; then
    OUTDIR=$OUTDIR/release
    CFLAGS="${CFLAGS} -O2 -DNDEBUG -D_NDEBUG"
else
    OUTDIR=$OUTDIR/debug
    CFLAGS="${CFLAGS} -DDUBUG -D_DUBUG"
fi

# echo $CC $SRC -o $OUTDIR/$EXE $CFLAGS $INCLUDE $LDFLAGS $LIBS
$CC $SRC -o $OUTDIR/$EXE $CFLAGS $INCLUDE $LDFLAGS $LIBS
EXIT_STATUS=$?

if [ $EXIT_STATUS -ne 0 ]; then
    echo "Failed to compilation..."
    exit $EXIT_STATUS
fi

echo "Compilation succeeded..."

#!/bin/sh

# Usage
#
# Debug Build
#     $ ./script/build_mingw64.sh
# Release Build
#     $ ./script/build_mingw64.sh --release
#
# Build and Run
#     $ ./script/build_mingw64.sh && ./bin/debug/app.exe

EXE=app.exe
OUTDIR=bin

CC=gcc.exe
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
LDFLAGS="${LDFLAGS} -Lvendor/raylib/bin/windows/mingw-w64"
LIBS="-lraylib -lwinmm -lgdi32"

if [ "$1" = "--release" ]; then
    OUTDIR=$OUTDIR/release
    CFLAGS="${CFLAGS} -O3 -DNDEBUG -D_NDEBUG"
    LDFLAGS="${LDFLAGS} -Wl,--subsystem,windows"
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

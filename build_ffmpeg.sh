#!/bin/bash
make clean
API=29
NDK=/home/ygq/work/android-ndk-r26d
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
SYSROOT=$TOOLCHAIN/sysroot
 
function build_android
{
echo "Compiling FFmpeg for $CPU"
	./configure \
	    --prefix=$PREFIX \
	    --enable-shared \
	    --disable-static \
	    --cross-prefix=$CROSS_PREFIX \
	    --target-os=android \
	    --arch=$ARCH \
	    --cpu=$CPU \
	    --cc=$CC \
	    --cxx=$CXX	\
	    --enable-cross-compile \
	    --sysroot=$SYSROOT \
	    --extra-cflags="-fpic $OPTIMIZE_CFLAGS" 
	    
	make clean
	make -j4
	make install
	echo "The Compilation of FFmpeg for $CPU is completed"
}
	
#armv7-a 
ARCH=arm
CPU=armv7-a
CC=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang
CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang++
SYSROOT=$TOOLCHAIN/sysroot
CROSS_PREFIX=$TOOLCHAIN/bin/llvm-
PREFIX=$(pwd)/android/$CPU
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU "
build_android


#armv8-a
ARCH=arm64
CPU=armv8-a
CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
SYSROOT=$TOOLCHAIN/sysroot
CROSS_PREFIX=$TOOLCHAIN/bin/llvm-
PREFIX=$(pwd)/android/$CPU
OPTIMIZE_CFLAGS="-march=$CPU"
build_android

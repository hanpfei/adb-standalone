#         CONFIG
# -------------------------

# Branch to checkout from Android source code repo
branch=android-8.0.0_r34

# Makefile to use (will be automatically copied into system/core/adb)
makefile=makefile.sample
liblogmakefile=makefile.liblog.sample

BUILD_ARCH=$(uname -m)

# DOWNLOAD necessary files
# -------------------------
echo "\n>> >>> ADB for ARM <<< \n"
echo "\n>> Downloading necessay files ($branch branch)\n"
mkdir android-adb
cd android-adb

git clone https://github.com/google/boringssl.git
cd boringssl
mkdir build
cd build
cmake ..
make
cd ..
cd ..

mkdir system
cd system
git clone -b android-8.0.0_r34 https://github.com/hanpfei/android_system_core core
cd ..

mkdir external
cd external

if [ $BUILD_ARCH == "x86_64"  -o $BUILD_ARCH == "x86"  ]; then
  git clone -b $branch https://android.googlesource.com/platform/external/libusb
  cd libusb
  ./autogen.sh
  ./configure
  make
elif [ $BUILD_ARCH == "aarch64" ]; then
  git clone -b master https://github.com/hanpfei/libusb.git
  cd libusb
  ./configure
  make
fi

cp libusb/.libs/libusb-1.0.a ../../system/core/adb/libusb.a

cd ..
git clone -b $branch https://android.googlesource.com/platform/external/mdnsresponder
cp ../../makefile.libmDNSShared.sample mdnsresponder/mDNSShared/makefile
cd mdnsresponder/mDNSShared
make

cd ../../../

# MAKE
# -------------------------
echo "\n>> Copying makefile into system/core/adb...\n"
cp ../$makefile system/core/adb/makefile -f
cp ../$liblogmakefile system/core/liblog/makefile -f
cd system/core/liblog/
make
cd ../adb/
echo "\n>> Make... \n"
make adb
echo "\n>> Copying adb back into current dir...\n"
cp adb ../../../../
echo "\n>> FINISH!\n"



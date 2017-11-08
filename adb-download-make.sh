#         CONFIG
# -------------------------

# Branch to checkout from Android source code repo
branch=android-7.1.1_r22

# Makefile to use (will be automatically copied into system/core/adb)
makefile=makefile.sample
liblogmakefile=makefile.liblog.sample


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
git clone -b adb_on_arm https://github.com/hanpfei/android_system_core core
cd ..

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



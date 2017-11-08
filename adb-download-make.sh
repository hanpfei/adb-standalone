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
mkdir system
cd system
git clone -b adb_on_arm https://github.com/hanpfei/android_system_core
#git clone -b $branch https://android.googlesource.com/platform/system/extras
cd ..
#mkdir external
#cd external
#git clone -b $branch https://android.googlesource.com/platform/external/zlib
#git clone -b $branch https://android.googlesource.com/platform/external/openssl
#git clone -b $branch https://android.googlesource.com/platform/external/libselinux
#cd ..


# MAKE
# -------------------------
echo "\n>> Copying makefile into system/core/adb...\n"
cp ../$makefile system/core/adb/makefile -f
cp ../$liblogmakefile system/core/liblog/makefile -f
cd system/core/liblog/
make
cd ../adb/
echo "\n>> Make... \n"
make clean
make
echo "\n>> Copying adb back into current dir...\n"
cp adb ../../../../
echo "\n>> FINISH!\n"



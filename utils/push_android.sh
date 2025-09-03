#!/bin/bash

# the target id
DEVICE_SERIAL=$1
# location on the test device
DEVICE_TEST_LOCATION=$2
# build source path
BUILD_DIRECTORY=$3
# the host system name
PREBUILT_LOCATION=$4

# Create a stage directory inside the build directory that
# excludes all files that need not to be pushed.
RSYNC_FLAGS=""
RSYNC_FLAGS+=" -a"
RSYNC_FLAGS+=" --delete --delete-excluded"
RSYNC_FLAGS+=" --exclude=\"*.o\""
RSYNC_FLAGS+=" --exclude=\"*.a\""
RSYNC_FLAGS+=" --exclude=\"*.time\""
RSYNC_FLAGS+=" --exclude=\"*.cmake\""
RSYNC_FLAGS+=" --exclude=Output/"
RSYNC_FLAGS+=" --exclude=.ninja_deps"
RSYNC_FLAGS+=" --exclude=.ninja_log"
RSYNC_FLAGS+=" --exclude=build.ninja"
RSYNC_FLAGS+=" --exclude=rules.ninja"
RSYNC_FLAGS+=" --exclude=amd-venv/"
RSYNC_FLAGS+=" --exclude=CMakeFiles/"

rm -rf $BUILD_DIRECTORY/stage
rsync $RSYNC_FLAGS $BUILD_DIRECTORY $BUILD_DIRECTORY/stage/


# Push the stage directory onto the device.
adb -s $DEVICE_SERIAL shell rm -rf $DEVICE_TEST_LOCATION/$(basename $BUILD_DIRECTORY)
adb -s $DEVICE_SERIAL push $BUILD_DIRECTORY/stage/$(basename $BUILD_DIRECTORY) $DEVICE_TEST_LOCATION


# Remove the stage directory.
rm -rf $BUILD_DIRECTORY/stage


# Push the shared library onto the device.
adb -s $DEVICE_SERIAL push $PREBUILT_LOCATION/sysroot/usr/lib/aarch64-linux-android/libc++_shared.so \
  $DEVICE_TEST_LOCATION/libc++_shared.so

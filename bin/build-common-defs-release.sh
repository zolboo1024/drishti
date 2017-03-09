#!/bin/bash
#
# Note: maintain line-per-line compatibility with build-common-defs-release.sh
#

set -e

[ -n ${ANDROID_SDK_ROOT} ] && unset ANDROID_SDK_ROOT
[ -n ${ANDROID_SDK_ROOT} ] && unset ANDROID_HOME
echo $ANDROID_SDK_ROOT

. ${DRISHTISDK}/bin/drishti-password.sh

PATH="/usr/bin:${PATH}" # system python first

HUNTER_CONFIGURATION_TYPES=Release
DRISHTI_BUILD_CONFIG=Release

DRISHTI_BUILD_ACF=OFF
DRISHTI_BUILD_FACE=OFF
DRISHTI_BUILD_HCI=OFF
DRISHTI_BUILD_OGLES_GPGPU=OFF
DRISHTI_BUILD_EXAMPLES=ON
DRISHTI_BUILD_REGRESSION_FIXED_POINT=ON
DRISHTI_BUILD_REGRESSION_SIMD=ON
DRISHTI_BUILD_TESTS=OFF
DRISHTI_BUILD_MIN_SIZE=ON
DRISHTI_BUILD_C_INTERFACE=ON

# Include dSYM files for resymbolification of release builds
DRISHTI_DISABLE_DSYM=OFF 

# Current release is pba.z format only
DRISHTI_SERIALIZE_WITH_BOOST=ON
DRISHTI_SERIALIZE_WITH_CEREAL=OFF
DRISHTI_SERIALIZE_WITH_CVMATIO=OFF

DRISHTI_BUILD_EOS=OFF
DRISHTI_BUILD_DEST=OFF

CPACK_TYPE=TGZ

. ${DRISHTISDK}/bin/polly-setter.sh

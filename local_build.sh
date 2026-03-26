#!/bin/bash
WEST_ADDITIONAL_OPTS=""
BUILD_DIR_SUFFIX=""
ADDITIONAL_ARGS=""


case "$1" in
v2)
    DYA_SHEILD=dya_dash_
    SNIPPET_SUFFIX=""
    ;;
v3)
    DYA_SHEILD=dya_dash_v3_
    SNIPPET_SUFFIX="-v3"
    ;;
*)
    echo "Usage: $0 {v2|v3} ..."
    exit 1
esac
shift

case "$1" in
left)
    SPLIT=left
    ;;
right)
    SPLIT=right
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S studio-rpc-usb-uart"
    ;;
left-ball)
    SPLIT=left
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S left-trackball${SNIPPET_SUFFIX}"
    BUILD_DIR_SUFFIX="${BUILD_DIR_SUFFIX}_trackball"
    ;;
right-ball)
    SPLIT=right
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S studio-rpc-usb-uart"
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S right-trackball${SNIPPET_SUFFIX}"
    BUILD_DIR_SUFFIX="${BUILD_DIR_SUFFIX}_trackball"
    ;;
left-switch)
    SPLIT=left
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S left-switch${SNIPPET_SUFFIX}"
    BUILD_DIR_SUFFIX="${BUILD_DIR_SUFFIX}_switch"
    ;;
right-switch)
    SPLIT=right
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S studio-rpc-usb-uart"
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S right-switch${SNIPPET_SUFFIX}"
    BUILD_DIR_SUFFIX="${BUILD_DIR_SUFFIX}_switch"
    ;;
left-encoder)
    SPLIT=left
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S left-encoder${SNIPPET_SUFFIX}"
    BUILD_DIR_SUFFIX="${BUILD_DIR_SUFFIX}_encoder"
    ;;
right-encoder)
    SPLIT=right
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S studio-rpc-usb-uart"
    WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S right-encoder${SNIPPET_SUFFIX}"
    BUILD_DIR_SUFFIX="${BUILD_DIR_SUFFIX}_encoder"
    ;;
*)
    echo "Usage: $0 {left|right|left-ball|right-ball|left-switch|right-switch} <options>"
    echo " -d: Enable debug logging"
    echo " -r: Reset storage on start"
    exit 1
    ;;
esac
shift

while getopts "dr" optKey; do
    case "$optKey" in
    d)
        # Enable debug logging
        WEST_ADDITIONAL_OPTS="${WEST_ADDITIONAL_OPTS} -S zmk-usb-logging"
        BUILD_DIR_SUFFIX="${BUILD_DIR_SUFFIX}_debug"
        ;;
    r)
        # Enable reset on start
        ADDITIONAL_ARGS="${ADDITIONAL_ARGS} -DCONFIG_ZMK_SETTINGS_RESET_ON_START=y"
        BUILD_DIR_SUFFIX="${BUILD_DIR_SUFFIX}_reset"
        ;;
    esac
done
#
#
#

REPO_ROOT=$(git rev-parse --show-superproject-working-tree --show-toplevel | head -1)
REPO_ROOT=${REPO_ROOT:=$(pwd)}
DYA_SHEILD=${DYA_SHEILD}${SPLIT}
BUILD_DIR=$REPO_ROOT/build/${DYA_SHEILD}${BUILD_DIR_SUFFIX}
ZMK_APP_DIR=$REPO_ROOT/external/zmk/app

west zephyr-export

west build \
    -s $ZMK_APP_DIR \
    -d $BUILD_DIR \
    -b seeeduino_xiao_ble $WEST_ADDITIONAL_OPTS \
    -- \
    -DSHIELD=$DYA_SHEILD \
    -DZMK_EXTRA_MODULES="$REPO_ROOT" -DZMK_CONFIG="$REPO_ROOT/config" $ADDITIONAL_ARGS || exit 1
cp $BUILD_DIR/zephyr/zmk.uf2 $BUILD_DIR/../zmk_${DYA_SHEILD}${BUILD_DIR_SUFFIX}.uf2

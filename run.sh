#!/bin/bash

POWERLINK_WORKSPACE_PATH="/home/$USER/workspace/powerlink"
ECLIPSE_EXECUTABLE_PATH="$POWERLINK_WORKSPACE_PATH/eclipse/eclipse-rcp-neon-3-linux-gtk-x86_64/eclipse"

# Check if DISPLAY is set
if [ -z "$DISPLAY" ]; then
    echo "DISPLAY environment variable is not set. Please set DISPLAY to the X11 server you want to use."
    echo "Example: export DISPLAY=:10"
    exit 1
fi

# Check if POWERLINK_WORKSPACE exists
if [ ! -d ${POWERLINK_WORKSPACE_PATH} ]; then
    echo "Directory ${POWERLINK_WORKSPACE_PATH} does not exist."
    exit 1
fi

# Check if the file ECLIPSE_EXECUTABLE_PATH exists
if [ ! -f ${ECLIPSE_EXECUTABLE_PATH} ]; then
    echo "File ${ECLIPSE_EXECUTABLE_PATH} does not exist."
    exit 1
fi

docker run -d -it -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/dri/renderD128:/dev/dri/renderD128 \
    -v /home/$USER/workspace/powerlink:/workspace/powerlink \
    --ipc host \
    eclipse-neon

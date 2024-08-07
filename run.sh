#!/bin/bash

# Check if DISPLAY is set
if [ -z "$DISPLAY" ]; then
    echo "DISPLAY environment variable is not set. Please set DISPLAY to the X11 server you want to use."
    exit 1
fi

docker run -d -it --rm -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/dri/renderD128:/dev/dri/renderD128 \
    -v /home/chris/Downloads/eclipse-rcp-neon-3-linux-gtk-x86_64:/data \
    -v /home/$USER/docker-ws:/docker-ws \
    --ipc host \
    eclipse

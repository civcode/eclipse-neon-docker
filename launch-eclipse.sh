#!/bin/bash

# Check if DISPLAY is set
if [ -z "$DISPLAY" ]; then
    echo "DISPLAY environment variable is not set. Please set DISPLAY to the X11 server you want to use."
    echo "Example: export DISPLAY=:0"
    echo "Example: export DISPLAY=:10 (if you are using xRDP)"
    exit 1
fi

# Check if container id is provided
if [ -z "$1" ]; then
    echo "Container id is not provided."
    echo "Usage: ./launch-eclipse.sh <container_id>"
    echo "docker ps -a"
    docker ps -a
    exit 1
fi

# Check if container id is valid
if [ -z "$(docker ps -a --filter "id=$1")" ]; then
    echo "Container id $1 is not valid."
    echo "docker ps -a"
    docker ps -a
    exit 1
fi

# Check if container is running
if [ -z "$(docker ps -q --filter "id=$1")" ]; then
    echo "Container $1 is not running."
    echo "Starting the container $1"
    docker start $1
fi

docker exec -it $1 eclipse
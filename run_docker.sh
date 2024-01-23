#!/bin/bash

DEVICE_NUM=$1
CONTAINER_NAME="sohei_20240111_$DEVICE_NUM"

docker run -it --shm-size=128g --gpus "device=$DEVICE_NUM" -v /hdd/sohei:/workspace/data \
--name $CONTAINER_NAME sohei:20240101 /bin/bash 
# -c "./code tunnel --accept-server-license-terms --name $CONTAINER_NAME --no-sleep"
# it is good to create a symbolic link to data
# 

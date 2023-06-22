#!/bin/bash

DEVICE_NUM=$1
CONTAINER_NAME="sohei_$DEVICE_NUM"

docker run -it --shm-size=128g --gpus "device=$DEVICE_NUM" -v /hdd/sohei:/workspace/data \
--name $CONTAINER_NAME deep_learning_research:fenics 
# it is good to create a symbolic link to data
# /bin/bash -c "./code tunnel --accept-server-license-terms --name $CONTAINER_NAME --no-sleep"

#!/bin/bash
sudo apt update
sudo snap install docker
sudo docker pull docker pull ibmcom/mq:latest
sudo docker pull ibmcom/mq:latest
sudo docker volume create qm1data
sudo docker run --env LICENSE=accept --env MQ_QMGR_NAME=MQ1 --volume=qm1data:/mnt/mgm --publish 1414:1414 --publish 9443:9443 --detach --env MQ_APP_PASSWORD=passw0rd ibmcom/mq:latest
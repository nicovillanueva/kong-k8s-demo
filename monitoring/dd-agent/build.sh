#!/bin/bash

IMG='nicovillanueva/dd-agent-kong:latest'
docker build -t $IMG . && \
docker push $IMG

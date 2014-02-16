#!/bin/bash

set -e

IMAGE="zardoz.podzone.org:11003/core/supervised"

docker build -rm -t ${IMAGE} .
docker push ${IMAGE}

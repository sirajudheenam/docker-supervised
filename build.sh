#!/bin/bash

set -e

IMAGE="zardoz.podzone.org:11003/core/supervised"

docker build -t ${IMAGE} .
docker push ${IMAGE}

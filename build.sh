#!/bin/bash

set -e

IMAGE="localhost:5000/core/supervised"

docker build -t ${IMAGE} .
docker push ${IMAGE}

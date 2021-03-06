#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

DOCKER_IMAGE=${DOCKER_IMAGE:-brixcoin/brixcoind-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/brixcoind docker/bin/
cp $BUILD_DIR/src/brixcoin-cli docker/bin/
cp $BUILD_DIR/src/brixcoin-tx docker/bin/
strip docker/bin/brixcoind
strip docker/bin/brixcoin-cli
strip docker/bin/brixcoin-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker

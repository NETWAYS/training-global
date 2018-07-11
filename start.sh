#!/bin/bash
DIR=$(cd $(dirname $0)/..; pwd -P)
CLANG=C.UTF-8
IMAGE=netways/showoff:0.19.6
CNAME=showoff

cd "$DIR"

if [ -n $(docker ps -aq -f name=$CNAME) ]
then
  docker rm -f $CNAME
fi

exec docker run \
  -it \
  --name=$CNAME \
  -p 9090:9090 \
  -v "$DIR:/training" \
  -e "LANG=$CLANG" \
  -e "LANGUAGE=$CLANG" \
  -e "LC_ALL=$CANG" \
  $IMAGE \
  showoff serve --review --verbose


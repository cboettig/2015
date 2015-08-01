#!/bin/bash
## Run from repo root


## Modified script to update that can run over docker machine

YEAR=2015

set -e
source ~/.notebook-env.sh


## always use latest images for these
docker pull cboettig/${year}-cache
docker pull cboettig/2015

## Build using cached data.  
docker create --name cache \
  -v /root \
  cboettig/${YEAR}-cache

docker run --name build \
  -v /data/_cache \
  --volumes-from cache \
  -e GH_TOKEN=$GH_TOKEN \
  -w /data \
  cboettig/${YEAR} \
  bash _build/build.sh 

## Update cache to reflect build 
docker run --name cache2 --volumes-from build busybox tar cvf /root/cache.tar /data/_cache 

## commit and push updated cache container
docker commit cache2 cboettig/${YEAR}-cache
docker push cboettig/${YEAR}-cache

## Clean up
docker rm -v cache cache2 build


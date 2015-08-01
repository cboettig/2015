#!/bin/bash
## Run from repo root
YEAR=2015

## identical to local.sh, except avoids linking the host volume.
## Instead, assumes the docker build image has the latest git repo with all posts
## already copied onto it.

set -e
source ~/.notebook-env.sh


## always use latest images for these
docker pull cboettig/${YEAR}-cache
docker pull cboettig/2015

## Build using cached data:  

## First, start a volume container with the cache
docker create --name cache \
  -v /root \
  cboettig/${YEAR}-cache

## Then build using this cached data
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


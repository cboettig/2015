#!/bin/bash
## Run from repo root
YEAR=2015

## Identical to machine.sh, but links the local volume. won't work with docker-machine,
## but takes advantage of local host having more up-to-date versions of posts
## Also takes advantage of any local cache files, combined with those on cache volume

set -e
source ~/.notebook-env.sh


## always use latest images for these
docker pull cboettig/${YEAR}-cache
docker pull cboettig/2015


## First, start a volume container with the cache
docker create --name cache \
  -v /root \
  cboettig/${YEAR}-cache

## Copy this data locally, otherwise it will be omitted from the updated cache!
docker cp cache /root/cache.tar .
tar -xf cache.tar
rsync -a data/_cache/ _cache/

## Then build using this cached data.  Note this links
## the local working directory to obtain the sources
docker run --name build \
  -v $(pwd):/data \
  --volumes-from cache \
  -e GH_TOKEN=$GH_TOKEN \
  -w /data \
  cboettig/${YEAR} \
  bash _build/build.sh 

## Update cache to reflect build 
## Note this links the local working directory to obtain the cache
docker run --name cache2 -v $(pwd):/data busybox tar cvf /root/cache.tar /data/_cache 

## commit and push updated cache container
docker commit cache2 cboettig/${YEAR}-cache
docker push cboettig/${YEAR}-cache

## Clean up
docker rm -v cache cache2 build


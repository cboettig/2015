#!/bin/bash
## Run from repo root
export YEAR=2015

## Identical to machine.sh, but links the local volume. won't work with docker-machine,
## but takes advantage of local host having more up-to-date versions of posts
## Also takes advantage of any local cache files, combined with those on cache volume

set -e
source ~/.credentials/github/cboettig.sh


## always use latest images for these
docker pull cboettig/${YEAR}-cache
docker pull cboettig/${YEAR}


## First, start a volume container with the cache
docker create --name cache \
  -v /root \
  cboettig/${YEAR}-cache

## Copy this data locally, otherwise it will be omitted from the updated cache!
## hmm, what does this do re permissions of cache...
docker cp cache:/root/cache.tar .
tar -xf cache.tar
sudo rsync -a data/_cache/ _cache/
rm -rf data

## Then build using this cached data.  Note this links
## the local working directory to obtain the sources
docker run --name build \
  -v $(pwd):/data \
  --volumes-from cache \
  -w /data \
  --rm \
  cboettig/${YEAR} \
  bash _build/build.sh 

docker run --name build \
  -v $(pwd):/data \
  -e GH_TOKEN=$GH_TOKEN \
  -w /data \
  --rm \
  cboettig/${YEAR} \
  bash _build/deploy.sh 


## Update cache to reflect build 
## Note this links the local working directory to obtain the cache
docker run --name cache2 -v $(pwd):/data busybox tar cvf /root/cache.tar /data/_cache 

## commit and push updated cache container
docker commit cache2 cboettig/${YEAR}-cache
docker push cboettig/${YEAR}-cache

## FIXME run this if any of the above errors 
## Clean up: restore user permissions and remove containers 
docker run --rm -v $(pwd):/data busybox chown -R 1000:1000 /data/_cache
docker rm -v -f cache cache2
echo "Finished"


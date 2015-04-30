#!/bin/bash

## Build using cached data
docker create --name cache -v /data/_cache cboettig/2015-cache
docker run --rm  --volumes-from cache -v $(pwd):/data cboettig/2015 Rscript -e 'servr::jekyll(serve = FALSE, script = "_build/build.R")'

## Deploy to GitHub
docker run --rm -ti -v $(pwd):/data -e GH_TOKEN=$GH_TOKEN --entrypoint "/data/_build/deploy.sh" cboettig/2015

## Update cache to reflect build (local builds only)
docker run --rm --volumes-from cache -v $(pwd):/backup busybox tar cvf /backup/backup.tar /data/_cache
docker run --name cache2 -v $(pwd):/backup busybox tar -xf /backup/backup.tar

## commit and push updated cache container
docker commit cache2 cboettig/2015-cache
docker push cboettig/2015-cache

## Clean up
docker rm cache cache2
rm backup.tar


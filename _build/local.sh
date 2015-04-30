#!/bin/bash

docker run --name cache -v /data/_cache cboettig/2015-cache
docker run --name build --volumes-from cache -v $(pwd):/data cboettig/2015 R -e 'servr::jekyll(script="_build/build.R", serve=FALSE)'
docker run --name deploy -ti -v $(pwd):/data -e GH_TOKEN=$GH_TOKEN --entrypoint "/data/_build/deploy.sh" cboettig/2015

docker rm cache build deploy
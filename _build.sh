#!/bin/bash

## Only build the site if the commit hook was a push to the source branch.
REPO=2015

if [ "$DRONE_BRANCH" ]
  then 
    if [ "$DRONE_BRANCH" = "master" ]
      then
        rsync -a --delete /tmp/cache/ _cache/  
	Rscript -e 'servr::jekyll(serve=FALSE, script="_build.R")'
        rsync -a --delete _cache/ /tmp/cache/  

    fi
fi

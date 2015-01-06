#!/bin/bash -i

## Only build the site if the commit hook was a push to the source branch.
REPO=2015

if [ "$DRONE_BRANCH" ]
  then 
    if [ "$DRONE_BRANCH" = "master" ]
      then
	## Deploy site: clone the gh-pages branch, rsync files, commit, and push
        cd .. && git clone -b gh-pages https://cboettig:${GH_TOKEN}@github.com/cboettig/$REPO deploy 
        rsync -av $REPO/_site/ deploy/
        cd deploy && git add -A . && git commit -m 'Site updated from drone' && git push
    fi
fi

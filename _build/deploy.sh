#!/bin/bash
REPO=2015
set -e

Rscript -e 'servr::jekyll(scripts = "_build/build.R", serve = FALSE)'

git clone -b gh-pages https://cboettig:${GH_TOKEN}@github.com/cboettig/$REPO ../deploy 
rsync -a _site/ ../deploy/

cd ../deploy 
git add -A . 
git commit -m 'Site updated from script' 
git push


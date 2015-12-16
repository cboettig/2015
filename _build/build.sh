#!/bin/bash
REPO=2015
set -e

# Extract data from linked volume
cd / && tar -xf /root/cache.tar

cd data && rm -rf cache.tar && Rscript -e 'status <- servr::jekyll(serve = FALSE, script = "_build/build.R")'

## Deploy to gh-pages
{
git clone -b gh-pages https://cboettig:${GH_TOKEN}@github.com/cboettig/$REPO ../deploy 
rsync -a _site/ ../deploy/
cd ../deploy 
git add -A . 
git commit -m 'Site updated from script' 
git push
} &> /dev/null


#!/bin/bash
#set -e

# Extract data from linked volume
cd / && tar -xf /root/cache.tar

cd data && rm -rf cache.tar && Rscript -e 'status <- servr::jekyll(serve = FALSE, script = "_build/build.R")'



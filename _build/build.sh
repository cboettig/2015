#!/bin/bash

rsync -a /cache /data/_cache
Rscript -e 'servr::jekyll(serve = FALSE, script = "_build/build.R")'



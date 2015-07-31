FROM cboettig/labnotebook 
MAINTAINER Carl Boettiger cboettig@ropensci.org 

## Install additional R package dependencies ###
RUN apt-get update && apt-get install -y inkscape
RUN install2.r --error -r http://cran.rstudio.com \
     FKF \
     dlm \
     KFAS \
     mcmc \
     MDPtoolbox \
     sde \
     FastGP \
     rbenchmark \
  && installGithub.r \
    yihui/servr \ 
    cboettig/earlywarning \
    cboettig/pdg_control \
    cboettig/knitcitations \
    cboettig/regimeshifts  \
    ropensci/rgpdd \
    cboettig/nonparametric-bayes \
    cboettig/pmc \
    nimble-dev/nimble/packages/nimble@stable \
    cboettig/gpmanagement \
  && rm -rf /tmp/downloaded_packages


# break cache first
COPY Dockerfile /tmp/Dockerfile
RUN git clone https://github.com/cboettig/2015 data


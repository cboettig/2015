FROM cboettig/labnotebook 
MAINTAINER Carl Boettiger cboettig@ropensci.org 

## Install additional R package dependencies ###
RUN apt-get update && apt-get -y install librsvg2-dev \
  && install2.r --error \
     -r "http://www.bioconductor.org/packages/release/bioc" \
     -r "http://cran.rstudio.com" \
     FKF \
     dlm \
     KFAS \
     mcmc \
     MDPtoolbox \
     igraph \
     sde \
     FastGP \
     rbenchmark \
     PVAClone \
     triangle \
     bbmle \
     nlstools \
     drc \
     RNeXML \
     geiger \
     phytools \
     nimble \
     DiagrammeR \
     servr \
     knitcitations \
     rfishbase \
     RNeXML \
     EML \
  && installGithub.r \
    cboettig/earlywarning \
    cboettig/pdg_control \
    cboettig/multiple_uncertainty \
    cboettig/knitcitations \
    cboettig/regimeshifts  \
    ropensci/rgpdd \
    cboettig/nonparametric-bayes \
    cboettig/pmc \
    cboettig/gpmanagement \
    cloudyr/aws.signature \
    cloudyr/aws.s3 \
    richfitz/drat.builder \
    ropensci/ropkgs \
  && install2.r --repo http://packages.ropensci.org --error \
    rrdf \
  && rm -rf /tmp/downloaded_packages



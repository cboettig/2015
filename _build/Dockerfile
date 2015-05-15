FROM cboettig/labnotebook 
MAINTAINER Carl Boettiger cboettig@ropensci.org 

## Install additional R package dependencies ###
RUN apt-get update && apt-get install -y inkscape
RUN install2.r --error -r http://cran.rstudio.com -r http://r-nimble.org \
     FKF \
     dlm \
     KFAS \
     mcmc \
     MDPtoolbox \
     nimble \
     sde \
  && installGithub.r \
    yihui/servr \ 
    cboettig/earlywarning \
    cboettig/pdg_control \
    cboettig/knitcitations \
    cboettig/regimeshifts  \
    ropensci/rgpdd \
    cboettig/nonparametricbayes \
  && rm -rf /tmp/downloaded_packages



COPY . /data

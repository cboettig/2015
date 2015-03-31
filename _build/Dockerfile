FROM cboettig/labnotebook 
MAINTAINER Carl Boettiger cboettig@ropensci.org 

## Install additional R package dependencies ###
RUN sudo rm -rf /tmp/* && install2.r --error igraph sde MDPtoolbox mcmc \
  && install2.r --error --repo http://r-nimble.org nimble \
  && installGithub.r \
    yihui/servr \ 
    cboettig/earlywarning \
    cboettig/pdg_control \
    cboettig/knitcitations \
    cboettig/regimeshifts  \
	&& rm -rf /tmp/downloaded_packages



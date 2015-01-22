FROM cboettig/labnotebook 
MAINTAINER Carl Boettiger cboettig@ropensci.org 

## Install additional R package dependencies ###
RUN install2.r --error igraph sde \
	&& install2.r --error --repo http://r-nimble.org nimble \
	&& installGithub.r yihui/servr cboettig/earlywarning \
  && installGithub.r cboettig/pdg_control \
	&& rm -rf /tmp/downloaded_packages


---
title: "Reproducibility in R: comparing Docker, packrat and GRANbase"
published: false
layout: post
---


Docker, Packrat, and [Becker et al's](http://arxiv.org/abs/1501.02284) `GRANbase`+`switchr` all provide ways for installing and executing older and potentially deprecated software and code, they all take somewhat different approaches and solve somewhat different challenges.  This means it can be very effective to actually combine these tools rather than consider them as strict alternatives, as we shall see in a moment.

- Docker packages a virtual machine.
- GRANbase explicitly supports installing older versions of R packages, such as those that have been archived by CRAN. 

GRANbase+switchr provide tools to manage, share, and publish cohorts of packages (or package manifests), while packrat simply aims to automate the management of these dependencies for a given project.

## Scope ##

The biggest difference is between the scope of Docker vs that of the other two.

Packrat and Becker+ are concerned only with R packages.  Lower-level software such as which version of R you use, what operating system, and all the underlying libraries and external dependencies (including external dependencies used by R packages, such as `libgsl` or `libxml`) are not managed by these approaches.  Because these things are controlled at the level of the OS, they are out of scope for these R-package based approaches.   

In contrast, Docker containers aim to package everything above the level of the kernel: the operating system, all the necessary system libraries, the version of R, along with R packages, data files and so forth.  


## Usability vs Reproducibility

On one hand, the focus on R packages alone seems reasonable from the perspective of reproducibility: this lower-level software tends to be more stable, more professionally developed and usually handled by the user's operating system distribution.  I encounter cases in which different versions of R packages will give different results (or simply error) at much greater frequency than I do cases where some new version of an externally linked C library like `libxml2` or the GNU Scientific Library (gsl) result in a meaningful difference. 

On the other hand, these external libraries often make a big difference simply to portability to other users and across other platforms.  R users are very lucky that they can usually download pre-built binaries for Windows and Mac platforms from CRAN, and rarely have to manage the dependency hell so familiar to anyone who has built software from source.  It is important to realize that the 'dependency hell' problem is rather distinct from the problem packrat is trying to solve (one might rather say it is what packrat is trying to cause) -- the problem here is not that software will install and then error due to version changes, but rather getting it to install at all (because the installation process makes strict requirements on available versions for this very reason).  The result of this is that when I have projects that depend on some Java libraries, BUGS, GSL, or whatnot that another user doesn't have, they face a nontrivial problem getting things to install in the first place on their own operating system.  In my experience, this 'usability' problem is often a greater barrier to practical reproducibility than the problem packrat sets out to address (where newer versions of R packages break compatibility with older ones). 

## Source vs binary

## Redundant use of disk / bandwidth

Packrat creates a unique 

Docker addresses this using base images and layers. We can create a Docker container for each of many projects using a common base image, and they will all share the same dependencies and same disk space.  If we update this or that package for a particular repository, we need only the extra space for the differences.

Updating a base image does not update images derived from it on the machine. If we have a 200 MB base image, and a 500 MB R image built on top of it on our machine, they take up only 500 MB of space, since the same layers in the 200 MB base image are shared.  If we update the base image, we pull only the new layers -- maybe only 100 MB layer has changed and thus we would pull down an additional 100 MB, for a total of 600 MB on disk.  Because the base image has changed, this should trigger a rebuild of the R image (e.g. on Docker Hub, provided repository links are set up).  Since the base changed, all subsequent layers must also change and thus when we pull the new R image we must download the full 500 MB of new R layers.  Our old stack of 500 MB will now be "dangling," since the tag for our image (e.g. `r-base`) has been moved to the newly pulled stack of layers.  We can now delete the dangling layers and return to 500 MB total installed space.  

## Docker + packrat/GRANbase

Why use GRANbase or packrat at all if we can already all use the same version of everything with Docker?  



because these external dependencies are managed by the operating system of choice rather than specifically for the R environment, these libraries can show much greater variability and pose a greater challenge for a user to install than would an individual R package. 



## Trade-offs and comparisons

One key trade-off is self-evident: the Docker approach is more robust -- avoiding differences in system libraries, R versions, etc, but at the cost of creating a much larger image.  

The Docker approach is designed to be modular.  Most users have a core set of R packages they may use in every project which they consider relatively stable, while individual projects may have additional dependencies. 
 
Granbase can accomplish a similar kind of modularity.

Packrat lacks this kind of modularity.  A Packrat project treats all dependent R packages in the same way.  As such, packages must be managed and updated individually. 




`GRANbase` also focuses at the R package level, leaving system libraries to the operating system. Whereas packrat (true to it's name) seeks to store the packages themselves, GRANbase only stores metadata about the packages being used.  

Docker begins packaging from a much lower level: everything above the level of the kernel is provided by the Docker container.  This includes the version of R and all the system libraries used; along with any R packages installed on the container.  


The foc



## Use ##

Packrat is well named

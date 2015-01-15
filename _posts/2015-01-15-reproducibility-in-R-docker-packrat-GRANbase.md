---
title: "Reproducibility in R: comparing Docker, packrat and GRANbase"
published: false
layout: post
---

- Docker provides a convenient way to create and distribute lightweight virtual machines called containers.
- `packrat` provides a convenient way to track dependencies 
- GRANbase provides a convenient way to install older R packages on earlier versions of R

While each of these tools provides a way for installing and executing older and potentially deprecated software and code, they address rather different versions of the problem.

## Scope ##

Packrat is only concerned with R packages.  Dealing with lower-level software, such as the version of R itself along with any system level libraries is out of scope. This is reasonable, as this lower-level software tends to be more stable, more professionally developed and usually handled by the user's operating system distribution. On the other hand, being packaged for the operating system of choice rather than specifically for the R environment, these libraries can show much greater variability and pose a greater challenge for a user to install than would an individual R package. 

GRANbase also focuses at the R package level, but with a rather different philosophy.  Instead of seeking to 

## Use ##

Packrat is well named

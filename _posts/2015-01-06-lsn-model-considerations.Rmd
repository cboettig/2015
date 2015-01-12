---
published: false
layout: post
tags: 
- earlywarning
code: true
---


- Model the change in mean explicitly, or rely on detrending?

Modeling the rate of change in mean makes it possible for a mean-only change to be sufficient to prefer the model of change over the OU model... 

However, detrending needs rigorous definition to justify the approach.  Transforming the data can distort the signal (particularly obvious with the case of interpolation). 

Consider the mean changes as a function $f(x(t),t)$, we would want an approach that claims to provide a non-parametric estimate of $f$ such that for our data, $x - f(x)$ approximates to the model we fit (e.g. OU model with time-dependent spring constant term alone).




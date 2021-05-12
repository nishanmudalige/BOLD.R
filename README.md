# BOLD.R
[![Language](https://img.shields.io/badge/Language-R-9cf)](https://img.shields.io/badge/Language-R-9cf)  [![R build status](https://github.com/nishanmudalige/BOLD.R/workflows/R-CMD-check/badge.svg)](https://github.com/nishanmudalige/BOLD.R/actions) [![codecov](https://codecov.io/gh/nishanmudalige/BOLD.R/branch/master/graph/badge.svg?token=U5SKN4LP53)](https://codecov.io/gh/nishanmudalige/BOLD.R)  [![GitHub issues](https://img.shields.io/github/issues/nishanmudalige/BOLD.R)](https://github.com/nishanmudalige/BOLD.R/issues) [![GitHub license](https://img.shields.io/github/license/nishanmudalige/BOLD.R)](https://github.com/nishanmudalige/BOLD.R/blob/master/LICENSE) [![Version](https://img.shields.io/badge/version-0.4.0-blue)](https://img.shields.io/badge/version-0.4.0-blue)

An R package to interface with the Barcode of Life Database System (BOLD) using R.

Automatically redirected to this GiHub page from http://boldsystems.org/bold.r.

BOLD.R relies on the following dependences:

```
  > required.packages = c("jsonlite", "gtools", "RCurl", "ape", "plyr", "seqinr", "getPass")
  > sapply(required.packages, install.packages)
```

In order to install BOLD.R directly through R, please type the following into the R console.

```
  > ## If devtools are not installed
  > ## install.packages("devtools")
  > 
  > library(devtools)
  > devtools::install_github("nishanmudalige/BOLD.R", force = TRUE)
```


For questions, please email nishan [dot] mudalige [dot] 1 [at] ulaval [dot] ca .

This poster won runner up at the <u><a href="http://ammcs.wlu.ca/awards/" target="_blank">Applied Mathematics, Modeling and Computational Science (AMMCS) 2019 conference</a></u>.

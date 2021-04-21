# BOLD.R

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

For a poster about BOLD.R, please click <u><a href="https://drive.google.com/file/d/1ZxJecayOXMkk4Or81M2j6e0X5NULnfq1/view?usp=sharing" target="_blank">here</a></u>.

This poster won runner up at the <u><a href="http://ammcs.wlu.ca/awards/" target="_blank">Applied Mathematics, Modeling and Computational Science (AMMCS) 2019 conference</a></u>.

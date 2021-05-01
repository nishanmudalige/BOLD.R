---
title: 'BOLD.R: A bridge between the Barcode of Life Database System and the Statistical Software R'
tags:
  - R
  - Bioinformatics
  - DNA barcoding
  - Metagenomics
authors:
  - name: Nishan Mudalige^[nishan.mudalige.1@ulaval.ca]
    orcid: 0000-0003-3981-9868
    affiliation: "1"
affiliations:
 - name: Université Laval
   index: 1
date: 1 May 2021
bibliography: paper.bib

---

# Summary

The Barcode of Life Data system (BOLD) is a storage and analytic platform for data generated from  DNA barcoding. Researchers submit samples to the Centre for Biodiversty Genomics (CBG) and the information extracted from these samples is uploaded to BOLD. Many projects such as the the International Barcode of Life project (iBOL) are involved with classifying and cataloging species around the world DNA barcodes and utilizing BOLD as their storage and information repository. Advances in DNA analysis have led to a rapid increase in the volume of data available for researchers involved in many project such as iBOL. 
As a result, data analysis with statistical software is becoming an increasingly priority in many studies related to ecoloby and biodiversity.


# Statement of Need

Reseachers can access BOLD using a web-based interface on a browser, however the functions that they can perform in this manner are limited in scope. Therefore it would be useful for researchers to work with the data stored on BOLD using specilized software that has been developed for statistical analysis.
Methods to export data from BOLD into any other software are inconvenient, time-consuming or provide limited information.  A popular software package for statistical analysis is R, and to address the limitations of the web-based interface of BOLD and to overcome the issues related to data retrieval from BOLD, we developed an R package called `BOLD.R`. Our package provides a convenient system to and direct access to data stored on BOLD into R.`BOLD.R` acts as a bridge between BOLD systems and R. BOLD can be used as a point for data storage and validation. Information from samples can be uploaded into BOLD and the BOLD engine will validate, extract and classify genera through DNA barcoding. R can be used as the informatics workbench for data stored on BOLD.`BOLD.R` has recently been updated to work with the most current version of the BOLD API which utilizes more secure API calls for data retreival.


# Installation

Instructions for downloading the package can be found at [http://boldsystems.org/boldr](http://boldsystems.org/boldr).

`BOLD.R` is installed through the miantainer's GitHub page

```
  > ## If devtools are not installed
  > ## install.packages("devtools")
  > 
  > library(devtools)
  > devtools::install_github("nishanmudalige/BOLD.R", force = TRUE)
```

# Usage

Data retreived using `BOLD.R` is stored as data frames. Many useful functions are provided with `BOLD.R` which allow the user to analyze the data retreived from BOLD. The package is currently meant for use primarily with public data. Summary information related specifically to genetic data and DNA barcodes can be accessed using functions in the package. For example, suppose we are interested in data stored in projects "CNIVG" and "GMMGM". We can perform the following which downloads the data into R.

```
  > mydata = get.public(container=c("CNIVG", "GMMGM"))
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  100  218k    0  218k    0     0  23940      0 --:--:--  0:00:09 --:--:-- 34001
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  100  295k    0  295k    0     0  22601      0 --:--:--  0:00:13 --:--:-- 47621
  > nucleotides(mydata)
  [1] "COI-5P_nucraw" "28S_nucraw"   
  > summary.bold(mydata)
  No. of records             443
  No. of unique record codes   2
  No. of duplicate records     0
  No. of different primers     2
```

Another useful function of `BOLD.R` is a the custom merge function which allows data from several porject to easily be merged. This custom merge function accomodates the specific structurce of the data retreived from BOLD and is therefore a better option the default merge function provided with R or the merge function provided with other packages such as `plyr` or `dplyr`. For example, suppose we downloaded two related projects with unique data and we wanted to merge these projects. We could type the following syntax to merge them while accomodating for the structure of the data returned from BOLD.

```
> dataset1 = get.public(container="CNBPS")
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  562k    0  562k    0     0  34113      0 --:--:--  0:00:16 --:--:-- 42962
> nrow(dataset1)
[1] 440
> dataset2 = get.public(container="CNBPT")
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  224k    0  224k    0     0  34563      0 --:--:--  0:00:06 --:--:-- 57256
> nrow(dataset2)
[1] 177
> merged.data = merge.bold(dataset1, dataset2)
> nrow(merged.data)
[1] 617
```

# Visualization

One of the biggest benefits of utilizing `BOLD.R` is that researchers can download data from BOLD into R and then take advantage of the other libraries in R to create high quality graphical plots for publications. Figures \autoref{fig:barplot}, \autoref{fig:sequence}, \autoref{fig:dendrogram}, \autoref{fig:map and  \autoref{fig:map} are examples of various plots that can be created from data obtained from BOLD using `BOLD.R` along with other existing packages in `R`.

![Example of a bar plot created using public data obtained from BOLD using BOLD.R. The additional package used was `ggplot2`. \label{fig:barplot}](barplot.png){ width=50% }

![Example of a dendrogram created using public data obtained from BOLD using BOLD.R. The additional packages used were `ggdendro` and `dendextend`. \label{fig:sequence}](dnasequence.png){ width=50% }

![Example of a dendrogram created using public data obtained from BOLD using BOLD.R. The additional package used was `ape`. \label{fig:dendrogram}](dendrogram.png){ width=50% }

![Example of a map created using public data obtained from BOLD using BOLD.R. The additional packages used were `sf` and `mapview`. \label{fig:map}](map.png){ width=50% }

![Example of a head map created using public data obtained from BOLD using BOLD.R. The additional packages used were `stringdist` and `gplots`. \label{fig:heatmap}](heatmap.png){ width=50% }


# References


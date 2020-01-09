\name{get.public}
\alias{get.public}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function to retrieve public data using the public API.}
\description{A function to retrieve public data using the public API.
The user can access public data based on taxon, id, bin, container, institution, researchers, geographic location or marker.}
\usage{
get.public(taxon = NULL, ids = NULL, bin = NULL, container = NULL, institutions = NULL, researchers = NULL, geo = NULL, marker = NULL)}
\arguments{
  \item{taxon}{Returns all records containing matching taxa, defined in a pipe or comma delimited list.
  (spaces need to be encoded).Taxa includes scientific names at phylum, class, order, family, subfamily, genus, and species levels.
}
  \item{ids}{Returns all records containing matching IDs, defined in a pipe or comma delimited list.
  (spaces need to be encoded). IDs include Sample IDs, Process IDs, Museum IDs and Field IDs.
}
  \item{bin}{Returns all records contained in matching BINs, defined in a pipe or comma delimited list.
A BIN is defined by a Barcode Index Number URI.
}
  \item{container}{Returns all records contained in matching projects or datasets, defined in a pipe or comma delimited list.
Containers include project codes and dataset codes.
}
  \item{institutions}{Returns all records stored in matching institutions, defined in a pipe or comma delimited list.
Institutions are the Specimen Storing Site (spaces need to be encoded).
}
  \item{researchers}{Returns all records containing matching researcher names, defined in a pipe or comma delimited list.
Researchers include collectors and specimen identifiers (spaces need to be encoded).
}
  \item{geo}{Returns all records collected in matching geographic sites, defined in a pipe or comma delimited list.
Geographic sites includes countries and province/states (spaces need to be encoded).
}
  \item{marker}{Returns all specimen records containing matching marker codes defined in a pipe or comma delimited list. All markers for a specimen matching the search string will be returned. ie. A record with COI-5P and ITS will return sequence data for both markers even if only COI-5P was specified.
}
}
\value{A dataframe which contains information corresponding to the recordset codes entered.}
\author{Nishan Mudalige}
\examples{
## Returns all records matching a project id
## example.df <- get.public(container="CCANN")
## example.df


## Returns all records matching multiple project ids
## example.df <- get.public(container=c("ACAGA","CCANN","AICC","PRT"))
## example.df


## Returns all records matching multiple project ids
## example.df <- get.public(container=c("ACAGA,CCANN,AICC,PRT"))
## example.df


## Returns all records matching multiple project ids
## example.df <- get.public(container=c("ACAGA|CCANN|AICC|PRT"))
## example.df


## Returns all records matching multiple project ids
## example.df <- get.public(container=c("ACAGA,CCANN|AICC,PRT"))
## example.df


## Returns all records matching the taxon Bos taurus.
## example.df <- get.public(taxon="Bos taurus")
## example.df


## Returns all records matching the taxa Aves or Reptilia
## example.df <- get.public(taxon="Aves|Reptilia")
## example.df


## Returns records matching these Process IDs.
## example.df <- get.public(ids="ACRJP618-11|ACRJP619-11")
## example.df


## Returns records matching these BIN URIs.
## example.df <- get.public(bin="BOLD:AAA5125|BOLD:AAA5126")
## example.df


## Returns records for specimens stored within matching institutions.
## example.df <- get.public(institutions="Biodiversity Institute of Ontario|York University")
## example.df


## Returns records for specimens collected or identified by the matching researchers.
## example.df <- get.public(researchers="Thibaud Decaens|Rodolphe Rougerie")
## example.df


## Returns records for specimens collected in the matching geographic sites.
## example.df <- get.public(geo="Canada|Alaska")
## example.df


## Returns records for specimens collected with the matching marker.
## example.df <- get.public(marker="COI-5P")
## example.df

## example.df <- get.public(marker="matK|rbcL")
## example.df
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

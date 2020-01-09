\name{get.private}
\alias{get.private}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function to retrieve data from BOLD using the Private API}
\description{This function retrieves data from BOLD using the private API.
The user can access both public data and their own private data using
this function.
}
\usage{
get.private(record.codes, token)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{record.codes}{A vector of dataset codes or project codes}
  \item{token}{A valid token obtained from loging in to BOLD.}
}
\value{A dataframe of records obtaiend through the private API corresponding
to the record.codes parameter entered into the function.}
\author{Nishan Mudalige}
\examples{
## token <- login.bold("username")

## example.df <- get.private("ACAGA", token)
## example.df

## example.df <- get.private(c("ACAGA","CCANN","PRT"), token)
## example.df
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

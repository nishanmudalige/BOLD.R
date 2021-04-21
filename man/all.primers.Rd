\name{all.primers}
\alias{all.primers}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function gives informaiton on the primers in a data set.}
\description{A function which returns a vector with the names of all of the primers in a dataframe.}
\usage{
  all.primers(df)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{df}{A dataframe containing data obtained from BOLD.}
}
\details{The dataframe entered into this function can be a dataframe that was
created after merging several dataframes with data obtained from BOLD.}
\value{A vector of primers in the dataframe.}
\author{Nishan Mudalige}
\examples{
example.df <- get.public(container="PRT")
all.primers(example.df)

example.df <- get.public(container=c("PRT","ACAGA"))
all.primers(example.df)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

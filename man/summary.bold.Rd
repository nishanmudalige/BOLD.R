\name{summary.bold}
\alias{summary.bold}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function which returns useful summary informaiton.}
\description{The user should enter a dataframe with data obtained from BOLD.
The function will provide summary information on:
    * The Number of records in the dataframe
    * The Number of unique record codes in the dataframe
    * The Number of duplicate records in the dataframe
    * The Number of different primers in the dataframe
}
\usage{
summary.bold(df)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{df}{A dataframe with data obtained form BOLD.}
}
\value{A summary of the items mentioned in the description.}
\author{Nishan Mudalige}
\examples{
example.df <- get.public(container=c("ACAGA, AICC, PRT"))
summary(example.df)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

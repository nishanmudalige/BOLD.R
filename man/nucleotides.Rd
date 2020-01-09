\name{nucleotides}
\alias{nucleotides}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function to view the different nucleotides in a dataframe}
\description{The user should input a datafarme with data obtained from BOLD.
This function will then return a vector of all of the different nucleotide
markers in the dataframe.}
\usage{
nucleotides(df)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{df}{A dataframe with data obtained form BOLD.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{A vector of all of the different nucleotide markers in the dataframe.}
\references{
%% ~put references to the literature/web site here ~
}
\author{Nishan mudalige}
\examples{
example.df <- get.public(container=c("ACAGA, AICC, PRT"))
nucleotides(example.df)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

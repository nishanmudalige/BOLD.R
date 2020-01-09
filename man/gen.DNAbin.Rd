\name{gen.DNAbin}
\alias{gen.DNAbin}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function to generate a DNAbin object}
\description{A function that uses information in a dataframe with data obtained from BOLD to
genereate a DNAbin object. The DNAbin object returned can be used with the 'ape' package.}
\usage{
gen.DNAbin(x.df = NULL, alignment = NULL, labels.headers = c(...))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x.df}{A dataframe with data obtained from BOLD.}
  \item{alignment}{Specify the alignment type.}
  \item{labels.headers}{The column names of the data frame to use to create the label.}
}
\details{}
\value{a DNAbin object.}
\references{}
\author{Nishan Mudalige}
\note{}
\seealso{}
\examples{
example.df <- get.public(container="CCANN")

example.DNAbin <- gen.DNAbin(example.df, alignment="COI-5P_nucraw", labels=c("processid","taxon"))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

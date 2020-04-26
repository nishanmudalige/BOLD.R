\name{fasta.out}
\alias{fasta.out}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function to write a fasta file}
\description{Write a fasta file using datafram with data obtained from BOLD.
The file is written by marker code.}
\usage{
fasta.out(x.df, marker.name, output.name = "output", remove.empty = FALSE, nbchar = 60)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x.df}{A dataframe containing data obtained from BOLD.}
  \item{marker.name}{A DNA marker.}
  \item{output.name}{The name of the output file. The extension ".fasta" is added by default.}
  \item{remove.empty}{Remove rows which do not have an entry for the chosen marker type.}
  \item{nbchar}{The number of characters per line.}
}
\details{}
\value{none.}
\references{}
\author{Nishan Mudalige}
\note{}


\seealso{}
\examples{
example.df <- get.public(container="CCANN")

fasta.out(example.df, "28S-D9-D10_nucraw", output.name = "testfile1")

fasta.out(example.df, "28S-D9-D10_nucraw", output.name = "testfile2", remove.empty=TRUE)
}

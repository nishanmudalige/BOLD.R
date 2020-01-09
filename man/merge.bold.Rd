\name{merge.bold}
\alias{merge.bold}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function to merge two dataframes with data obtained from BOLD.}
\description{A function which merges two data frames which contain data obtained from BOLD.
Merging data follows a hierarchy for overwriting data. Data obtained from the private API has higher
priority than the same data obtained from the public API and newer data has higher priority
over older data.}
\usage{
merge.bold(df.x, df.y)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{df.x}{A dataframe with data obtaiend from BOLD.}
  \item{df.y}{A dataframe with data obtaiend from BOLD.}
}
\value{A dataframe with merged data.}
\author{Nishan Mudalige}
\examples{
## token <- login.bold("username")

## example.df1 <- get.public(container="CCANN")
## example.df2 <- get.private("CCANN", token)
## example.df3 <- get.public(container="ACAGA")
## example.df4 <- get.private("ACAGA", token)
## example.df5 <- get.public(container="DS-ACGAG1")
## example.df6 <- get.private("DS-ACGAG1", token)
## example.df7 <- get.public(taxon="Reptilia")

## example.df.A <- merge.bold(## example.df1, ## example.df1)
## example.df.A

## example.df.B <- merge.bold(## example.df1, ## example.df2)
## example.df.B

## example.df.C <- merge.bold(## example.df1, ## example.df3)
## example.df.C

## example.df.D <- merge.bold(## example.df4, ## example.df5)
## example.df.D

## example.df.E <- merge.bold(## example.df6, ## example.df7)
## example.df.E
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
% \keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

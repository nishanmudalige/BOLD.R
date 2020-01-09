\name{login.bold}
\alias{login.bold}
\title{A function to login to BOLD.}
\description{A function to login to BOLD using a valid username and password.
Returns a token that identifies the user to the BOLD system.}
\usage{
  login.bold(username)
}
\arguments{
  \item{username}{A valid username to login to BOLD}
}
\details{}
\value{Returns a token which can be used to retrieve private data from BOLD.}
\author{Nishan Mudalige}
\examples{
## token <- login.bold("username")
## token
}

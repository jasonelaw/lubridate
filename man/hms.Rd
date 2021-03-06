% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parse.r
\name{hms}
\alias{hms}
\title{Create a period with the specified hours, minutes, and seconds}
\usage{
hms(..., quiet = FALSE)
}
\arguments{
\item{...}{a character vector of hour minute second triples}

\item{quiet}{logical. When TRUE function evalueates without displaying customary messages.}
}
\value{
a vector of period objects
}
\description{
Transforms a character or numeric vector into a period object with the
specified number of hours, minutes, and seconds. hms() recognizes all
non-numeric characters except '-' as separators ('-' is used for negative
durations).  After hours, minutes and seconds have been parsed, the
remaining input is ingored.
}
\examples{

x <- c("09:10:01", "09:10:02", "09:10:03")
hms(x)
## [1] "9H 10M 1S" "9H 10M 2S" "9H 10M 3S"

hms("7 6 5", "3:23:::2", "2 : 23 : 33", "Finished in 9 hours, 20 min and 4 seconds")
## [1] "7H 6M 5S" "3H 23M 2S" "2H 23M 33S" "9H 20M 4S"
}
\seealso{
\code{\link{hm}, \link{ms}}
}
\keyword{period}


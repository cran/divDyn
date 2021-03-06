% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cleaning.R
\name{cleansp}
\alias{cleansp}
\title{Cleanse Species Name Vector}
\usage{
cleansp(
  x,
  debug = FALSE,
  collapse = "_",
  subgenera = TRUE,
  misspells = TRUE,
  stems = TRUE
)
}
\arguments{
\item{x}{\code{(character)}: the vector containing species names with qualifiers of open taxonomy.}

\item{debug}{\code{(logical)}: \code{FALSE} will return the cleaned species name vector, \code{TRUE} returns a data table that allows one by one checking.}

\item{collapse}{\code{(character)}: This argument will be passed to the paste function's argument of the same name. The character value to be inserted between the genus and species names.}

\item{subgenera}{\code{(logical)}: \code{FALSE} omits subgenus information (in parentheses) and will construct a unique binomen based on the genus and species names alone. \code{TRUE} (default) will promote the subgenus names and it will create a new binomen based on the subgenus rather than the genus name.}

\item{misspells}{\code{logical}: Resolution of common spelling mistakes, such as diphtongs and alternate spellings: 'ue' is replaced with 'u', 'ae' is replaced with 'e', 'll' with 'l', 'ss' with 's'and 'y' with 'i'.}

\item{stems}{\code{(logical)}: Setting this to \code{TRUE} will omit the adjective declination suffices from the species names.}
}
\value{
A data.frame or character vector.
}
\description{
This function will take a vector of binomial names with various qualifiers of open nomenclatures, and removes them form the vector entries. Only the the genus and species names will remain.
}
\details{
This version will keep subgenera, and will not assign species to the base genus. The following qualifiers will be omitted:
\emph{"n."}, \emph{"sp."}, \emph{"?"}, \emph{"gen."}, \emph{"aff."}, \emph{"cf."}, \emph{"ex gr."}, \emph{"subgen."}, \emph{"spp"} and informal species designated with letters. Entries with \emph{"informal"} and \emph{"indet."} in them will also be invalidated.
}
\examples{
examp <- c("Genus cf. species", "Genus spp.", "Family indet.", 
  "Mygenus yourspecies", "Okgenus ? questionsp", 
  "Genus (cf. Subgenus) aff. species")
cleansp(examp) 
}
\author{
Adam T. Kocsis, Gwenn Antell. Adam T. Kocsis wrote the main body of the function, subroutines called by the \code{misspells} and \code{stems} are the modified work of Gwen Antell.
}

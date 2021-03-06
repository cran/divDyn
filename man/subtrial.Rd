% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subtrials.R
\name{subtrialCR}
\alias{subtrialCR}
\alias{subtrialOXW}
\alias{subtrialSQS}
\title{Subsampling trial functions}
\usage{
subtrialCR(
  x,
  q,
  bin = NULL,
  unit = NULL,
  keep = NULL,
  useFailed = FALSE,
  showFailed = FALSE
)

subtrialOXW(
  x,
  q,
  bin = NULL,
  coll = NULL,
  xexp = 1,
  keep = NULL,
  useFailed = FALSE,
  showFailed = FALSE
)

subtrialSQS(
  x,
  tax,
  q,
  bin = NULL,
  coll = NULL,
  ref = NULL,
  singleton = "occ",
  excludeDominant = FALSE,
  largestColl = FALSE,
  fcorr = "good",
  byList = FALSE,
  keep = NULL,
  useFailed = FALSE,
  showFailed = FALSE,
  appr = "under"
)
}
\arguments{
\item{x}{(\code{data.frame}): Occurrence dataset, with \code{bin}, \code{tax} and \code{coll} as column names.}

\item{q}{(\code{numeric)}: Subsampling level argument (mandatory). Depends on the subsampling function, it is the number of occurrences for \code{"cr"}, and the number of desired occurrences to the power of \code{xexp} for O^x^W. It is also the quorum of the SQS method.}

\item{bin}{(\code{character}): The name of the subsetting variable (has to be integer). For time series, this is the time-slice variable. Rows with \code{NA} entries in this column will be omitted.}

\item{unit}{(\code{character}): Argument of the CR subsampling type. The name of the variable that designates the subsampling units. In every bin, CR selects a certain number (quota) of entries from the dataset. By default (\code{unit=NULL}), the units will be the rows, and the \code{q} number of rows will be selected in each bin.
However, this can be a higher level category that has multiple entries in the each bin. If \code{unit} is a valid column of the dataset \code{x}, then CR will select \code{q} number entries in this variable, and will return all the corresponding rows.}

\item{keep}{(\code{numeric}): The bins, which will not be subsampled but will be added to the subsampling trials. NIf the number of occurrences does not reach the subsampling quota, by default it will not be represented in the subsampling trials. You can force their inclusion with the \code{keep} argument separetely (for all, see the \code{useFailed} argument). Only applicable when \code{bin!=NULL}.}

\item{useFailed}{(\code{logical}): If the bin does not reach the subsampling quota, should the bin be used? If \code{bin!=NULL} and \code{useFailed=TRUE} then only \code{TRUE} values will be output (indicating the use of the full dataset).}

\item{showFailed}{(\code{logical}): Toggles the output of the function. If set to \code{TRUE} the output will be a list, including both the default output (logical vector of rows) and the \code{numeric} vector of bins that did not have enough entries to reach the quota \code{q}. Only applicable when \code{bin!=NULL}.}

\item{coll}{(\code{character}): The variable name of the collection identifiers.}

\item{xexp}{(\code{numeric}): Argument of the OxW type. The exponent of by-list subsampling, by default it is 1.}

\item{tax}{(\code{character}): The name of the taxon variable.}

\item{ref}{(\code{character}): The name of the reference variable, optional - depending on the subsampling method.}

\item{singleton}{\code{(character)}: A parameter of SQS. Either \code{"ref"}, \code{"occ"} or \code{FALSE}. If set to \code{"occ"}, the coverage estimator (e.g. Good's u) will be calculated based on the number of single-occurrence taxa. 
If set to "ref" the number of occurrences belonging to single-reference taxa will be used instead. In case of the inexact algorithm, if set to \code{FALSE} then coverage corrections of frequencies will not be applied.}

\item{excludeDominant}{\code{(logical)}: Argument of SQS. This parameter sets whether the dominant taxon should 
be excluded from all calculations involving frequencies (this is the second correction of Alroy, 2010).}

\item{largestColl}{\code{(logical)}: Parameter of SQS. This parameter sets whether the occurrences of taxa only ever
 found in the most diverse collection should be excluded from the count of 
single-publication occurrences. (this is the third correction of Alroy, 2010) Note that \code{largestColl=TRUE} is dependent on \code{excludeDominant=TRUE}. Setting \code{excludeDominant} to \code{FALSE} will turn this correction off.}

\item{fcorr}{\code{(character)}: Parameter for the inexact method of SQS. either "good" or "alroy". This argument changes the frequency correction procedure of the 
'inexact' version of SQS (Alroy 2010). As not all taxa are present in the samples, 
the sampled frequencies of taxa tend overestimate their frequencies in the sampling pool. 
In Alroy (2010) these are corrected using Good's u ("good", default), in the later versions 
of SQS this metric is changed to a different method using single occurrence and double occurrence taxa ("alroy").}

\item{byList}{(\code{character}): A parameter of the \code{"inexact"} method of SQS. Sets whether occurrences should be subsampled with (\code{FALSE}) or without (\code{TRUE}) breaking the collection integrity.}

\item{appr}{(\code{character}): A parameter of the inexact method of SQS. Either "over" (default) or ("under"). The current 
version is not concerned with small fluctuations around the drawn subsampling quorum. 
Therefore, in the inexact algorithm, sampling is finished when the subset 
either is immediately below the quorum (\code{"under"}) or above it (\code{"over"}).}
}
\value{
A logical vector.
}
\description{
These functions create one subsampling trial dataset with a desired subsampling method
}
\details{
The essence of these functions are present within the subsampling wrapper function \code{\link{subsample}}. Each function implements a certain subsampling type.
The return value of the funcfions by default is a \code{logical} vector indicating which rows of the original dataset should be present in the subsample. 
The inexact method for SQS is implemented here as it is computationally less demanding. 

\strong{References:}

Alroy, J., Marshall, C. R., Bambach, R. K., Bezusko, K., Foote, M., Fürsich, F. T., … Webber, A. (2001). Effects of sampling standardization on estimates of Phanerozoic marine diversification. Proceedings of the National Academy of Science, 98(11), 6261-6266.

Alroy, J. (2010). The Shifting Balance of Diversity Among Major Marine Animal Groups. Science, 329, 1191-1194. https://doi.org/10.1126/science.1189910

Raup, D. M. (1975). Taxonomic Diversity Estimation Using Rarefaction. Paleobiology, 1, 333-342. https: //doi.org/10.2307/2400135
}
\examples{
#one classical rarefaction trial
  data(corals)
# return 5 references for each stage
  bRows<-subtrialCR(corals, bin="stg", unit="reference_no", q=5)
  # control
  unCor<-unique(corals[bRows,c("stg", "reference_no")])
  table(unCor$stg)

}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ddwindows.R
\name{ddwindows}
\alias{ddwindows}
\title{ddwindows}
\usage{
ddwindows(
  edgelist,
  tie_effects,
  mintime,
  covar,
  actors = NULL,
  stop.rule = TRUE,
  K = 3,
  directed = TRUE,
  ncores = 2
)
}
\arguments{
\item{edgelist}{an object of class \code{"\link[base]{data.frame}"} or 
\code{"\link[base]{matrix}"} characterizing the relational event history 
sorted by time with columns `time`, `actor1`, `actor2` and optionally `type` 
and `weight`. Alternatively, an object of class \code{"\link[remify]{reh}"}}

\item{tie_effects}{an object of class \code{"\link[stats]{formula}"} (or one 
that can be coerced to that class): a symbolic description of the effects in 
the tie-oriented model for which statistics are computed, see 'Details' for 
the available effects and their corresponding statistics}

\item{mintime}{minimum window width.}

\item{covar}{attributes dataframe with columns that describe, in order, 
actors' "id", attributes' change "time" and attributes' values.}

\item{actors}{vector of actors that may be observed interacting in the network. If \code{NULL}, actor names will be taken from the input edgelist.}

\item{stop.rule}{determines if the algorithm stops searching for the optimal
window width if the log BF drops below 1/10, default is TRUE.}

\item{K}{number of segments K to divide the proposed window in, default is 3}

\item{directed}{logical value indicating whether dyadic events are directed (\code{TRUE}) or undirected (\code{FALSE}).}

\item{ncores}{number of threads for the parallelization (\code{default = 1}, no parallelization)}
}
\value{
List with elements "windows" and "options".
}
\description{
Function to obtain data-driven window widths.
}

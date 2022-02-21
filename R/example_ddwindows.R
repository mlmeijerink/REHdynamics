#' example_ddwindows
#' 
#' Contains the data-driven window widths for the empirical example data (see
#' `edges`).
#' 
#' @format List of length two:
#' \describe{
#'  \item{windows}{Dataframe with 343 rows and 6 columns. Contains the time for
#'  the begin and end of an optimal window around 343 time points. The 
#'  column 'm' refers to the number of events in the window. LogF to the 
#'  log fit, logC to the log complexity and logBF to the log Bayes factor
#'  for the Bayesian test for dynamic effects during the window. The column
#'  'width' refers to the width of the data-driven window and 't' for the time
#'  point around when the window width was determined. }
#'  \item{options}{List of length 343 with all the tried out window widths for 
#'  each time point and the results for the Bayesian test for dynamic effects 
#'  during the proposed window widths.}
#' }
"example_ddwindows"
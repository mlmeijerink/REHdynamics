#' param
#' 
#' List with parameters for the four time-varying effect scenarios.
#' 
#' @format A list with four elements:
#' \describe{
#'  \item{constant}{A list of length six, each element a numeric value of the 
#'  parameter for the effects in the "constant" scenario.}
#'  \item{cyclic}{A list of length six, each element a function of time,
#'  the output determines the value of the parameters at a certain timepoint
#'  in the "cyclic" scneario.}
#'  \item{gradual}{A list of length six, each element a function of time,
#'  the output determines the value of the parameters at a certain timepoint
#'  in the "gradual" scneario.}
#'  \item{mixed}{A list of length six, each element a function of time,
#'  the output determines the value of the parameters at a certain timepoint
#'  in the "mixed" scneario.} 
#' }
"param"
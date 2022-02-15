#' createwindows
#' 
#' A function that creates a dataframe with window timepoints
#' 
#' @param length numeric value that indicates the length of the window in the
#' correct time units
#' @param end numeric value that indicates the maximum time for the windows
#' @param start numeric value that indicates the minimum time for the windows, 
#' if not supplied it is assumed to be 0
#' @param overlap numeric value between 0 and 1 indicating the proportion of 
#' overlap between subsequent windows
#' 
#' @export
createwindows <- function(length, end, start = NULL, overlap = 2/3) {
	if(is.null(start)) {start <- 0}
	data.frame(
		begin = seq(start, end-length, (1-overlap)*length),
		end = seq(start + length, end, (1-overlap)*length))
}
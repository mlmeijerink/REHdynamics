#' MWrem
#' 
#' Function that fits a moving window relational event model (using remstimate).
#' 
#' @param windows dataframe with two columns, the first column containing the 
#' time point for the start of each window and the second column containing
#' the time point for the end of each window
#' @inheritParams remify::reh
#' @inheritParams remstimate::remstimate
#' 
#' @return list with fitted rems for each window 
#' 
#' @export
MWrem <- function(windows, edgelist, stats, actors, directed, method = "MLE", model = "tie", ncores = 1) {
	# Loop over the windows
	fit <- lapply(1:nrow(windows), function(w) {
		# Get the events that fall within the window
		wi <- which(edgelist[,1] >= windows[w,1] & edgelist[,1] < windows[w,2])
		
		if(length(wi) > 1) {
			# Extract the window edgelist
			rehW <- remify::reh(edgelist[wi,], actors = actors, directed = directed,
				model = "tie", origin = windows[w,1])
			
			# Extract the window statistics
			statsW <- stats[wi,,]
			
			# Estimate
			tryCatch(remstimate::remstimate(reh = rehW, stats = statsW, 
				method = method, model = model, ncores = ncores))
		} else {
			"error"
		}
	})
	
	# Output
	fit
}
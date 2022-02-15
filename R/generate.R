#' generate
#' 
#' Function to generate REH data
#' 
#' @param formula formula object that can be supplied to the tie_effects
#' argument of remstats::remstats
#' @param param parameters for the effects
#' @param covar attributes dataframe with columns that describe, in order, 
#' actors' "id", attributes' change "time" and attributes' values.
#' @param M number of events
#' 
#' @return dataframe with columns that describe subsequently the time, sender 
#' and receiver of the events
#' 
#' @export
generate <- function(formula, param, covar, M) {
	
	# Set things up 
	t <- 0
	dummy <- data.frame(time = 1, actor1 = 1, actor2 = 2)
	rehOut <- remify::reh(dummy, actors = covar$id, model = "tie")
	remstatsOut <- remstats::tomstats(edgelist = rehOut, effects = formula)
	
	riskset <- remstatsOut$riskset
	adj <- matrix(0, 1, ncol = nrow(riskset))
	
	# Loop over M
	for(i in 1:M) {
		# Get the statistics
		stats <- remstatsOut$statistics
		
		# Update the parameters
		beta <- lapply(param, function(x) {
			if(class(x) == "function") {
				x(t)
			} else {
				x
			}
		})
		
		# Compute lambda
		logLambda <- stats[1,,]%*%unlist(beta)
		lambda <- exp(logLambda)
		
		# Sample the next event
		dt <- rexp(1, sum(lambda))
		d <- sample(1:nrow(lambda), 1, prob = lambda/sum(lambda))
		
		# Add to the edgelist
		if(i == 1) {
			edgelist <- cbind(time = (t + dt), 
				actor1 = riskset[d,1],
				actor2 = riskset[d,2])
		} else {
			edgelist <- rbind(edgelist, 
				cbind(time = (t + dt), 
					actor1 = riskset[d,1],
					actor2 = riskset[d,2]))
		}
		
		edgelist <- as.data.frame(edgelist)
		edgelist$time <- as.numeric(edgelist$time)
		t <- max(edgelist$time) 
		
		# Add to the adjacency matrix
		adj <- rbind(adj, adj[i,])
		adj[i + 1, d] <- adj[i + 1, d] + 1
		
		# Give update
		cat(i, "\r")
		
		# Compute new stats
		if(i < M) {
			dummy$time <- dummy$time + t
			edgelistTemp <- rbind(edgelist, dummy)
			remstatsOut <- remstats::tomstats(edgelist = edgelistTemp, effects = formula, 
				actors = covar$id, start = nrow(edgelistTemp), 
				stop = nrow(edgelistTemp), output = "stats_only",
				adjmat = as.matrix(t(adj[i + 1,])))
		}
		
	} 
	
	edgelist
}
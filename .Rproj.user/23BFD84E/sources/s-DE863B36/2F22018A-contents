#' ddwindows
#' 
#' Function to obtain data-driven window widths.
#' 
#' @param mintime minimin window width.
#' @param stop.rule determines if the algorithm stops searching for the optimal
#' window width if the log BF drops below 1/10, default is TRUE.
#' @param K number of segments K to divide the proposed window in, default is 3
#' @inheritParams remstats::remstats
#' @inheritParams REHdynamics::dyneval
#' @inheritParams remstimate::remstimate
#' 
#' @return List with elements "windows" and "options".
#' @export
ddwindows <- function(edgelist, tie_effects, mintime, covar, K = 3, 
	stop.rule = TRUE, actors = NULL, directed = TRUE, ncores = 2) {
	# Event times
	times <- edgelist$time
	tau <- max(times)
	
	# Define the timepoint around when the window width will be determined
	wmids <- seq(mintime/2, tau - mintime/2, (1/3)*mintime)
	
	# Set things up
	optionsList <- list()
	windows <- data.frame()
	
	# Determine the optimal window lenght for each wmids value
	for(w in wmids) {
		# Potential window lengths
		begin <- w - mintime/2
		end <- w + mintime/2
		i <- 1
		while(tail(begin, n = 1) > 0 & tail(end, n = 1) < tau) {
			begin <- c(begin, (w - mintime/2) - (mintime/3)*i )
			end <- c(end, (w + mintime/2) + (mintime/3)*i )
			i <- i + 1
		}
		options <- data.frame(begin = begin, end = end)
		options$begin[options$begin < 0] <- 0
		options$end[options$end > tau] <- tau
		
		# Saving space
		options$logBF <- options$logC <- options$logF <- options$m <- NA
		
		# Progress report
		cat(paste("Determine the window length at t =", round(w)), "\n")
		
		# Compute the logBF for each potential window length 
		for(j in 1:nrow(options)) {
			
			# Time length
			width <- options$end[j] - options$begin[j]
			
			# For loop over q = 1:K
			fit <- lapply(1:K, function(q) {
				# Indices for the events that fall in the kth parth of the window
				ind <- rep(FALSE, nrow(edgelist))
				ind[which(edgelist$time >= (options$begin[j] + width/K * (q-1)) & 
						edgelist$time <= (options$begin[j] + width/K * q))] <- TRUE
				
				if(sum(ind) > 1) {
					remstatsObject <- remstats::remstats(edgelist = edgelist, 
						tie_effects = tie_effects, actors = actors, start = min(which(ind)),
						stop = max(which(ind)), directed = directed, output = "stats_only")
					rehObject <- remify::reh(edgelist[ind,], actors = actors, directed = directed, 
						origin = (options$begin[j] + (width/K * (q-1))), model = "tie")
					rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
					
					# Fit the rem
					tryCatch(remstimate::remstimate(reh = rehObject, 
						stats = remstatsObject$statistics, method = "MLE", model = "tie",
						ncores = 2), error = function(e) "error")
				} else {
					"Not enough events in the window"
				}
			})
			
			# Skip to the next proposed window if one of the sequences had too few
			# events
			if(!all(sapply(fit, class) == "remstimate")) {next}
			
			# Skip to the next proposed window if one of the estimations did not 
			# converge (because of too few events)
			if("try-error" %in% sapply(fit, function(x) class(x$se))) {
				next
			}  
			
			# Group sample sizes
			ngroup <- sapply(fit, function(x) x$df.null)
			
			# Number of parameters
			nparam <- length(fit[[1]]$coef)
			
			# Hypothesis-matrix
			hyp_mat <- lapply(1:(K-1), function(q) {
				t(sapply(1:nparam, function(p) {
					row <- rep(0, nparam*K)
					row[p + nparam*(q-1)] <- 1
					row[p + nparam*q] <- -1
					row
				}))
			})
			
			hyp_mat <- do.call(rbind, hyp_mat)
			
			# Group covariances list
			covlist <- lapply(fit, function(x) x$vcov)
			
			# Multiply by b for the prior covariances 
			b <- rep(0, length(covlist))
			priorcovlist <- vector("list", length = length(covlist))
			for (g in 1:length(covlist)) {
				b[g] <- 1 / length(covlist) * nrow(hyp_mat) / ngroup[g]
				priorcovlist[[g]] <- covlist[[g]] / (b[g])
			}
			
			# Combine 
			covpost <- covprior <- matrix(0, nparam*length(covlist), 
				nparam*length(covlist))
			for(q in 1:K) {
				covpost[(nparam * (q-1) + 1):(nparam * (q)), 
					(nparam * (q-1) + 1):(nparam * (q))] <- covlist[[q]]
				covprior[(nparam * (q-1) + 1):(nparam * (q)), 
					(nparam * (q-1) + 1):(nparam * (q))] <- priorcovlist[[q]]
			}
			
			# Compute difference estimates
			est <- as.vector(sapply(fit, function(x) x$coef))
			est <- c(hyp_mat%*%est)
			
			# Parameter transformation for the covariance matrix 
			estcovpost <- hyp_mat%*%covpost%*%t(hyp_mat)
			estcovpri <- hyp_mat%*%covprior%*%t(hyp_mat)
			
			# Force matrix to be symmetrical (sometimes not because of machine 
			# precision). 
			if(isSymmetric(estcovpost, tol = sqrt(.Machine$double.eps))) {
				estcovpost[lower.tri(estcovpost)] = t(estcovpost)[lower.tri(estcovpost)]
			} else {
				break
			}
			
			if(isSymmetric(estcovpri, tol = sqrt(.Machine$double.eps))) {
				estcovpri[lower.tri(estcovpri)] = t(estcovpri)[lower.tri(estcovpri)]
			} else {
				break
			}
			
			# Compute fit and complexity 
			fit <- mvtnorm::dmvnorm(rep(0, nrow(hyp_mat)),mean=est,
				sigma=estcovpost,log = TRUE)  
			comp <- mvtnorm::dmvnorm(rep(0, nrow(hyp_mat)),mean=rep(0, length(est)),
				sigma=estcovpri,log=TRUE) 
			BF <- fit-comp
			bfres <- cbind(fit = fit, complexity = comp, logBF = BF)
			
			# Test output
			options$logBF[j] <- bfres[3]
			options$logC[j] <- bfres[2]
			options$logF[j] <- bfres[1]
			options$m[j] <- sum(ngroup)
			
			# Stopping rule
			if(stop.rule) {
				if(exp(options$logBF[j]) < (1/10)) {break}
			}
		}
		
		# Select best window
		windows <- rbind(windows, options[which.max(options$logBF),])
		
		# Save output
		optionsList <- c(optionsList, list(options))
	}
	
	# Output
	list(windows = windows, options = optionsList)  
}
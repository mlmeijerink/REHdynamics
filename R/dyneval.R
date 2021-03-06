#' dyneval 
#' 
#' A function to test for time-varying network effects in a relational event
#' history.
#' 
#' @param K number of segments K to divide the edgelist in
#' @param covar attributes dataframe with columns that describe, in order, 
#' actors' "id", attributes' change "time" and attributes' values.
#' @inheritParams remstats::remstats
#' @inheritParams remstimate::remstimate
#' 
#' @return List with elements "fit", "bfres" and "ngroup".
#' @export
dyneval <- function(K, tie_effects, edgelist, covar, 
	directed = FALSE, actors = NULL, ncores = 1) {
	
	# Maximum time
	tau <- max(edgelist$time)
	
	# Actors
	if(is.null(actors)) {actors <- covar$id}
	
	# For loop over q = 1:K
	fit <- list()
	for(q in 1:K) {
		# Indices for the events that fall in the kth subsequence
		ind <- rep(FALSE, nrow(edgelist))
		ind[which(edgelist$time >= tau/K * (q-1) & 
				edgelist$time <= tau/K * q)] <- TRUE
		
		remstatsObject <- remstats::tomstats(edgelist = edgelist, 
			effects = tie_effects, actors = actors, start = min(which(ind)), 
			directed = directed, stop = max(which(ind)), output = "stats_only")
		rehObject <- remify::reh(edgelist[ind,], actors = actors, 
			directed = directed, 
			origin = (tau/K * (q-1)), model = "tie")
		rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
		
		# Fit the rem
		fit[[q]] <- tryCatch(remstimate::remstimate(reh = rehObject, 
			stats = remstatsObject$statistics, method = "MLE", model = "tie",
			ncores = ncores))
	}
	
	# Output warnning if one of the estimations did not converge (probably 
	# too few events)
	if("try-error" %in% sapply(fit, function(x) class(x$se))) {
		warning("One subsequence k did not converge.")
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
		stop("estcovpost must be a symmetric matrix")
	}
	
	if(isSymmetric(estcovpri, tol = sqrt(.Machine$double.eps))) {
		estcovpri[lower.tri(estcovpri)] = t(estcovpri)[lower.tri(estcovpri)]
	} else {
		stop("estcovpri must be a symmetric matrix")
	}
	
	# Compute fit and complexity 
	f <- mvtnorm::dmvnorm(rep(0, nrow(hyp_mat)),mean=est,
		sigma=estcovpost,log = TRUE)  
	c <- mvtnorm::dmvnorm(rep(0, nrow(hyp_mat)),mean=rep(0, length(est)),
		sigma=estcovpri,log=TRUE) 
	BF <- f-c
	bfres <- cbind(fit = f, complexity = c, logBF = BF)
	
	# Output
	list(fit = fit, bfres = bfres, ngroup = ngroup)
}
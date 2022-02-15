## code to prepare `static_cyclic` dataset goes here

# Load data 
data(cyclic, package = "REHdynamics")
data(covar, package = "REHdynamics")

# Loop over datasets
static_cyclic <- lapply(1:length(cyclic), function(r) {
	# Run remify
	rehObject <- remify::reh(cyclic[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run remstimate
	remstimate::remstimate(reh = rehObject, stats = statsObject$statistics, 
		method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(static_cyclic, overwrite = TRUE)

## code to prepare `static_gradual` dataset goes here

# Load data 
data(gradual, package = "REHdynamics")
data(covar, package = "REHdynamics")

# Loop over datasets
static_gradual <- lapply(1:length(gradual), function(r) {
	# Run remify
	rehObject <- remify::reh(gradual[[r]], actors = covar$id, directed = TRUE,
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

usethis::use_data(static_gradual, overwrite = TRUE)

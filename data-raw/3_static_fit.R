# Load package
library(REHdynamics)

## code to prepare `static_constant` dataset 
# Loop over datasets
static_constant <- lapply(1:length(constant), function(r) {
	# Run remify
	rehObject <- remify::reh(constant[[r]], actors = covar$id, directed = TRUE,
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

usethis::use_data(static_constant)

## code to prepare `static_cyclic` dataset 
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

usethis::use_data(static_cyclic)

## code to prepare `static_gradual` dataset 
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

usethis::use_data(static_gradual)

## code to prepare `static_mixed` dataset 
# Loop over datasets
static_mixed <- lapply(1:length(mixed), function(r) {
	# Run remify
	rehObject <- remify::reh(mixed[[r]], actors = covar$id, directed = TRUE,
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

usethis::use_data(static_mixed)

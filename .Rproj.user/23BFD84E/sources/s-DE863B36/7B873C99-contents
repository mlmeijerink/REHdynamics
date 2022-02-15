# Load data 
data(mixed, package = "REHdynamics")
data(covar, package = "REHdynamics")

# Maximum timepoint
tau <- max(sapply(mixed, function(x) max(x[,1])))

# ------------------------------------------------------------------------------
# t = 4000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(4000, tau)

# Loop over datasets
MW4000_mixed <- lapply(1:length(mixed), function(r) {
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
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = mixed[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW4000_mixed, overwrite = TRUE)

# ------------------------------------------------------------------------------
# t = 2000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(2000, tau)

# Loop over datasets
MW2000_mixed <- lapply(1:length(mixed), function(r) {
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
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = mixed[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW2000_mixed, overwrite = TRUE)

# ------------------------------------------------------------------------------
# t = 1000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(1000, tau)

# Loop over datasets
MW1000_mixed <- lapply(1:length(mixed), function(r) {
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
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = mixed[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW1000_mixed, overwrite = TRUE)

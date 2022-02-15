# Load data
data(constant, package = "REHdynamics")
data(covar, package = "REHdynamics")

# Model
formula <- ~ 1 + remstats::send("z", covar) + 
	remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + 
	remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

# Loop over datasets
ddwindows_constant <- lapply(1:length(constant), function(r) {
	ddwindows(edgelist = constant[[r]], tie_effects = formula, mintime = 1000, 
		covar = covar)
})

usethis::use_data(ddwindows_constant, overwrite = TRUE)

# Loop over datasets
ddfit_constant <- lapply(1:length(constant), function(r) {
	stats <- remstats::remstats(edgelist = constant[[r]], tie_effects = formula,
		actors = covar$id, directed = TRUE, origin = 0, attributes = covar, 
		output = "stats_only")
	MWrem(windows = ddwindows_constant[[r]]$windows, edgelist = constant[[r]], 
		stats = stats$statistics, actors = covar$id, directed = TRUE)
})

usethis::use_data(ddfit_constant, overwrite = TRUE)

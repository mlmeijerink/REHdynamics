# Load data
data(cyclic, package = "REHdynamics")
data(covar, package = "REHdynamics")

# Model
formula <- ~ 1 + remstats::send("z", covar) + 
	remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + 
	remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

# Loop over datasets
ddwindows_cyclic <- lapply(1:length(cyclic), function(r) {
	ddwindows(edgelist = cyclic[[r]], tie_effects = formula, mintime = 1000, 
		covar = covar)
})

usethis::use_data(ddwindows_cyclic, overwrite = TRUE)

# Loop over datasets
ddfit_cyclic <- lapply(1:length(cyclic), function(r) {
	stats <- remstats::remstats(edgelist = cyclic[[r]], tie_effects = formula,
		actors = covar$id, directed = TRUE, origin = 0, attributes = covar, 
		output = "stats_only")
	MWrem(windows = ddwindows_cyclic[[r]]$windows, edgelist = cyclic[[r]], 
		stats = stats$statistics, actors = covar$id, directed = TRUE)
})

usethis::use_data(ddfit_cyclic, overwrite = TRUE)

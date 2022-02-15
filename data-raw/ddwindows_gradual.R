# Load data
data(gradual, package = "REHdynamics")
data(covar, package = "REHdynamics")

# Model
formula <- ~ 1 + remstats::send("z", covar) + 
	remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + 
	remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

# Loop over datasets
ddwindows_gradual <- lapply(1:length(gradual), function(r) {
	ddwindows(edgelist = gradual[[r]], tie_effects = formula, mintime = 1000, 
		covar = covar)
})

usethis::use_data(ddwindows_gradual, overwrite = TRUE)

# Loop over datasets
ddfit_gradual <- lapply(1:length(gradual), function(r) {
	stats <- remstats::remstats(edgelist = gradual[[r]], tie_effects = formula,
		actors = covar$id, directed = TRUE, origin = 0, attributes = covar, 
		output = "stats_only")
	MWrem(windows = ddwindows_gradual[[r]]$windows, edgelist = gradual[[r]], 
		stats = stats$statistics, actors = covar$id, directed = TRUE)
})

usethis::use_data(ddfit_gradual, overwrite = TRUE)

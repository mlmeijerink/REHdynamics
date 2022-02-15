# Load data
data(mixed, package = "REHdynamics")
data(covar, package = "REHdynamics")

# Model
formula <- ~ 1 + remstats::send("z", covar) + 
	remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + 
	remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

# Loop over datasets
ddwindows_mixed <- lapply(1:length(mixed), function(r) {
	ddwindows(edgelist = mixed[[r]], tie_effects = formula, mintime = 1000, 
		covar = covar)
})

usethis::use_data(ddwindows_mixed, overwrite = TRUE)

# Loop over datasets
ddfit_mixed <- lapply(1:length(mixed), function(r) {
	stats <- remstats::remstats(edgelist = mixed[[r]], tie_effects = formula,
		actors = covar$id, directed = TRUE, origin = 0, attributes = covar, 
		output = "stats_only")
	MWrem(windows = ddwindows_mixed[[r]]$windows, edgelist = mixed[[r]], 
		stats = stats$statistics, actors = covar$id, directed = TRUE)
})

usethis::use_data(ddfit_mixed, overwrite = TRUE)

# Preparation
# Load package
library(REHdynamics)

# Model
formula <- ~ 1 + remstats::send("z", covar) + 
	remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + 
	remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

# ------------------------------------------------------------------------------
# constant 
# ------------------------------------------------------------------------------

# Loop over datasets
ddwindows_constant <- lapply(1:length(constant), function(r) {
	ddwindows(edgelist = constant[[r]], tie_effects = formula, mintime = 1000, 
		covar = covar)
})

usethis::use_data(ddwindows_constant)

# Loop over datasets
ddfit_constant <- lapply(1:length(constant), function(r) {
	stats <- remstats::remstats(edgelist = constant[[r]], tie_effects = formula,
		actors = covar$id, directed = TRUE, origin = 0, attributes = covar, 
		output = "stats_only")
	MWrem(windows = ddwindows_constant[[r]]$windows, edgelist = constant[[r]], 
		stats = stats$statistics, actors = covar$id, directed = TRUE)
})

usethis::use_data(ddfit_constant)

# ------------------------------------------------------------------------------
# cyclic 
# ------------------------------------------------------------------------------

# Loop over datasets
ddwindows_cyclic <- lapply(1:length(cyclic), function(r) {
	ddwindows(edgelist = cyclic[[r]], tie_effects = formula, mintime = 1000, 
		covar = covar)
})

usethis::use_data(ddwindows_cyclic)

# Loop over datasets
ddfit_cyclic <- lapply(1:length(cyclic), function(r) {
	stats <- remstats::remstats(edgelist = cyclic[[r]], tie_effects = formula,
		actors = covar$id, directed = TRUE, origin = 0, attributes = covar, 
		output = "stats_only")
	MWrem(windows = ddwindows_cyclic[[r]]$windows, edgelist = cyclic[[r]], 
		stats = stats$statistics, actors = covar$id, directed = TRUE)
})

usethis::use_data(ddfit_cyclic)

# ------------------------------------------------------------------------------
# gradual 
# ------------------------------------------------------------------------------

# Loop over datasets
ddwindows_gradual <- lapply(1:length(gradual), function(r) {
	ddwindows(edgelist = gradual[[r]], tie_effects = formula, mintime = 1000, 
		covar = covar)
})

usethis::use_data(ddwindows_gradual)

# Loop over datasets
ddfit_gradual <- lapply(1:length(gradual), function(r) {
	stats <- remstats::remstats(edgelist = gradual[[r]], tie_effects = formula,
		actors = covar$id, directed = TRUE, origin = 0, attributes = covar, 
		output = "stats_only")
	MWrem(windows = ddwindows_gradual[[r]]$windows, edgelist = gradual[[r]], 
		stats = stats$statistics, actors = covar$id, directed = TRUE)
})

usethis::use_data(ddfit_gradual)

# ------------------------------------------------------------------------------
# mixed 
# ------------------------------------------------------------------------------

# Loop over datasets
ddwindows_mixed <- lapply(1:length(mixed), function(r) {
	ddwindows(edgelist = mixed[[r]], tie_effects = formula, mintime = 1000, 
		covar = covar)
})

usethis::use_data(ddwindows_mixed)

# Loop over datasets
ddfit_mixed <- lapply(1:length(mixed), function(r) {
	stats <- remstats::remstats(edgelist = mixed[[r]], tie_effects = formula,
		actors = covar$id, directed = TRUE, origin = 0, attributes = covar, 
		output = "stats_only")
	MWrem(windows = ddwindows_mixed[[r]]$windows, edgelist = mixed[[r]], 
		stats = stats$statistics, actors = covar$id, directed = TRUE)
})

usethis::use_data(ddfit_mixed)

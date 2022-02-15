# Load data
data(edges, package = "REHdynamics")
data(attributes, package = "REHdynamics")

# Prepare department covariate
attributes$depc <- as.numeric(factor(attributes$department))
covar <- attributes

# Model 
model <- ~ 1 + same("depc", covar) + recencyContinue() +
	inertia(scaling = "std") + sp(scaling = "std") 

# Test 
test <- list()
for(K in 2:10) {
	test[[K-1]] <- tryCatch(dyneval(K = K, tie_effects = model, edgelist = edges, 
		covar = covar, directed = FALSE, actors = covar$id))
	cat(K, "\r")
}

usethis::use_data(example_test, overwrite = TRUE)

# Windows, fixed
small <- createwindows(length = 2*60*60, end = max(events$time) + (1/3)*2*60*60, 
	start = 0, overlap = 2/3)
medium <- createwindows(length = 6*60*60, end = max(events$time) + (1/3)*6*60*60, 
	start = 0, overlap = 2/3)
large <- createwindows(length = 12*60*60, end = max(events$time) + (1/3)*12*60*60, 
	start = 0, overlap = 2/3)

# Windows, data-driven
example_ddwindows <- ddwindows(edgelist = edges, tie_effects = model,
	mintime = 1*60*60, covar = covar, actors = covar$id, stop.rule = TRUE,
	K = 3, directed = FALSE, ncores = 3)

usethis::use_data(example_ddwindows, overwrite = TRUE)

# Stats
out <- remstats(tie_effects = model, edgelist = events, actors = covar$id,
	directed = FALSE, origin = 0)

# Fit
example_MW2 <- MWrem(windows = small, edgelist = edges, stats = out$statistics, 
	actors = covar$id, directed = FALSE, ncores = 2)
example_MW6 <- MWrem(windows = medium, edgelist = edges, stats = out$statistics, 
	actors = covar$id, directed = FALSE, ncores = 2)
example_MW12 <- MWrem(windows = large, edgelist = edges, stats = out$statistics, 
	actors = covar$id, directed = FALSE, ncores = 2)
example_ddfit <- MWrem(windows = example_ddwindows$windows, edgelist = edges, 
	stats = out$statistics, actors = covar$id, directed = FALSE, ncores = 2)

usethis::use_data(example_MW2, overwrite = TRUE)
usethis::use_data(example_MW6, overwrite = TRUE)
usethis::use_data(example_MW12, overwrite = TRUE)
usethis::use_data(example_ddfit, overwrite = TRUE)


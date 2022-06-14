# Load package
library(REHdynamics)

# Prepare department covariate
attributes$depc <- as.numeric(factor(attributes$department))
covar <- attributes

# Model 
model <- ~ 1 + remstats::same("depc", covar) + remstats::recencyContinue() +
	remstats::inertia(scaling = "std") + remstats::sp(scaling = "std") 

# Test 
example_test <- list()
for(K in 2:10) {
	example_test[[K-1]] <- tryCatch(dyneval(K = K, tie_effects = model, 
		edgelist = edges, covar = covar, directed = FALSE, actors = covar$id))
	cat(K, "\r")
}

usethis::use_data(example_test)

# Windows, fixed
small <- createwindows(length = 2*60*60, end = max(edges$time) + (1/3)*2*60*60, 
	start = 0, overlap = 2/3)
medium <- createwindows(length = 6*60*60, end = max(edges$time) + (1/3)*6*60*60, 
	start = 0, overlap = 2/3)
large <- createwindows(length = 12*60*60, end = max(edges$time) + (1/3)*12*60*60, 
	start = 0, overlap = 2/3)

# Windows, data-driven
example_ddwindows <- ddwindows(edgelist = edges, tie_effects = model,
	mintime = 1*60*60, covar = covar, actors = covar$id, stop.rule = TRUE,
	K = 3, directed = FALSE, ncores = 3)
example_ddwindows$windows$width <- with(example_ddwindows$windows, end-begin)
example_ddwindows$windows$t <- with(example_ddwindows$windows, begin + width/2)

usethis::use_data(example_ddwindows)

# Stats
out <- remstats(tie_effects = model, edgelist = edges, actors = covar$id,
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

usethis::use_data(example_MW2)
usethis::use_data(example_MW6)
usethis::use_data(example_MW12)
usethis::use_data(example_ddfit)


## code to prepare `test_cyclic` dataset goes here

# Define the formula
formula <- ~ 1 + remstats::send("z", covar) + remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

# Load the data
data(cyclic, package = "REHdynamics")
data(covar, package = "REHdynamics")

test_cyclic <- list()
# For loop over datasets
for(i in 1:length(cyclic)) {
	# Run test for K = 2:10
	test_cyclic[[i]] <- lapply(2:10, function(K) {
		tryCatch(dyneval(K, tie_effects = formula, edgelist = cyclic[[i]], 
			covar = covar, directed = TRUE, actors = covar$id), 
			error = function(e) "error")
	})
	cat(paste0("Dataset ", i, " finished."), "\n")
}

usethis::use_data(test_cyclic, overwrite = TRUE)

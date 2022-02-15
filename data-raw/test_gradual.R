## code to prepare `test_gradual` dataset goes here

# Define the formula
formula <- ~ 1 + remstats::send("z", covar) + remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

# Load the data
data(gradual, package = "REHdynamics")
data(covar, package = "REHdynamics")

test_gradual <- list()
# For loop over datasets
for(i in 1:length(gradual)) {
	# Run test for K = 2:10
	test_gradual[[i]] <- lapply(2:10, function(K) {
		tryCatch(dyneval(K, tie_effects = formula, edgelist = gradual[[i]], 
			covar = covar, directed = TRUE, actors = covar$id), 
			error = function(e) "error")
	})
	cat(paste0("Dataset ", i, " finished."), "\n")
}

usethis::use_data(test_gradual, overwrite = TRUE)

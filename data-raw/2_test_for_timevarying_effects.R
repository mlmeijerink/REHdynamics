# preparation 
# Load package
library(REHdynamics)

# Define the formula
formula <- ~ 1 + remstats::send("z", covar) + remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

## code to prepare `test_constant` dataset
test_constant <- list()
# For loop over datasets
for(i in 1:length(constant)) {
	# Run test for K = 2:10
	test_constant[[i]] <- lapply(2:10, function(K) {
		tryCatch(dyneval(K, tie_effects = formula, edgelist = constant[[i]], 
			covar = covar, directed = TRUE, actors = covar$id), 
			error = function(e) "error")
	})
	cat(paste0("Dataset ", i, " finished."), "\n")
}

usethis::use_data(test_constant)

## code to prepare `test_cyclic` dataset
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

usethis::use_data(test_cyclic)

## code to prepare `test_gradual` dataset
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

usethis::use_data(test_gradual)

## code to prepare `test_mixed` dataset
test_mixed <- list()
# For loop over datasets
for(i in 1:length(mixed)) {
	# Run test for K = 2:10
	test_mixed[[i]] <- lapply(2:10, function(K) {
		tryCatch(dyneval(K, tie_effects = formula, edgelist = mixed[[i]], 
			covar = covar, directed = TRUE, actors = covar$id), 
			error = function(e) "error")
	})
	cat(paste0("Dataset ", i, " finished."), "\n")
}

usethis::use_data(test_mixed)

## code to prepare `gradual` dataset goes here

# Load parameters
data(param, package = "REHdynamics")

# Load covar
data(covar, package = "REHdynamics")

# Model
formula <- ~ 1 + remstats::send("z", covar) + 
	remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + 
	remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

# Generate data
gradual <- list()

set.seed(27613)
for(r in 1:200) {
	cat(r, "\n")
	data[[r]] <- generate(formula, param$gradual, M = 10000, covar)
}

usethis::use_data(gradual, overwrite = TRUE)

## code to prepare `covar` dataset 
# Generate the actors and their exogenous information for the 
# generated datasets
set.seed(27613)
covar <- data.frame(id = 1:30, time = 0, z = rnorm(n = 30))

usethis::use_data(covar) 

## code to prepare `param` dataset 
param <- list(
	constant = list(
		"baseline" = -8, 
		"z_send"= 0.2, 
		"z_difference" = -0.2, 
		"activity" = 0.1, 
		"inertia" = 0.1, 
		"transitivity" = 0.2
	), 
	cyclic = list(
		"baseline" = function(t) {
			0.5 * sin(((2*pi)/10000)*t) + -8	
		},
		"z_send" = function(t) {
			0.1 * sin(((2*pi)/10000)*t) + 0.2
		},
		"z_difference" = function(t) {
			0.1 * sin(((2*pi)/10000)*t) - 0.2
		},
		"activity" = function(t) {
			0.05 * sin(((2*pi)/10000)*t) + 0.1
		},
		"inertia" = function(t) {
			0.05 * cos(((2*pi)/10000)*t) + 0.1
		},
		"transitivity" = function(t) {
			0.1 * sin(((2*pi)/10000)*t) + 0.2
		}
	),
	gradual = list(
		"baseline" = function(t) {
			1 / (1 + exp(-0.001 * (t - 12500))) - 8.5
		}, 
		"z_send" = function(t) {
			0.2 / (1 + exp(-0.001 * (t - 12500))) + 0.1
		},
		"z_difference" = function(t) {
			0.2 / (1 + exp(-0.001 * (t - 12500))) - 0.3
		},
		"activity" = function(t) {
			0.1 / (1 + exp(-0.001 * (t - 12500))) + 0.05
		},
		"inertia" = function(t) {
			0.1 / (1 + exp(-0.001 * (t - 12500))) + 0.05
		},
		"transitivity" = function(t) {
			0.2 / (1 + exp(-0.001 * (t - 12500))) + 0.1
		}
	), 
	mixed = list(
		"baseline" = function(t) {
			0.5 * sin(((2*pi)/10000)*t) + -8	
		}, 
		"z_send"= 0.2, 
		"z_difference" = -0.2, 
		"activity" = function(t) {
			0.05 * sin(((2*pi)/10000)*t) + 0.1
		},
		"inertia" = function(t) {
			0.1 / (1 + exp(-0.001 * (t - 12500))) + 0.05
		},
		"transitivity" = function(t) {
			0.2 / (1 + exp(-0.001 * (t - 12500))) + 0.1
		}
	))

usethis::use_data(param)

# preparation to generate datasets
# Load package
library(REHdynamics)

# Model
formula <- ~ 1 + remstats::send("z", covar) + 
	remstats::difference("z", covar) + 
	remstats::outdegreeSender(scaling = "std") + 
	remstats::inertia(scaling = "std") + 
	remstats::otp(scaling = "std")

## code to prepare `constant` dataset
# Generate data
constant <- list()

set.seed(27613)
for(r in 1:200) {
	cat(r, "\n")
	data[[r]] <- generate(formula, param$constant, M = 10000, covar)
}

usethis::use_data(constant)

# Generate data
cyclic <- list()

set.seed(27613)
for(r in 1:200) {
	cat(r, "\n")
	data[[r]] <- generate(formula, param$cyclic, M = 10000, covar)
}

usethis::use_data(cyclic)

# Generate data
gradual <- list()

set.seed(27613)
for(r in 1:200) {
	cat(r, "\n")
	data[[r]] <- generate(formula, param$gradual, M = 10000, covar)
}

usethis::use_data(gradual)

# Generate data
mixed <- list()

set.seed(27613)
for(r in 1:200) {
	cat(r, "\n")
	data[[r]] <- generate(formula, param$mixed, M = 10000, covar)
}

usethis::use_data(mixed)


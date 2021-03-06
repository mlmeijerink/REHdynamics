# Load package
library(REHdynamics)

# ------------------------------------------------------------------------------
# constant 
# ------------------------------------------------------------------------------

# Maximum timepoint
tau <- max(sapply(constant, function(x) max(x[,1])))

# ------------------------------------------------------------------------------
# constant | t = 4000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(4000, tau)

# Loop over datasets
MW4000_constant <- lapply(1:length(constant), function(r) {
	# Run remify
	rehObject <- remify::reh(constant[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = constant[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW4000_constant)

# ------------------------------------------------------------------------------
# constant | t = 2000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(2000, tau)

# Loop over datasets
MW2000_constant <- lapply(1:length(constant), function(r) {
	# Run remify
	rehObject <- remify::reh(constant[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = constant[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW2000_constant)

# ------------------------------------------------------------------------------
# constant | t = 1000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(1000, tau)

# Loop over datasets
MW1000_constant <- lapply(1:length(constant), function(r) {
	# Run remify
	rehObject <- remify::reh(constant[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = constant[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW1000_constant)

# ------------------------------------------------------------------------------
# cyclic 
# ------------------------------------------------------------------------------

# Maximum timepoint
tau <- max(sapply(cyclic, function(x) max(x[,1])))

# ------------------------------------------------------------------------------
# cyclic | t = 4000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(4000, tau)

# Loop over datasets
MW4000_cyclic <- lapply(1:length(cyclic), function(r) {
	# Run remify
	rehObject <- remify::reh(cyclic[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = cyclic[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW4000_cyclic)

# ------------------------------------------------------------------------------
# cyclic | t = 2000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(2000, tau)

# Loop over datasets
MW2000_cyclic <- lapply(1:length(cyclic), function(r) {
	# Run remify
	rehObject <- remify::reh(cyclic[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = cyclic[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW2000_cyclic)

# ------------------------------------------------------------------------------
# cyclic | t = 1000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(1000, tau)

# Loop over datasets
MW1000_cyclic <- lapply(1:length(cyclic), function(r) {
	# Run remify
	rehObject <- remify::reh(cyclic[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = cyclic[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW1000_cyclic)

# ------------------------------------------------------------------------------
# gradual 
# ------------------------------------------------------------------------------

# Maximum timepoint
tau <- max(sapply(gradual, function(x) max(x[,1])))

# ------------------------------------------------------------------------------
# gradual | t = 4000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(4000, tau)

# Loop over datasets
MW4000_gradual <- lapply(1:length(gradual), function(r) {
	# Run remify
	rehObject <- remify::reh(gradual[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = gradual[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW4000_gradual)

# ------------------------------------------------------------------------------
# gradual | t = 2000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(2000, tau)

# Loop over datasets
MW2000_gradual <- lapply(1:length(gradual), function(r) {
	# Run remify
	rehObject <- remify::reh(gradual[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = gradual[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW2000_gradual)

# ------------------------------------------------------------------------------
# gradual | t = 1000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(1000, tau)

# Loop over datasets
MW1000_gradual <- lapply(1:length(gradual), function(r) {
	# Run remify
	rehObject <- remify::reh(gradual[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = gradual[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW1000_gradual)

# ------------------------------------------------------------------------------
# mixed 
# ------------------------------------------------------------------------------

# Maximum timepoint
tau <- max(sapply(mixed, function(x) max(x[,1])))

# ------------------------------------------------------------------------------
# mixed | t = 4000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(4000, tau)

# Loop over datasets
MW4000_mixed <- lapply(1:length(mixed), function(r) {
	# Run remify
	rehObject <- remify::reh(mixed[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = mixed[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW4000_mixed)

# ------------------------------------------------------------------------------
# mixed | t = 2000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(2000, tau)

# Loop over datasets
MW2000_mixed <- lapply(1:length(mixed), function(r) {
	# Run remify
	rehObject <- remify::reh(mixed[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = mixed[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW2000_mixed)

# ------------------------------------------------------------------------------
# mixed | t = 1000 windows 
# ------------------------------------------------------------------------------
# Windows
windows <- REHdynamics::createwindows(1000, tau)

# Loop over datasets
MW1000_mixed <- lapply(1:length(mixed), function(r) {
	# Run remify
	rehObject <- remify::reh(mixed[[r]], actors = covar$id, directed = TRUE,
		model = "tie", origin = 0)
	rehObject$edgelist[,1] <- cumsum(rehObject$intereventTime)
	
	# Model
	formula <- ~ 1 + remstats::send("z", covar) + 
		remstats::difference("z", covar) + 
		remstats::outdegreeSender(scaling = "std") + 
		remstats::inertia(scaling = "std") + 
		remstats::otp(scaling = "std")
	
	# Run remstats
	statsObject <- remstats::remstats(edgelist = rehObject, tie_effects = formula, 
		actors = covar$id, directed = TRUE)
	
	# Run moving window REM
	REHdynamics::MWrem(windows, edgelist = mixed[[r]], stats = statsObject$statistics,
		actors = covar$id, directed = TRUE, method = "MLE", model = "tie", ncores = 2)
})

usethis::use_data(MW1000_mixed)

## code to prepare `covar` dataset goes here

# Generate the actors and their exogenous information for the 
# generated datasets
set.seed(27613)
covar <- data.frame(id = 1:30, time = 0, z = rnorm(n = 30))

usethis::use_data(covar, overwrite = TRUE)

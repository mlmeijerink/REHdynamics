## code to prepare `attributes` dataset goes here

# Load data
con <- gzcon(url("http://www.sociopatterns.org/wp-content/uploads/2018/12/metadata_InVS15.txt"))
txt <- readLines(con)
meta <- read.csv(textConnection(txt), sep = "\t", header = FALSE)
names(meta) <- c("i", "Di")

# Prepare as attributes object
attributes <- data.frame(
	id = meta$i,
	time = 0,
	department = factor(meta$Di)
)

# Save
usethis::use_data(attributes, overwrite = TRUE)

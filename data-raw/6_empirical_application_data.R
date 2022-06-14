## code to prepare `edges` dataset goes here

# Load data
con <- gzcon(url("http://www.sociopatterns.org/wp-content/uploads/2018/12/tij_InVS15.dat_.gz"))
txt <- readLines(con)
contacts <- read.csv(textConnection(txt), sep = " ", header = FALSE)
names(contacts) <- c("t", "i", "j")

# Actors
data(attributes)
actors <- sort(attributes$id)

# Undirected contacts: Make sure actors are sorted within rows
contacts[,c(2,3)] <- t(apply(contacts[,c(2,3)], 1, sort))

# Create a riskset
riskset <- data.frame(t(combn(actors, 2)))
names(riskset) <- c("i", "j")

# Match edge ID
contacts$edge <- prodlim::row.match(contacts[,c("i", "j")], riskset)

# Transform edges
onset <- terminus <- vector()
onset_time <- terminus_time <- vector()

for(i in 1:nrow(contacts)) {
	# Did the edge occur in the last 20 seconds? If not, onset = TRUE
	last <- contacts[contacts$t == contacts$t[i]-20, ]
	onset[i] <- ifelse(contacts$edge[i] %in% last$edge, FALSE, TRUE)
	
	# Does the edge occur in the next 20 seconds? If not, terminus = TRUE
	subs <- contacts[contacts$t == contacts$t[i]+20, ]
	terminus[i] <- ifelse(contacts$edge[i] %in% subs$edge, FALSE, TRUE)
}

for(i in 1:nrow(contacts)) {
	if(onset[i]) {
		# Set onset time if onset is true 
		onset_time[i] <- contacts$t[i] - 20
	} else {
		# Determine onset time if onset is false
		onset_time[i] <- contacts$t[max(which(contacts$t < contacts$t[i] & 
				contacts$edge == contacts$edge[i] & onset))] - 20
	}
	
	if(terminus[i]) {
		# Determine terminus time if terminus is true
		terminus_time[i] <- contacts$t[i] 
	} else {
		# Determine terminus time if terminus is false
		terminus_time[i] <- contacts$t[min(which(contacts$t > contacts$t[i] & 
				contacts$edge == contacts$edge[i] & terminus))] 
	}
}

contacts$onset <- onset
contacts$terminus <- terminus
contacts$onset_time <- onset_time	
contacts$terminus_time <- terminus_time
contacts$duration <- contacts$terminus_time - contacts$onset_time

# Collect in a relational event history
edges <- contacts[contacts$onset==TRUE, 
	c("t", "i", "j", "duration")]
rownames(edges) <- NULL
names(edges) <- c("time", "actor1", "actor2", "duration")
hist(edges$duration)

# Artificial Date-Time (start on ``a'' Monday in January, here set to the 
# first Monday) 
edges$date <- as.POSIXct(edges$time, origin = "2015-01-04 23:00:00", 
	tz = "Europe/Paris")

# Adapt inter-event time to remove idle periods from the data
days <- unique(lubridate::day(edges$date))
dates <- c(
	as.POSIXct("2015-01-06 08:00:00"),
	as.POSIXct("2015-01-07 08:00:00"),
	as.POSIXct("2015-01-08 08:00:00"),
	as.POSIXct("2015-01-09 08:00:00"),
	as.POSIXct("2015-01-12 08:00:00"),
	as.POSIXct("2015-01-13 08:00:00"),
	as.POSIXct("2015-01-14 08:00:00"),
	as.POSIXct("2015-01-15 08:00:00"),
	as.POSIXct("2015-01-16 08:00:00")
)
edges$rtime <- edges$date - as.POSIXct("2015-01-05 08:00:00")
for(d in 1:(length(days)-1)) {
	# Day starts at eight
	aftereight <- edges$date[min(which(day(edges$date) == days[d + 1]))] -
		dates[d]
	# Day ends after the last event
	lastevent <- edges$rtime[max(which(day(edges$date) == days[d]))]
	# Difference
	subtract <- edges$rtime[min(which(day(edges$date) == days[d + 1]))] -
		lastevent - aftereight
	# Adapt
	edges$rtime[day(edges$date) > days[d]] <- 
		edges$rtime[day(edges$date) > days[d]] - subtract
}

edges$rtime <- as.numeric(edges$rtime)  

# Rearrange columns
edges <- edges[,c("rtime", "actor1", "actor2", "duration", "date")]
colnames(edges)[1] <- "time"

# Timing between edges
prep <- remify::reh(edgelist = edges, actors = attributes$id, directed = FALSE,
	origin = 0, model = "tie")
1
edges$time <- cumsum(prep$intereventTime)

# Save 
usethis::use_data(edges )

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
usethis::use_data(attributes )


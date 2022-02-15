## code to prepare `param` dataset goes here

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

usethis::use_data(param, overwrite = TRUE)

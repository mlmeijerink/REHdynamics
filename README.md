# `REHdynamics`: Functions, (generated) data and results for "Dynamic relational event modeling: Testing, exploring and applying"

Information on the different steps and files to reproduce the results for 
the paper "Dynamic relational event modeling: Testing, exploring and applying"
follows below. 

These instructions assume that, if you are using Windows, that 
[Rtools](https://cran.r-project.org/bin/windows/Rtools/) is installed. 

## Get started
Install the needed packages:
`install.packages("devtools")`
`devtools::install_version("mvtnorm", version = "1.1-3", repos = "http://cran.us.r-project.org")`
`devtools::install_github("TilburgNetworkGroup/remify@1a165e99a0ad784ead08974da86fb2a319f537dc")`
`devtools::install_github("TilburgNetworkGroup/remstats@c6ef7c41c6b43891f760d2db7ad390e8035b83dc")`
`devtools::install_github("TilburgNetworkGroup/remstimate@5ba940645929c4d9d84a4cf16fab68f8971a1a19")`

Download and install the REHdynamics package with the following line:
`devtools::install_github("mlmeijerink/REHdynamics")`.

OR 

Download all the files in a zip folder and open the R project file
`REHdynamics.Rproj`. Then build the package using `devtools::build()`. 

## Data generation 
Four times 200 relational event histories (REHs) of length 10000 events are 
generated in four different time-varying effect scenarios. The script for
generating the data is avaiable in the "data-raw" folder: To reproduce, run
data-raw/1_data_generation.R. 

The following data objects are generated: 
- `covar`: The same set of 30 actors interact in each generated REH. For these 
actors a value on the attribute "z" is available, which is sampled from the 
standard normal distribution. 
- `param`: Six effects govern the generated REHs: a baseline effect, a sender 
effect of attribute "z", a difference effect of attribute "z", an "activity" 
effect - outdegree of the sender, an "inertia" effect, and a "transitivity" 
effect - outgoing twopaths. How these effects influence the generated REHs 
depend on the time-varying scenario. 
- REH data is generated generated using the `generate()` function. The 200 
generated REH data for the constant, cyclic, gradual and mixed time-varying
network effects scenarios are available in the `constant`, `cyclic`, `gradual`,
and `mixed` data objects, respectively. 

## Testing for time-varying effects
We test for time-varying network effects in all generated REH data. For this, 
we apply the Bayesian procedure proposed in the article, with K = 2 - 10. The 
test for time-varying network effects is performed using the function 
`dyneval()`. The script for testing for time-varying effects is avaiable in the "data-raw" 
folder: To reproduce, run data-raw/2_test_for_timevarying_effects.R.  The results 
are available in the data objects `test_constant`, `test_cyclic`, `test_gradual` 
and `test_mixed`. 

## 'Static' REM
We fit a 'static' REM to all generated relational event histories. The script for 
fitting the static REM is avaiable in the "data-raw" folder: To reproduce, 
run data-raw/3_static_fit.R. The results are available in the data objects
`static_constant`, `static_cyclic`, `static_gradual`, and `static_mixed`.

## Moving window REM 
We fit a moving window REM with fixed windows of length 4000, 2000, and 1000 to
all generated relational event histories. To fit a moving window REM we use the
function `MWrem()`. This functions requires a `windows` object as input, these
are created with the function `createwindows()`. The script for fitting the 
moving window REM is avaiable in the "data-raw" folder: To reproduce, 
run data-raw/4_moving_window_fit.R. Results are available in the data 
objects `MW4000_constant`, `MW2000_constant`, `MW1000_constant`, 
`MW4000_cyclic`, `MW2000_cyclic`, `MW1000_cyclic`, 
`MW4000_gradual`, `MW2000_gradual`, `MW1000_gradual`, 
`MW4000_mixed`, `MW2000_mixed`, and `MW1000_mixed`.

## Data-driven moving windows 
The function `ddwindows()` is used to determine, based on the empirical data,
the optimal window width (i.e., best balance of fit and complexity) around a 
timepoint t. Subsequently, these window widths are suplied to `MWrem()` to 
obtain the parameter estimates. The script for determining and fitting the 
data-driven moving window REM is avaiable in the "data-raw" folder: To reproduce, 
run data-raw/5_data_driven_moving_windows.R. Results are available in the data 
objects `ddwindows_constant`, `ddwindows_cyclic`, `ddwindows_gradual`, 
`ddwindows_mixed`, `ddfit_constant`, `ddfit_cyclic`, `ddfit_gradual`, and 
`ddfit_mixed`.

## Empirical application
The methods that are described in the article are applied to an 
empirical dataset. The data consists of 33751 relational events between 232 
actors and is available in the `edges` data object. The events in the 
sequence refer to face-to-face contacts between employees of an organization, 
detected by wearable sensors 
(see [sociopatterns.org](http://www.sociopatterns.org/)). The actors are 
distributed over a number of departments. This information is available in the 
`attributes` data object. The script to prepare the `edges` and `attributes` 
data objects is available in the data-raw folder. To reproduce, 
run data-raw/6_empirical_application_data.R.

First, we perform a test for dynamic effects, results are available in the 
`example_test` data object. Second, we perform a moving window REM with fixed 
window widths of 2 hour, 6 hour and 12 hour windows. Results are available in 
the `example_MW2`, `example_MW6`, and `example_MW12` data objects. Finally, we 
apply the algorithm for data-driven window widths and fit a moving window REM 
with these widths. Results are available in the `example_ddwindows` and 
`example_ddfit` data objects. Scripts for the analyses are available in the
data-raw folder. To reproduce, run data-raw/7_empirical_application_analyses.R.

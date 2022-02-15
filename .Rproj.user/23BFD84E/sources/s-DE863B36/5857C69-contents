# `REHdynamics`: Functions, (generated) data and results for "Dynamic relational event modeling: Testing, exploring and applying"

## Data generation 
Four times 200 relational event histories (REHs) of length 10000 events are 
generated in four different time-varying effect scenarios. 

The same set of 30 actors interact in each generated REH. For these actors a 
value on the attribute "z" is available, which is sampled from the standard 
normal distribution (see the script for generating the `covar` data in the 
data-raw folder). 

Six effects govern the generated REHs: a baseline effect, a sender effect of 
attribute "z", a difference effect of attribute "z", an "activity" effect - 
outdegree of the sender, an "inertia" effect, and a "transitivity" effect - 
outgoing twopaths. How these effects influence the generated REHs depend on the 
time-varying scenario. Parameters are available in the `param` data. 

REH data is generated generated using the `generate()` function. Scripts that 
generated the data are available in the data-raw folder. The 200 generated REH 
data for the constant, cyclic, gradual and mixed time-varying network effects 
scenarios are available in the `constant`, `cyclic`, `gradual`, and `mixed` data 
objects, respectively.

## Testing for time-varying effects
We test for time-varying network effects in all generated REH data. For this, 
we apply the Bayesian procedure proposed in the article, with K = 2 - 10. The 
test for time-varying network effects is performed using the function 
`dyneval()`. See the data-raw folder for the scripts. The results are available 
in the data objects `test_constant`, `test_cyclic`, `test_gradual` and 
`test_mixed`. 

## 'Static' REM
We fit a 'static' REM to all generated relational event histories. See the 
data-raw folder for the scripts. The results are available in the data objects
`static_constant`, `static_cyclic`, `static_gradual`, and `static_mixed`.

## Moving window REM 
We fit a moving window REM with fixed windows of length 4000, 2000, and 1000 to
all generated relational event histories. To fit a moving window REM we use the
function `MWrem()`. This functions requires a `windows` object as input, these
are created with the function `createwindows()`. See the data-raw folder for
the scripts with the moving window REMs. Results are available in the data 
objects `MW4000_constant`, `MW2000_constant`, `MW1000_constant`, 
`MW4000_cyclic`, `MW2000_cyclic`, `MW1000_cyclic`, 
`MW4000_gradual`, `MW2000_gradual`, `MW1000_gradual`, 
`MW4000_mixed`, `MW2000_mixed`, and `MW1000_mixed`.

## Data-driven moving windows 
The function `ddwindows()` is used to determine, based on the empirical data,
the optimal window width (i.e., best balance of fit and complexity) around a 
timepoint t. Subsequently, these window widths are suplied to `MWrem()` to 
obtain the parameter estimates. See the data-raw folder for the scripts. Results
are available in the data objects `ddwindows_constant`, `ddwindows_cyclic`,
`ddwindows_gradual`, `ddwindows_mixed`, `ddfit_constant`, `ddfit_cyclic`,
`ddfit_gradual`, and `ddfit_mixed`.

## Empirical application
The methods that are described in the article are applied to an 
empirical dataset. The data consists of 33751 relational events between 232 
actors and is available in the `edges` data object. The script to prepare
the `edges` object is available in the data-raw folder. The events in the 
sequence refer to face-to-face contacts between employees of an organization, 
detected by wearable sensors 
(see [sociopatterns.org](http://www.sociopatterns.org/)). The actors are 
distributed over a number of departments.This information is available in the 
`attributes` data object. 

First, we perform a test for dynamic effects, results are available in the 
`example_test` data object. Second, we perform a moving window REM with fixed 
window widths of 2 hour, 6 hour and 12 hour windows. Results are available in 
the `example_MW2`, `example_MW6`, and `example_MW12` data objects. Finally, we 
apply the algorithm for data-driven window widths and fit a moving window REM 
with these widths. Results are available in the `example_ddwindows` and 
`example_ddfit` data objects. Scripts for the analyses are available in the
data-raw folder. 

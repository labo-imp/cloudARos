options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

require("bspm")
bspm::disable()
require("pak")

pak::pkg_install( c("mlr3","mlr3mbo","mlr3learners","mlr3tuning","bbotk"))
pak::pkg_install( c("forecast","prophet","sarima","tseries","tsibble","timeSeries"))
pak::pkg_install( c("zoo","xts","dtw","ptw","rucrdtw","IncDTW","twdtw","collapse"))
pak::pkg_install( c("tis","fable","modeltime","modeltime.ensemble","modeltime.resample"))



quit( save="no" )

options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)
options(devtools.install.args = "--no-multiarch")

require("bspm")
bspm::disable()

library("devtools")
pak::pak("lantanacamara/lightgbmExplainer")

quit( save="no" )

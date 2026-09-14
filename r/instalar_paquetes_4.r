options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)
options(devtools.install.args = "--no-multiarch")

require("bspm")
bspm::disable()

install.packages("devtools", INSTALL_opts="--no-multiarch" )
library( "devtools" )
pak::pak("IRkernel/IRkernel")

library( "IRkernel" )
IRkernel::installspec()
quit( save="no" )

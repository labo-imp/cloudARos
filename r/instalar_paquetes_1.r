options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

install.packages( "pak", dependencies= TRUE, INSTALL_opts="--no-multiarch" )
require("pak")

install.packages( "bspm", dependencies= TRUE, INSTALL_opts="--no-multiarch" )
require("bspm")

bspm::disable()
pak::pkg_install( c("data.table", "rpart", "yaml", "httr", "devtools", "yaml", "rlist") )
pak::pkg_install( c("magrittr", "stringi", "curl", "openssl", "roxygen2", "ranger") )
pak::pkg_install( c("dplyr", "caret", "covr", "lintr", "tidyverse", "tidyr", "shiny") )
pak::pkg_install( c("ggplot2", "plotly", "mlflow","markdown") )
pak::pkg_install( c("R.utils","DiceKriging","mlrMBO","primes","mice") )


library( "devtools" )
pak::pkg_install("IRkernel/IRkernel")
pak::pkg_install("krlmlr/ulimit")

quit( save="no" )
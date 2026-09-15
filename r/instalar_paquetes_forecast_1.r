options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

require("bspm")
bspm::disable()
require("pak")


# muy pesados
pak::pkg_install("smooth")
pak::pkg_install("bayesforecast")
pak::pkg_install("bayesdfa")
pak::pkg_install("bayesm")
pak::pkg_install("Rlgt")
pak::pkg_install("bssm")
pak::pkg_install("Boom")
pak::pkg_install("HDTSA")

quit( save="no" )

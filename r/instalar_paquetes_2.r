options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

require("bspm")
bspm::disable()


require("pak")

pak::pkg_install( c("microbenchmark") )
pak::pkg_install( c("Rcpp", "Matrix", "glm2") )
pak::pkg_install( c("ROCR", "MASS", "synchronicity") )
pak::pkg_install( c("rsvg", "DiagrammeRsvg", "DiagrammeR", "modules") )

pak::pkg_install( c("DiceKriging",  "mlrMBO") )
pak::pkg_install( c("rpart", "rpart.plot", "randomForest", "mice") )
pak::pkg_install( c("languageserver", "quantreg") )
pak::pkg_install( c("shapr", "mlflow", "visNetwork") )
pak::pkg_install( c("iml","primes","RhpcBLASctl") )
pak::pkg_install( c("mlr3","mlr3mbo","mlr3learners","paradox","mlr3tuning","bbotk","treeClust") )
pak::pkg_install( c("h2o","agua","automl","emoa","mco") )
pak::pkg_install( c("DBI","RMariaDB","filelock","lime") )

pak::pkg_install( c("fru"))
pak::pkg_install( c("Boruta"))
pak::pkg_install( c("MLmetrics"))

library( "devtools" )
pak::pkg_install("tibble")
pak::pkg_install("AppliedDataSciencePartners/xgboostExplainer")

pak::pkg_install( c("purrr","ps","diffobj","pkgbuild","fs","sass","mime","commonmark","tinytex"))
pak::pkg_install("NorskRegnesentral/shapr")

pak::pkg_install("catboost/catboost/catboost/R-package")

pak::pkg_install("ManuelHentschel/vscDebugger")

pak::pkg_install("ja-thomas/autoxgboost")

Sys.setenv(NOT_CRAN = "true")
install.packages("polars", repos = "https://community.r-multiverse.org")


# devtools::install_github("AnotherSamWilson/ParBayesianOptimization")
# pak::pkg_install("liuyanguu/SHAPforxgboost")

quit( save="no" )

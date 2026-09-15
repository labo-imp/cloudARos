options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

require("bspm")
bspm::disable()
require("pak")



pak::pkg_install( c("legion","MAPA","forecTheta","gsarima"))
pak::pkg_install( c("partsm","pcts","TSLSTM","TSdeeplearning","TSANN","feasts"))
pak::pak( c("DavisVaughan/almanac")) 


quit( save="no" )

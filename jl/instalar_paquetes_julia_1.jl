using Pkg

Pkg.gc()

Pkg.add("Random")

Pkg.gc()
Pkg.add("CSV")
Pkg.add("DataFrames")
Pkg.add("DataTables")
Pkg.add("Distributions")
Pkg.add("PooledArrays")

Pkg.gc()
Pkg.add("XGBoost")
Pkg.add("DecisionTree")
Pkg.gc()
Pkg.add("LightGBM")

Pkg.gc()
Pkg.add("ROCAnalysis")
Pkg.add("BayesianOptimization")

Pkg.gc()
Pkg.add("GaussianProcesses")
Pkg.add("Distributions")

Pkg.gc()
Pkg.add("MLFlowLogger")
Pkg.add("MLFlowClient")
Pkg.add("DuckDB")

Pkg.gc()
Pkg.add("Plots")

Pkg.gc()
Pkg.add("StatsPlots")

Pkg.gc()
Pkg.add("StatsBase")

Pkg.gc()
Pkg.add("Statistics")

Pkg.gc()
Pkg.add("TimeSeries")

# Pkg.gc()
# Pkg.add("Forecast")

Pkg.update()
Pkg.gc()
Pkg.add("MLJBase")
Pkg.add("StatsModels")

Pkg.gc()
Pkg.add("GLM")

Pkg.gc()
Pkg.add("StateSpaceModels")
Pkg.add("PyCall")

Pkg.gc()
Pkg.add("DataFramesMeta")

#Pkg.gc()
#Pkg.add(name="Flux")

Pkg.gc()
Pkg.add("Convex")
Pkg.add("ECOS")

Pkg.gc()
Pkg.add("DelimitedFiles")
Pkg.add("MessyTimeSeries")
Pkg.add("TSML")

Pkg.gc()
Pkg.add("HTTP")

Pkg.gc()
Pkg.add("SciMLBase")

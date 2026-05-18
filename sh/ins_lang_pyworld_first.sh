#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_pyworld_first.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


# Instalo Python SIN  Anaconda, Miniconda, etc-------------------------------
# Documentacion  https://docs.python-guide.org/starting/install3/linux/

# instalacion  uv
curl -LsSf https://astral.sh/uv/install.sh | sh

export PATH="$PATH:/home/$USER/.local/bin"
echo  "export PATH=/home/\$USER/.local/bin:\$PATH"  >>  /home/"$USER"/.bashrc
chmod u+x /home/"$USER"/.bashrc
source /home/"$USER"/.bashrc 


sudo  apt-get update

#--------------------------------------
# Python 3.11
uv python install --reinstall 3.11
uv venv  .venv311 --python 3.11

# activo python 3.11
source /home/"$USER"/.venv311/bin/activate

/home/"$USER"/.local/bin/uv cache clean
/home/"$USER"/.local/bin/uv pip install --upgrade pip
uv pip install setuptools

# Pycaret en  Python 3.11
uv pip install  pycaret[full]

# instalo  datatable desde su repo   en  Python  3.11
uv pip install  datatable

uv pip install  dask dask-expr
uv pip install  HyperOpt lime tpot mlflow ipywidgets

uv pip install  \
  Pandas  Scikit-learn  Statsmodels  \
  Numpy  Matplotlib  fastparquet  \
  pyarrow  tables  plotly  seaborn xlrd \
  scrapy  SciPy  wheel  testresources \
  Requests  Selenium  PyTest  Unit  \
  numba  polars  Flask  h2o  flaml  \
  kaggle  zulip  pika  gdown kaleido  \
  imbalanced-learn  scikit-optimize  \
  pydbus shap  umap-learn lime tpot  \
  dask HyperOpt  mlflow  ipywidgets \
  dask-expr Boruta  \
  duckdb  jupysql  duckdb-engine  \
  XGBoost  LightGBM  CatBoost optuna \
  Keras tensorflow
  
uv  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu   

uv pip install autogluon --extra-index-url https://download.pytorch.org/whl/cpu --index-strategy unsafe-best-match

/home/"$USER"/.local/bin/uv pip install  \
  HistGradientBoosting  PyCaret  AutoViz  pytimetk

/home/"$USER"/.local/bin/uv pip install  \
  AutoViz  pytimetk


# instalo  auto-sklearn   en  Python  3.11
# pip3 install numpy scipy scikit-learn pandas dask distributed joblib psutil lockfile
# pip install pyrfr


# desactivo Python 3.11
deactivate


#--------------------------------------
# Python 3.12
uv python install --reinstall 3.12
uv venv  .venv312 --python 3.12

# activo python 3.12
source /home/"$USER"/.venv312/bin/activate

/home/"$USER"/.local/bin/uv cache clean
uv pip install --upgrade pip
uv pip install setuptools

# instalo AutoGluon en  Python  3.12
uv pip install -U setuptools wheel
pip install uv

# Pycaret en  Python 3.12
uv pip install  pycaret[full]

# instalo  datatable desde su repo   en  Python  3.12
uv pip install  datatable

uv pip install  dask dask-expr
uv pip install  HyperOpt lime tpot mlflow ipywidgets

uv pip install  \
  Pandas  Scikit-learn  Statsmodels  \
  Numpy  Matplotlib  fastparquet  \
  pyarrow  tables  plotly  seaborn xlrd \
  scrapy  SciPy  wheel  testresources \
  Requests  Selenium  PyTest  Unit  \
  numba  polars  Flask  h2o  flaml  \
  kaggle  zulip  pika  gdown kaleido  \
  imbalanced-learn  scikit-optimize  \
  pydbus shap  umap-learn lime tpot  \
  dask HyperOpt  mlflow  ipywidgets \
  dask-expr Boruta  \
  duckdb  jupysql  duckdb-engine  \
  XGBoost  LightGBM  CatBoost optuna \
  Keras 
  
uv  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu   

python -m uv pip install autogluon --extra-index-url https://download.pytorch.org/whl/cpu --index-strategy unsafe-best-match


uv pip install  dask dask-expr
uv pip install  HyperOpt lime tpot mlflow ipywidgets

uv pip install  tensorflow  Keras

# Problematicos en 3.14
/home/"$USER"/.local/bin/uv pip install  \
  htmlmin statsforecast  flood-forecast

/home/"$USER"/.local/bin/uv pip install  \
  AutoViz  pytimetk


# desactivo Python 3.12
deactivate

#--------------------------------------
# Python 3.14.4  2026-04-08

#sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes install \
#        python3.13 python3-pip  python3-dev  ipython3  python3.12-venv


uv venv  .venv --python 3.14

# activo python 3.14
source /home/"$USER"/.venv/bin/activate


# actualizo  pip
/home/"$USER"/.local/bin/uv cache clean
uv pip install --upgrade pip
uv pip install setuptools
uv pip install -U setuptools wheel

uv pip install  dask dask-expr
uv pip install  HyperOpt lime tpot mlflow ipywidgets

fmach_bitacora   "Python"

# instalo paquetes iniciales de Python
uv pip install  kaggle  zulip


uv pip install  dask dask-expr
uv pip install  HyperOpt lime tpot mlflow ipywidgets

uv pip install  \
  Pandas  Scikit-learn  Statsmodels  \
  Numpy  Matplotlib  fastparquet  \
  pyarrow  tables  plotly  seaborn xlrd \
  scrapy  SciPy  wheel  testresources \
  Requests  Selenium  PyTest  Unit  \
  numba  polars  Flask  h2o  flaml  \
  kaggle  zulip  pika  gdown kaleido  \
  imbalanced-learn  scikit-optimize  \
  pydbus shap  umap-learn lime tpot  \
  dask HyperOpt  mlflow  ipywidgets \
  dask-expr Boruta  \
  duckdb  jupysql  duckdb-engine  \
  XGBoost  LightGBM  CatBoost optuna \
  Keras
  
uv  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu   

python -m uv pip install autogluon --extra-index-url https://download.pytorch.org/whl/cpu --index-strategy unsafe-best-match


uv pip install  dask dask-expr
uv pip install  HyperOpt lime tpot mlflow ipywidgets


#--------------------------------------

fmach_bitacora   "python packages"
fmach_registrar_instalacion $logito
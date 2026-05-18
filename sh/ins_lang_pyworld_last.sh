#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_pyworld_last.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_lang_pyworld_first.txt


# Instalo Python SIN  Anaconda, Miniconda, etc-------------------------------
# Documentacion  https://docs.python-guide.org/starting/install3/linux/


source  /home/"$USER"/.venv/bin/activate
/home/"$USER"/.local/bin/uv cache clean

# instalo paquetes de Python
/home/"$USER"/.local/bin/uv pip install  \
    Pandas  Scikit-learn  Statsmodels       \
    Numpy  Matplotlib  fastparquet          \
    pyarrow  tables  plotly  seaborn xlrd   \
    scrapy  SciPy  wheel  testresources     \
    Requests  Selenium  PyTest  Unit        \
    numba  polars  Flask 


/home/"$USER"/.local/bin/uv pip install  duckdb  jupysql  duckdb-engine

/home/"$USER"/.local/bin/uv pip install  XGBoost  LightGBM  CatBoost optuna

/home/"$USER"/.local/bin/uv pip install  Boruta

# AutoML varios
/home/"$USER"/.local/bin/uv pip install  h2o
/home/"$USER"/.local/bin/uv pip install  flaml

/home/"$USER"/.local/bin/uv pip install --no-deps  evalml

# Keras
/home/"$USER"/.local/bin/uv pip install  Keras

# librerias puntuales
/home/"$USER"/.local/bin/uv pip install  kaggle  zulip  pika  gdown
/home/"$USER"/.local/bin/uv pip install  black[jupyter] category-encoders colorama featuretools holidays

/home/"$USER"/.local/bin/uv pip install imbalanced-learn  kaleido scikit-optimize 

/home/"$USER"/.local/bin/uv pip install ipywidgets  nlp-primitives pmdarima scikit-optimize --no-build-isolation --index-strategy unsafe-best-match


/home/"$USER"/.local/bin/uv pip install  shap sktime texttable tomli woodwork[dask]
/home/"$USER"/.local/bin/uv pip install  nbconvert[webpdf]
/home/"$USER"/.local/bin/uv pip install  nb_pdf_template


/home/"$USER"/.local/bin/uv pip install  pydbus

/home/"$USER"/.local/bin/uv pip install  shap
/home/"$USER"/.local/bin/uv pip install  umap-learn

/home/"$USER"/.local/bin/uv pip install  dask HyperOpt lime tpot  mlflow  ipywidgets  dask-expr

# Forecasting
/home/"$USER"/.local/bin/uv pip install  \
  prophet  meson  flux  AutoTS  pmdarima statsmodels  \
  Tsfresh Darts Flint Arrow Orbit Pastas  \
  skforecast Auto_TS neuralprophet  tslearn PyTS  \
  DTW-Python dtaidistance FastDTW zstd  zipp  zict \
  xlrd  xarray  workalendar  widgetsnbextension  webencodings  \
  wcwidth visions  vc  urllib3  unicodedata2  \
  typing_extensions  tsfresh  traitlets  \
  tqdm  tornado  toolz  tk  threadpoolctl  \
  testpath  terminado  tenacity tblib tbb  \
  tangled  stumpy  sortedcontainers skyfield-data  skyfield  \
  six  sgp4  seaborn-base requests  qtpy  \
  pyzmq  pyyaml  pytz  pysocks  pyrsistent  pyqtwebengine  \
  pyqtchart  pyparsing  pyopenssl  pymeeus pyluach  \
  pygments  pydantic  pycparser pyaml  psutil  protobuf  \
  prompt_toolkit prometheus_client  plotly  pillow  \
  pickleshare  phik  patsy  partd  parso  \
  pandocfilters  pandoc  packaging openpyxl  olefile  \
  markupsafe  matplotlib  matplotlib-inline  \
  missingno  mistune  mkl  msgpack-python  multimethod  munkres  \
  nbclient  nbconvert  nbformat  nest-asyncio  \
  netcdf4  networkx  notebook libpython  libsodium 


/home/"$USER"/.local/bin/uv pip install  \
  llvmlite locket lunarcalendar  lunardate  \
  argon2-cffi  argon2-cffi-bindings  \
  arviz  async_generator  attrs  backcall  \
  bleach  bokeh  brotli  brotlipy  certifi  \
  cffi cftime  charset-normalizer  chart-studio  \
  click  cloudpickle  colorama  colorlover  convertdate  \
  cryptography  cycler  cython  cytoolz  daal4py  \
  debugpy  decorator  defusedxml  distributed  \
  entrypoints  ephem  et_xmlfile  flit-core  \
  fonttools  freezegun  fsspec  hcrystalball  \
  heapdict  hijri-converter  icu  idna  imagehash  \
  importlib-metadata  importlib_metadata  importlib_resources  \
  jedi  jinja2  joblib  jplephem  jsonschema  \
  kiwisolver  lerc  libclang  liblapack  \
  libnetcdf  yfinance alpha-vantage  Tsfresh


/home/"$USER"/.local/bin/uv pip install  \
  arch  hardPredictions  skforecast  scipy   mlxtend \
  scikit-learn

/home/"$USER"/.local/bin/uv pip install  \
  skforecast  Darts  NeuralProphet  Prophet  Nixtla \
  Keras  Chronos  TimeGPT

/home/"$USER"/.local/bin/uv pip install  \
  AutoTS  Sweetviz  tsfresh
  
/home/"$USER"/.local/bin/uv pip install  \
  yfinance  pandas_market_calendars  \
  pandas-datareader  alpha_vantage


/home/"$USER"/.local/bin/uv pip install  --upgrade holidays

fmach_bitacora   "python packages final"
fmach_registrar_instalacion $logito
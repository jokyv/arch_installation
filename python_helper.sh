#!/bin/bash

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

# install all python packages using pip
pip_packages = (
black
ipython
jedi
matplotlib
matplotlib-inline
numpy
seaborn
pandas
pyright
requests
scikit-learn
scipy
tqdm
polars
ruff
ruff-lsp
mysql-connector-python
)

# install packages only on user level
pip install --user $pip_packages

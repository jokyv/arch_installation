#!/bin/bash

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

# install all python packages using pip
pip_packages = (
ipython
matplotlib
matplotlib-inline
numpy
seaborn
pandas
requests
scikit-learn
scipy
tqdm
mysql-connector-python
polars
# use pylsp together with ruff and black
python-lsp-server
python-lsp-ruff
python-lsp-black
ruff
ruff-lsp
black
pyright
jedi
)

# install packages only on user level
pip install --user $pip_packages

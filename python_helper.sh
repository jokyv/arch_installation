#!/bin/bash

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

# install all python packages using pip
pip_packages = (
black
flake8
ipython
jedi
matplotlib
matplotlib-inline
numpy
pandas
pyright
requests
scikit-learn
scipy
tqdm
polars
ruff
ruff-lsp
)

# install packages only on user level
pip install --user $pip_packages

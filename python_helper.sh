#!/bin/bash

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

pip_packages=(
  # data analysis libraries
  ipython
  polars
  pandas
  pyarrow
  numpy
  scikit-learn
  scipy

  # plotting libraries
  matplotlib
  matplotlib-inline
  seaborn

  # IDE libraries
  # use pylsp together with ruff and black
  python-lsp-server
  python-lsp-ruff
  python-lsp-black
  ruff
  ruff-lsp
  black
  pyright
  jedi

  # misc libraries
  requests
  tqdm
  mysql-connector-python
  # financetoolkit
)

install_pyenv() {
  # reference: https://pyenv.run/    
  set -e
  curl -s -S -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
}


# install packages only on user level
install_packages() {
  for pip_package in ${pip_packages[@]}; do
    echo ""
    echo "::checking package $pip_package"
    echo ""
    pip install --user $pip_package
  done
}

main() {
  install_pyenv
  install_packages
}

main
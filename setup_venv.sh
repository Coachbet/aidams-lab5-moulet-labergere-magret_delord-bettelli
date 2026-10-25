#!/usr/bin/env bash
# Creates the virtual environment for Lab 5 and registers a Jupyter kernel.
# Usage (from this folder):  bash setup_venv.sh
set -euo pipefail
cd "$(dirname "$0")"

python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m ipykernel install --user --name lab5 --display-name "Python (lab5)"

echo
echo "Done. Activate with:  source .venv/bin/activate"
echo "Then open the notebook with:  jupyter lab labs/lab5.ipynb  (kernel: Python (lab5))"

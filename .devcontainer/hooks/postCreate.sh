#!/bin/sh
sudo rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' | sudo tee /etc/apt/apt.conf.d/keep-cache

sudo chown -R vscode:vscode /home/vscode/.cache

poetry config virtualenvs.in-project true
poetry config virtualenvs.prompt venv
poetry install
poetry completions bash >> ~/.bash_completion

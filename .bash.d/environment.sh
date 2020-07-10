#!/usr/bin/env bash

export PATH=${HOME}/.pyenv/bin:${HOME}/.local/bin:${PATH}

# pyenv initialization, see https://github.com/pyenv/pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
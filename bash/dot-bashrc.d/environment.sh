#!/usr/bin/env bash

export PATH=${HOME}/.local/bin:${PATH}

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,.local
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

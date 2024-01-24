#!/bin/bash

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"


   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
  local option=$1
  local value=$2
  tmux set-option -gq "$option" "$value"
}

setw() {
  local option=$1
  local value=$2
  tmux set-window-option -gq "$option" "$value"
}


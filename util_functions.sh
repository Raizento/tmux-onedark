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

add_widget() {
    local widgets=$1
    local widget=$2
    local delimiter=$3
    local option_value=$(get "$widgets")

    if [ -z "$option_value" ]; then
        set "$widgets" "#[fg=$onedark_white,bg=$onedark_widget_grey] $widget"
    else
      tmux set-option -gaq "$widgets" " $delimiter #[fg=$onedark_white,bg=$onedark_widget_grey]$widget"
    fi
}

add_widget_left() {
    local widget=1

    add_widget @onedark_status_left_widgets "$widget" ""
}

add_widget_right() {
    local widget=$1

    add_widget @onedark_status_right_widgets "$widget" ""
}

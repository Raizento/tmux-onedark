#!/bin/bash
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get() {
  local option value default
  option="$1"
  default="$2"
  value=$(tmux show-option -gqv "$option")

  if [ -n "$value" ]
  then
    if [ "$value" = "null" ]
    then
      echo ""

    else
      echo "$value"
    fi

  else
    echo "$default"

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

theme=$(get @onedark_theme "dark")

source "${PLUGIN_DIR}/themes/onedark-${theme}.tmux"

onedark_accent=$(get @onedark_accent)
onedark_black=$(get @onedark_black)
onedark_blue=$(get @onedark_blue)
onedark_yellow=$(get @onedark_yellow)
onedark_red=$(get @onedark_red)
onedark_white=$(get @onedark_white)
onedark_visual_grey=$(get @onedark_visual_grey)
onedark_comment_grey=$(get @onedark_comment_grey)

set status "on"

set status-justify $(get @onedark_justify "left")

set status-left-length "100"
set status-right-length "100"

setw window-status-fg "$onedark_black"
setw window-status-bg "$onedark_black"

setw window-status-activity-bg "$onedark_black"
setw window-status-activity-fg "$onedark_black"

setw window-status-separator ""

set window-style-fg "$onedark_comment_grey"
set window-active-style-fg "$onedark_white"

set pane-border-fg "$onedark_white"
set pane-border-bg "$onedark_black"
set pane-active-border-fg "$onedark_accent"
set pane-active-border-bg "$onedark_black"

set display-panes-active-colour "$onedark_yellow"
set display-panes-colour "$onedark_blue"

set status-bg "$onedark_black"
set status-fg "$onedark_white"

status_widgets=$(get "@onedark_widgets", (time))

session_color="#{?client_prefix,$onedark_red,$onedark_green}"
set "status-left" "#[fg=$onedark_black,bg=$session_color,bold] #S #[fg=$session_color,bg=$onedark_black,nobold,nounderscore,noitalics]"
set status-right "#I"
#     

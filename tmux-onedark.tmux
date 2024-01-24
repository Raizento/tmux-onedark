#!/bin/bash
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

add() {
  local option=$1
  local value=$2
  local delimiter=$3
  local option_value=$(get "$option")
  if [ -z "$option_value" ]; then
    set "$option" "$value"
  else 
    tmux display-message "hallo"
    tmux set-option -gaq "$option" " $delimiter $value"
  fi
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
onedark_widget_grey=$(get @onedark_widget_grey)

date_format=$(get @onedark_date_format "%d/%m/%y")
time_format=$(get @onedark_date_format "%H:%M")

onedark_zoomed_window_symbol=$(get @onedark_zoomed_window_symbol "(Z)")
onedark_last_window_symbol=$(get @onedark_zoomed_window_symbol "(L)")
onedark_marked_pane_window_symbol=$(get @onedark_marked_pane_window_symbol "(M)")

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

# change color when prefix key is pressed
session_color="#{?client_prefix,$onedark_red,$onedark_accent}"

set @status_left_widgets ""
add @status_left_widgets "#[fg=$onedark_black,bg=$session_color,bold] #S"
status_left_widgets=$(get @status_left_widgets)
status_left_end="#[fg=$session_color,bg=$onedark_black,nobold,nounderscore,noitalics]"
set status-left "${status_left_widgets} ${status_left_end}"

set @status_right_widgets ""
add @status_right_widgets "#[fg=$onedark_white,bg=$onedark_widget_grey] ${time_format}" ""
add @status_right_widgets "#[fg=$onedark_white,bg=$onedark_widget_grey]${date_format}" ""
status_right_begin="#[fg=$onedark_visual_grey,bg=$onedark_black]"
status_right_widgets=$(get @status_right_widgets)
set status-right "${status_right_begin}${status_right_widgets} #[fg=$onedark_accent,bg=$onedark_visual_grey]#[fg=$onedark_black,bg=$onedark_accent,bold] #H "


window_name="#W#{?window_last_flag,$onedark_last_window_symbol,}#{?window_marked_flag,$onedark_marked_pane_window_symbol,}#{?window_zoomed_flag,$onedark_zoomed_window_symbol,}"

set window-status-format "#[fg=$onedark_black,bg=$onedark_black] #[fg=$onedark_white,bg=$onedark_black]#I  ${window_name} #[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"
set window-status-current-format "#[fg=$onedark_black,bg=$onedark_visual_grey] #[fg=$onedark_white,bg=$onedark_visual_grey]#I  ${window_name} #[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]"
#     

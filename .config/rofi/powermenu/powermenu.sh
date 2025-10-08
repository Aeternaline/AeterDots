#!/bin/bash

# Define config directory
CONFIG_DIR="$HOME/.config/rofi/powermenu"

# Define options
# Menus
LOCK="󰌾"
SUSPEND="󰏤"
SHUTDOWN="󰐥"
REBOOT="󰜉"
LOGOUT="󰗽"
# Confirmations
YES="󰄬 Yes"
NO="󰅖 No"

# Initialize power menu
power_menu() {
  rofi -dmenu \
    -theme ${CONFIG_DIR}/config.rasi
}

# Initialize confirmation menu
confirmation_menu() {
  rofi -dmenu \
    -mesg "Are you sure?" \
    -theme ${CONFIG_DIR}/confirmation.rasi
}

# Function for launching
launch_power_menu() {
  echo -e "$LOCK\n$SUSPEND\n$SHUTDOWN\n$REBOOT\n$LOGOUT" | power_menu
}

launch_confirmation() {
  echo -e "$YES\n$NO" | confirmation_menu 
}

# Execute command
exec_command() {
  CONFIRMED="$(launch_confirmation)"
  if [[ "$CONFIRMED" == "$YES" ]]; then
    case "$1" in
      "--lock")
        hyprlock
      ;;
      "--suspend")
        systemctl suspend
      ;;
      "--shutdown")
        systemctl poweroff
      ;;
      "--reboot")
        systemctl reboot
      ;;
      "--logout")
        hyprctl dispatch exit 0
      ;;
    esac
  else
    exit 0
  fi
}

# Actions
SELECTED_OPTION="$(launch_power_menu)"
case ${SELECTED_OPTION} in
  $LOCK)
    exec_command --lock
  ;;
  $SUSPEND)
    exec_command --suspend
  ;;
  $SHUTDOWN)
    exec_command --shutdown
  ;;
  $REBOOT)
    exec_command --reboot
  ;;
  $LOGOUT)
    exec_command --logout
  ;;
esac

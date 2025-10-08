#!/bin/bash
cliphist list | rofi -dmenu -p "󰅌" -display-columns 2 -theme ~/.config/rofi/clipboard/config.rasi | cliphist decode | wl-copy

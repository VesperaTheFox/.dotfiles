#!/bin/sh
cd /home/vespera/.dotfiles/home/dotfiles/waybar/scripts
pkill .waybar-wrapped
waybar &

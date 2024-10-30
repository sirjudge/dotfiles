#!/usr/bin/env bash
#BUG: i3lock isn't locking all three monitors

icon="$HOME/Pictures/hypeBeast.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg"  -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock -u -i "$tmpbg"

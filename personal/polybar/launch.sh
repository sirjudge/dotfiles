#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
# for m in $(polybar --list-monitors | cut -d":" -f1); do
#     MONITOR=$m polybar --reload topbar 2>&1 | tee -a /tmp/polybar1.log & disown
# done

# get list of current monitors
MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)
if (echo $MONITORS | grep -q "eDP-1-1"); then
    MONITOR=eDP-1 polybar --reload edp 2>&1 | tee -a /tmp/polybar1.log & disown
fi
if (echo $MONITORS | grep -q "HDMI-0"); then
    MONITOR=eDP-1 polybar --reload hdmi 2>&1 | tee -a /tmp/polybar1.log & disown
fi
if (echo $MONITORS | grep -q "DP-0"); then
    MONITOR=eDP-1 polybar --reload dp 2>&1 | tee -a /tmp/polybar1.log & disown
fi



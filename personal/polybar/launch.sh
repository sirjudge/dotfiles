#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload topbar 2>&1 | tee -a /tmp/polybar1.log & disown
done

echo "Bars launched..."

# Top monitor DP-0.2
# Bottom Monitor DP-0.3
# Laptop Monitor eDP-1-1

# Turn off both external monitors
xrandr --output DP-0.1 --off --verbose
xrandr --output DP-0.2 --off --verbose

# Turn on both external monitors
xrandr --output eDP-1-1 --mode 1920x1080 --rate 144.00 --rotate normal \
    --output DP-0.1 --mode 2560x1080 --right-of eDP-1-1 \
    --output DP-0.2 --mode 2560x1080 --above DP-0.1 --verbose

# sleep for 5 seconds to allow the monitors to turn on
sleep 5

# restore wallpapers
nitrogen --set-zoom-fill ~/Pictures/hypeBeast.png  

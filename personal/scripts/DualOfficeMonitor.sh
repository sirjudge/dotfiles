# Top monitor DP-0.1
# Bottom Monitor DP-0.3

# clear existing monitors
xrandr --output DP-0.3 --off --verbose
xrandr --output DP-0.2 --off --verbose


# Dual office monitor
xrandr --output eDP-1-1 --mode 1920x1080 --rate 144.00 --rotate normal \
--output DP-0.3 --mode 2560x1080 --right-of eDP-1-1 
#--output DP-0.2 --mode 2560x1080 --above DP-0.3 --verbose

# wait for pevious command to finish I guess
sleep 5


# restore nitrogen
nitrogen --restore --sync

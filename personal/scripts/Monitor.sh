
# take in arguments
$action = $1
$setup = $2

# if action not set do nothing
while getopts "a:l:" opt; do
    case $opt in
        a) action="$OPTARG"
        ;;
        l) setup="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" > &2
        ;;
    esac
done
if [ -z "$action" ]; then
    echo "No action set"
    exit location1
fi

# if location not set do nothing
if [ -z "$setup" ]; then
    echo "No location set"
    exit 1
fi

# if action is off disable everything
if [ "$action" == "off" ]; then

    echo "Turn off both external monitors"
    xrandr --output DP-0.1 --off --verbose
    xrandr --output DP-0.2 --off --verbose
fi

# if action is on and location is office
if [ "$action" == "on" ] && [ "$setup" == "officeDouble" ]; then
    # Top monitor DP-0.2
    # Bottom Monitor DP-0.3
    # Laptop Monitor eDP-1-1

    # Turn on both external monitors
    xrandr --output eDP-1-1 --mode 1920x1080 --rate 144.00 --rotate normal \
        --output DP-0.1 --mode 2560x1080 --right-of eDP-1-1 \
        --output DP-0.2 --mode 2560x1080 --above DP-0.1 --verbose
fi

if [ "$action" == "on" ] && [ "$setup" == "officeSingle" ]; then
    xrandr --output eDP-1-1 --primary --auto --output DP-0 --auto --right-of eDP-1-1;
fi

if [ "$action" == "on" ] && [ "$setup" == "bedroom" ]; then
    xrandr --output eDP-1-1 --primary --auto --output HDMI-0 --mode 192-x1080 --right-of eDP-1-1;
fi

# sleep for 5 seconds to allow the monitors to turn on
sleep 5

# restore wallpapers
nitrogen --set-zoom-fill ~/Pictures/hypeBeast.png  

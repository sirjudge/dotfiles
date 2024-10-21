

# declare two variables
action=""
setup=""

# take in two arguments from std in
# a is the action (on or off)
# s is the setup (officeDouble, officeSingle, bedroom)
# h is help
while getopts 'a:s:h' flag; do
    case "${flag}" in
        a) action="${OPTARG}" ;;
        s) setup="${OPTARG}" ;;
        h) echo "Usage: Monitor.sh -a <action> -s <setup>"; exit 1 ;;
    esac
done

# if setup is true move to accept user input
if [ "$setup" = "true" ]; then 
    echo "enabling set up"
    echo "select a room"
    echo "1) Bedroom"
    echo "2) Gaming"
    read room
    case $room in 
        1)
            echo "selected bredroom. Select setup"
        ;; 
        2) 
            echo "selected Gaming. Select setup"
            echo "1) Dual wide"
            echo "2) Gaming"
            read monitorType
            if ["$monitorType" = "1"]; then
                    echo "setting dual wide"

                    xrandr --output eDP-1-1 --mode 1920x1080 --rate 144.00 --rotate normal \
                        --output DP-0.1 --mode 2560x1080 --left-of eDP-1-1 \
                        --output DP-0.2 --mode 2560x1080 --below DP-0.1 --verbose
            exit 1
            elif ["$monitorType" = "2"]; then
                    echo "setting gaming"
                    xrandr --output eDP-1-1 --mode 1920x1080 --rate 144.00 --pos 0x0 --primary \
                        --output DP-0 --mode 2560x1440 --pos 1920x0 \
                        --output HDMI-0 --mode 1920x1080 --rate 239.76 --pos 4480x0 
            fi
            exit 1
            ;;
        *) 
            echo "did not recognize room"       
            exit 1
            ;;
    esac
fi


# if action is off disable everything
if [ "$action" = "off" ]; then
    echo "Turn off both external monitors"
    xrandr --output DP-0.1 --off --verbose
    xrandr --output DP-0.2 --off --verbose
    xrandr --output HDMI-0 --off --verbose
    exit 1
fi

# if action is not off then turn on the respective monitors in the respective
# resolutions
if [ "$action" = "on" ] && [ "$setup" = "officeDouble" ]; then
    xrandr --output eDP-1-1 --mode 1920x1080 --rate 144.00 --rotate normal \
        --output DP-0.1 --mode 2560x1080 --left-of eDP-1-1 \
        --output DP-0.2 --mode 2560x1080 --below DP-0.1 --verbose
elif  [ "$action" = "on" ] && [ "$setup" = "officeGaming" ]; then
    xrandr --output eDP-1-1 --mode 1920x1080 --rate 144.00 --pos 0x0 --primary \
       --output DP-0 --mode 2560x1440 --pos 1920x0 \
       --output HDMI-0 --mode 1920x1080 --rate 239.76 --pos 4480x0 

elif [ "$action" = "on" ] && [ "$setup" = "bedroom" ]; then
    xrandr --output eDP-1-1 --mode 1920x1080 --output HDMI-0 --primary --mode 1920x1080 --right-of eDP-1-1
fi

# sleep for 5 seconds to allow the monitors to turn on
sleep 5

# restore wallpapers
nitrogen --set-zoom-fill ~/Pictures/hypeBeast.png  

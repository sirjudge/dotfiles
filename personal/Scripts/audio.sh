# see if the headset is available as an output device
if pactl list sinks | grep -q "Logitech_PRO_X_Wireless_Gaming_Headset"; then
    echo "Headset is available"
    pactl set-default-sink alsa_output.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.analog-stereo
    exit 0
fi

# default to laptop speakers if no headset is available
if pactl list sinks | grep -q "alsa_output.pci-0000_00_1f.3.analog-stereo"; then
    echo "defaulting to speakers"
    pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
    exit 0
fi






while getopts "biwpU" opt; do
    case $opt in
    b) backup=true ;;
    i) insert=true ;;
    w) work=true ;;
    p) personal=true ;;
    U) workUbuntu=true ;;
    ?)
        echo "Usage: $0 [-b] [-i] [-w] [-p] [-U]"
        exit 1
        ;;
    esac
done

if [ "$backup" = true ]; then
    cp -r ~/.config/ghostty ./
    cp -r ~/.config/niri ./
    cp -r ~/.config/hypr ./
    cp -r ~/.config/quickshell ./
fi
if [ "$insert" = true ]; then
    # shared configs
    cp -r ./nvim ~/.config/
    cp -r ./ghostty ~/.config/
fi

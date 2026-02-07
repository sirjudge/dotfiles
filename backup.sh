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
    # Shared configs
    cp -r ~/.config/nvim ./personal/
    cp -r /etc/nixos ./personal/
    cp -r ~/.config/nixpkgs ./personal/
    cp -r ~/.config/ghostty ./
fi
if [ "$insert" = true ]; then
    # shared configs
    cp -r ./nvim ~/.config/
    cp -r ./ghostty ~/.config/
    cp -r ./personal/nixos /etc/
fi

while getopts "biwp" opt; do
    case $opt in
    b) backup=true ;;
    i) insert=true ;;
    w) work=true ;;
    p) personal=true ;;
    ?)
        echo "Usage: $0 [-b] [-d]"
        exit 1
        ;;
    esac
done

if [ "$backup" = true ]; then
    cp -r ~/.config/nvim ./
    if [ "$personal" = true ]; then
        cp -r /etc/nixos ./personal/.
        cp -r ~/.config/nixpkgs ./personal/.
    elif [ "$work" = true ]; then
        cp -r ~/.zshrc ./work/
    fi
fi

if [ "$insert" = true ]; then
    cp -r ./personal/nvim ~/.config/
    if [ "$personal" = true ]; then
        cp -r ./personal/nixos /etc/
    elif [ "$work" = true ]; then
        cp -r ./work/.zshrc ~/
    fi
fi

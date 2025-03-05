while getopts "biwp" opt; do
    case $opt in
        b) backup=true ;;
        i) insert=true ;;
        w) work=true ;;
        p) personal=true ;;
        ?) echo "Usage: $0 [-b] [-d]"
            exit 1 ;;
    esac
done

if [ "$backup" = true ]; then
    cp -r ~/.config/nvim ./
    if [ "$personal" = true ]; then
        cp -r /etc/nixos ./personal/.
        cp -r ~/.config/home-manager/ ./personal/.
        cp -r ~/.config/nixpkgs ./personal/.
    elif [ "$work" = true ]; then
        sudo cp -r /etc/nixos ./work/.
        sudo cp -r ~/.config/home-manager/ ./work/
        sudo cp -r ~/.config/nixpkgs ./work/
    fi
fi

if [ "$insert" = true ]; then
    if [ "$personal" = true ]; then
        cp -r ./personal/nixos /etc/
        cp -r ./personal/home-manager ~/.config/
        cp -r ./personal/nvim ~/.config/
    elif [ "$work" = true ]; then
        cp -r ./work/nixos /etc/
        cp -r ./work/home-manager ~/.config/
        cp -r ./personal/nvim ~/.config/
    fi
fi


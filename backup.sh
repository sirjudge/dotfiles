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
    # Shared configs
    cp -r ~/.config/nvim ./
    cp -r ~/.config/ghostty ./

    # personal and work setups
    if [ "$personal" = true ]; then
        cp -r /etc/nixos ./personal/.
        cp -r ~/.config/nixpkgs ./personal/.
    elif [ "$work" = true ]; then
        sudo cp -r /etc/nixos ./work/.
        sudo cp -r ~/.config/home-manager/ ./work/
        sudo cp -r ~/.config/nixpkgs ./work/
    fi
fi

if [ "$insert" = true ]; then
    # shared configs
    cp -r ./nvim ~/.config/
    cp -r ./ghostty ~/.config/

    # personal and work setups
    if [ "$personal" = true ]; then
        cp -r ./personal/nixos /etc/
        # cp -r ./personal/home-manager ~/.config/
    elif [ "$work" = true ]; then
        cp -r ./work/nixos /etc/
        cp -r ./work/home-manager ~/.config/
    fi
fi


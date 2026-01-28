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
    cp -r ~/.config/nvim ./

    # personal and work setups
    if [ "$personal" = true ]; then
        cp -r /etc/nixos ./personal/.
        cp -r ~/.config/nixpkgs ./personal/.
        cp -r ~/.config/ghostty ./
    elif [ "$work" = true ]; then
        cp -r ~/.zshrc ./work/
    elif [ "$workUbuntu" = true ]; then
        # Ubuntu configs
        cp -r ~/.zshrc ./work/ubuntu/
        cp -r ~/.config/nvim ./work/ubuntu/
        cp -r ~/.config/tmux ./work/ubuntu/
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
        cp -r ./work/.zshrc ~/
    elif [ "$workUbuntu" = true ]; then
        # Ubuntu configs
        cp -r ./work/ubuntu/.zshrc ~/
        cp -r ./work/ubuntu/nvim ~/.config/
        cp -r ./work/ubuntu/tmux ~/.config/
    fi
fi

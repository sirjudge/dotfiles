while getopts "biwpWU" opt; do
    case $opt in
    b) backup=true ;;
    i) insert=true ;;
    w) work=true ;;
    p) personal=true ;;
    W) workWindows=true ;;
    U) workUbuntu=true ;;
    ?)
        echo "Usage: $0 [-b] [-i] [-w] [-p] [-W] [-U]"
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
        # Windows configs
        cp -r ~/.glzr ./work/windows/
        cp -r ~/AppData/Local/nvim ./work/windows/
    elif [ "$workWindows" = true ]; then
        # Windows configs
        cp -r ~/.glzr ./work/windows/
        cp -r ~/AppData/Local/nvim ./work/windows/
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
        # Windows configs
        cp -r ./work/windows/.glzr ~/
        cp -r ./work/windows/nvim ~/AppData/Local/
    elif [ "$workWindows" = true ]; then
        # Windows configs
        cp -r ./work/windows/.glzr ~/
        cp -r ./work/windows/nvim ~/AppData/Local/
    elif [ "$workUbuntu" = true ]; then
        # Ubuntu configs
        cp -r ./work/ubuntu/.zshrc ~/
        cp -r ./work/ubuntu/nvim ~/.config/
        cp -r ./work/ubuntu/tmux ~/.config/
    fi
fi

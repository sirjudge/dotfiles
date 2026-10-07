while getopts "biwpU" opt; do
    case $opt in
    b) backup=true ;;
    i) insert=true ;;
    w) work=true ;;
    p) personal=true ;;
    c) clean=true ;;
    ?)
        echo "Usage: $0 [-b]ackup [-i]nsert [-w]ork [-p]ersonal [-c]lean"
        exit 1
        ;;
    esac
done

if [ "$backup" = true ]; then
    # folders
    cp -r ~/.config/ghostty ./
    cp -r ~/.config/niri ./
    cp -r ~/.config/hypr ./
    cp -r ~/.config/quickshell ./
    cp -r ~/.config/tmux/tmux.conf ./tmux/tmux.conf
    cp -r ~/.config/scripts ./
    cp -r ~/.config/harper-ls ./
    cp -r ~/.config/fastfetch ./
    
    # individual files
    cp ~/.config/starship.toml ./
    cp ~/.zshrc ./
fi
if [ "$insert" = true ]; then
    cp -r ./nvim ~/.config/
    cp -r ./ghostty ~/.config/
fi

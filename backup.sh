while getopts "bi" opt; do
  case $opt in
    b) backup=true ;;
    i) insert=true ;;
    ?) echo "Usage: $0 [-b] [-d]"
       exit 1 ;;
  esac
done

if [ "$backup" = true ]; then
    cp -r /etc/nixos ./personal/.
    cp -r ~/.config/home-manager/ ./personal/.
    cp -r ~/.config/nixpkgs ./personal/.
    cp -r ~/.config/nvim ./personal/.
fi

if [ "$insert" = true ]; then
  cp -r ./personal/nixos /etc/
  cp -r ./personal/home-manager ~/.config/
  cp -r ./personal/nvim ~/.config/
fi


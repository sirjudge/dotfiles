while getopts "bi" opt; do
  case $opt in
    b) backup=true ;;
    i) insert=true ;;
    ?) echo "Usage: $0 [-b] [-d]"
       exit 1 ;;
  esac
done

if [ "$backup" = true ]; then
    cp -r /etc/nixos .
    cp -r ~/.config/home-manager/ .
    cp -r ~/.config/nixpkgs .
    cp -r ~/.config/nvim .
fi

if [ "$insert" = true ]; then
  cp -r nixos /etc/
  cp -r home-manager ~/.config/
  cp -r nvim ~/.config/
fi


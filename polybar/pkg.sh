pac=$(checkupdates | wc -l)
aur=$(cower -u | wc -l)

echo "  PACMAN: $pac   AUR: $aur "

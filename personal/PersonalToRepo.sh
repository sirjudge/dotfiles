echo "copying neovim config folder and zipping"
if [ -d "/nvim" ]; then
    rm -r nvim
fi
cp ~/.config/nvim .

echo "copying zshrc"
cp ~/.zshrc .

if [ -d "/i3" ]; then
    rm -r i3
fi
cp -r ~/.config/i3 .

if [ -d "/eww" ]; then
    rm -r eww
cp -r ~/.config/eww .

if [ -d "/terminator" ]; then
    rm -r terminator
fi
cp -r ~/.config/terminator .

if [ -d "/rofi" ]; then
    rm -r rofi
fi
cp -r ~/.config/rofi .

if [ -d "/nitrogen" ]; then
    rm -r nitrogen
fi
cp -r ~/.config/nitrogen .


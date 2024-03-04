echo "copying neovim config folder and zipping"
if [ -d "/nvim" ]; then
    rm -r nvim
fi
cp -r ~/.config/nvim .
rm -r nvim/node_modules

echo "copying tmux"
if [ -d "/tmux" ]; then
    rm -r tmux
fi
cp -r ~/.config/tmux .
rm -r tmux/plugins

echo "copying zshrc"
cp ~/.zshrc .

echo "copying i3 and i3status"
if [ -d "/i3" ]; then
    rm -r i3
fi
if [ -d "/i3status" ]; then
    rm -r i3status
fi
cp -r ~/.config/i3 .
cp -r ~/.config/i3status .

echo "copying eww for bar"
if [ -d "/eww" ]; then
    rm -r eww
fi
cp -r ~/.config/eww .

echo "copying terminator files"
if [ -d "/terminator" ]; then
    rm -r terminator
fi
cp -r ~/.config/terminator .

echo "copying rofi"
if [ -d "/rofi" ]; then
    rm -r rofi
fi
cp -r ~/.config/rofi .

echo "copying nitrogen"
if [ -d "/nitrogen" ]; then
    rm -r nitrogen
fi
cp -r ~/.config/nitrogen .

echo "copying fonts"
if [ -d "/.fonts" ]; then
    rm -r polybar
fi
cp -r ~/.fonts .

echo "copying scripts"
if [ -d "/scripts" ]; then
    rm -r scripts
fi
cp -r ~/Tools/scripts .

sudo pacman -Sy jq i3-wm i3status wmctrl xdotool snixembed feh dunst --noconfirm
yay -Sy python-pywal16 nerdfonts-installer-bin --noconfirm
yes "48 51 68" | nerdfonts-installer 
git clone https://git.suckless.org/dmenu
cd dmenu
wget "https://tools.suckless.org/dmenu/patches/line-height/dmenu-lineheight-5.2.diff" 
patch -F3 -i "dmenu-lineheight-5.2.diff"
rm "dmenu-lineheight-5.2.diff"
echo "installing dmenu.."
sudo make clean install
echo "Done!"

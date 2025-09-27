set -xe
echo "Installing packages"
sudo pacman -Sy --needed jq wmctrl xdotool snixembed feh dunst --noconfirm
yay -Sy --needed python-pywal16 nerdfonts-installer-bin --noconfirm

echo "Installing fonts"
yes "48 51 68" | nerdfonts-installer 

echo "building and installing dmenu (thanks suckless)"
cd custom/dmenu
sudo make clean install
cd ../.. 

rm -rf custom/i3/build 
echo "building and installing i3..."
mkdir custom/i3/build 
cd custom/i3/build 
meson .. 
ninja 
sudo ninja install 
cd ../../.. 

rm -rf custom/i3status/build 
echo "building and installing i3status"
mkdir custom/i3status/build 
cd custom/i3status/build 
meson ..
ninja 
sudo ninja install
cd ../../.. 

set +xe 
echo "Done!"

read -r -d '' ALACRITTY_CONFIG << EOM
[general]
import = ['~/.config/i3/conf/alacritty-extra.toml']

[window]
decorations="full"
dynamic_title=true

[font]
size = 10

[font.normal]
family='Mononoki Nerd Font'

[font.bold]
family='MonaspiceRN NFM'
style="bold"

[font.italic]
family='Mononoki Nerd Font'
style='italic'

[terminal]

[terminal.shell]
program = "/bin/sh"
args = ["-c", "export ZDOTDIR=/home/$USER/.config/i3/conf/ && zsh"]
EOM
ALACRITTY_PATH="/home/$USER/.config/i3/conf/alacritty.toml"
ALACRITTY_COLORS=$(cat /home/$USER/.cache/wal/colors-alacritty.toml)
echo "$ALACRITTY_CONFIG" > "$ALACRITTY_PATH"
echo "$ALACRITTY_COLORS" >> "$ALACRITTY_PATH"
alacritty --config-file "$ALACRITTY_PATH"

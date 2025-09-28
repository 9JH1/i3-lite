#!/bin/bash
dpi=40
gap=0
border_size=5
workspace_width=50
refresh_i3status="killall -SIGUSR1 i3status"
primary_monitor=$(xrandr | grep "primary" | awk '{print $1}')
i3bar_height=$(xprop -name "i3bar for output $primary_monitor" | grep "_NET_WM_STRUT_PARTIAL" | awk '{print $5}' | tr -d ',')
font_size=$((dpi-10)) 
font_size_px=$(echo $font_size'px')

if [[ "$1" = "--reload-config" ]];then 
read -r -d '' I3_CONF << EOM
# -- VARS
set \$dpi             $(echo $dpi'px')
set \$gap             $(echo $gap'px')
set \$border_size     $(echo $border_size'px')
set \$workspace_width $(echo $workspace_width'px')
set \$mod Mod4

# -- BASE SETTINGS 
floating_modifier \$mod
default_orientation auto

# -- FOR WINDOW --
for_window [window_role="alert"] floating enable
for_window [class="feh"] floating enable
for_window [class="iso"] floating enable
for_window [class="fullscreen"] fullscreen enable
for_window [all] border normal \$border_size
for_window [all] title_window_icon on
for_window [all] title_window_icon padding \$border_size
for_window[all] title_format "%class -> <b>%title</b>"

# -- BASE KEYBINDS --
bindsym \$mod+shift+f fullscreen toggle global
bindsym \$mod+Left focus left
bindsym \$mod+Tab focus left 
bindsym \$mod+Shift+Tab focus right
bindsym \$mod+Down focus down
bindsym \$mod+Up focus up
bindsym \$mod+Right focus right
bindsym \$mod+q kill
bindsym \$mod+Shift+Left move left 
bindsym \$mod+Ctrl+Tab move left
bindsym \$mod+Shift+Down move down
bindsym \$mod+Shift+Up move up
bindsym \$mod+Shift+Right move right
bindsym \$mod+f fullscreen toggle
bindsym \$mod+Shift+space floating toggle
bindsym \$mod+space focus mode_toggle

# -- LAYOUT KEYBINDS --
bindsym \$mod+s layout stacking
bindsym \$mod+w layout tabbed
bindsym \$mod+e layout toggle split
workspace_layout tabbed

# -- EXEC KEYBINDS --
bindsym \$mod+Shift+Ctrl+r exec --no-startup-id "$HOME/.config/i3.sh --reload-config"
bindsym \$mod+Ctrl+w       exec --no-startup-id "$HOME/.config/i3/src/alttab.sh"  
bindsym \$mod+Shift+r      exec --no-startup-id "$HOME/.config/i3/src/rename_workspace.sh"
bindsym \$mod+r            exec --no-startup-id "$HOME/.config/i3/src/dmenu.sh"
bindsym \$mod+Shift+q      exec --no-startup-id "$HOME/.config/i3/src/forcequit.sh"
bindsym \$mod+Shift+s      exec --no-startup-id "$HOME/.config/i3/src/screenshot.sh"
bindsym \$mod+Return       exec --no-startup-id "$HOME/.config/i3/src/alacritty.sh"
bindsym \$mod+Shift+Return exec --no-startup-id "$HOME/.config/i3/src/alacritty.sh -isolate"
bindsym \$mod+x            exec --no-startup-id "$HOME/.config/i3/src/lock.sh"
bindsym \$mod+m            exec --no-startup-id "$HOME/.config/i3/src/lock.sh --image"
bindsym \$mod+Ctrl+x       exec --no-startup-id "shutdown now"
bindsym \$mod+Shift+t      exec --no-startup-id "$HOME/.config/i3/src/wal.sh"
bindsym \$mod+Ctrl+Shift+q exec --no-startup-id alacritty --class fullscreen -e sh -c "sudo $HOME/.config/i3/src/spoof.sh"

# -- SPECIAL KEYBINDS -- 
bindsym XF86AudioRaiseVolume  exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +1%
bindsym XF86AudioLowerVolume  exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -1%
bindsym XF86AudioMute         exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym XF86AudioMicMute      exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
bindsym XF86AudioPlay         exec --no-startup-id playerctl play-pause && $refresh_i3status 
bindsym XF86AudioNext         exec --no-startup-id playerctl next && $refresh_i3status 
bindsym XF86AudioPrev         exec --no-startup-id playerctl previous && $refresh_i3status 
bindsym XF86MonBrightnessUp   exec --no-startup-id brightnessctl set +5%
bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 5%-

exec_always --no-startup-id killall snixembed; snixembed
exec_always --no-startup-id killall nm-applet; nm-applet
exec_always --no-startup-id killall blueman-applet; blueman-applet
exec_always --no-startup-id killall unclutter; unclutter --timeout 0.1
exec_always --no-startup-id ~/.config/i3/src/wal.sh --preserve
exec_always --no-startup-id xset r rate 200 35

# Adjust gaps (inner and outer)
bindsym \$mod+plus gaps inner current plus 1
bindsym \$mod+minus gaps inner current minus 1
bindsym \$mod+Shift+plus gaps outer current plus 1
bindsym \$mod+Shift+minus gaps outer current minus 1

gaps inner \$gap
gaps outer \$gap
hide_edge_borders none

# -- WORKSPACES -- 
set \$ws1 "1"
set \$ws2 "2"
set \$ws3 "3"
set \$ws4 "4"
set \$ws5 "5"
set \$ws6 "6"
set \$ws7 "7"
set \$ws8 "8"
set \$ws9 "9"
set \$ws10 "10"
bindsym \$mod+1 workspace number \$ws1
bindsym \$mod+2 workspace number \$ws2
bindsym \$mod+3 workspace number \$ws3
bindsym \$mod+4 workspace number \$ws4
bindsym \$mod+5 workspace number \$ws5
bindsym \$mod+6 workspace number \$ws6
bindsym \$mod+7 workspace number \$ws7
bindsym \$mod+8 workspace number \$ws8
bindsym \$mod+9 workspace number \$ws9
bindsym \$mod+0 workspace number \$ws10
bindsym \$mod+Shift+1 move container to workspace number \$ws1
bindsym \$mod+Shift+2 move container to workspace number \$ws2
bindsym \$mod+Shift+3 move container to workspace number \$ws3
bindsym \$mod+Shift+4 move container to workspace number \$ws4
bindsym \$mod+Shift+5 move container to workspace number \$ws5
bindsym \$mod+Shift+6 move container to workspace number \$ws6
bindsym \$mod+Shift+7 move container to workspace number \$ws7
bindsym \$mod+Shift+8 move container to workspace number \$ws8
bindsym \$mod+Shift+9 move container to workspace number \$ws9
bindsym \$mod+Shift+0 move container to workspace number \$ws10

set_from_resource \$background     i3wm.background
set_from_resource \$foreground     i3wm.foreground
set_from_resource \$color1         i3wm.color1
set_from_resource \$color2         i3wm.color2
set_from_resource \$color5         i3wm.color5

font pango:Victor Mono Nerd Font Bold Italic $font_size_px

# -- CLIENT COLORS --   border       bg        fg           indicator    child_border
client.focused_inactive \$color5     \$color5  \$background \$background \$color5
client.unfocused        \$color5     \$color5  \$background \$background \$color5
client.urgent           #ff0000      #ff0000   #0000ff      #ff0000      #ff0000 
client.focused          \$color5     \$color5  \$background \$background \$color5

bar {
    status_command exec ~/.config/i3/src/i3status_top.sh
		bindsym button3 exec "dunstctl set-paused toggle && $refresh_i3status"
		bindsym button1 exec "exec playerctl play-pause  && $refresh_i3status"
		i3bar_command exec i3bar --transparency --bar_id bar-0
		position top
		strip_workspace_numbers yes
		strip_workspace_name no 
		font pango: Mononoki Nerd Font Bold \$dpi
		workspace_min_width \$workspace_width
		workspace_buttons yes 
		binding_mode_indicator no

		colors {
			background \$background
			statusline \$background
			separator \$color2

			focused_workspace \$color5 \$color5 \$background
			inactive_workspace \$background \$background \$color5
		}
}

bar {
	position bottom
	i3bar_command i3bar --transparency --bar_id bar-1
	status_command exec ~/.config/i3/src/i3status_bottom.sh
	workspace_buttons no
	font pango: Mononoki Nerd Font Bold \$dpi
	tray_output none

	colors {
		background \$background
		statusline \$background
		separator \$color2
	}
}
EOM

echo "$I3_CONF" > ~/.config/i3/config
i3-msg reload
else 
# Function to convert hex to decimal
hex_to_dec() {
    local hex=$1
    # Remove leading # if present
    hex=${hex#\#}
    # Convert to uppercase for consistency
    hex=${hex^^}
    # Validate hex input (must be 1-6 characters, 0-9 or A-F)
    if [[ ! $hex =~ ^[0-9A-F]{1,6}$ ]]; then
        echo "Error: Invalid hex value '$hex'" >&2
        return 1
    fi
    echo $((16#$hex))
}

# Function to convert decimal to hex (ensuring 2 digits)
dec_to_hex() {
    local dec=$1
    # Ensure input is a number
    if [[ ! $dec =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid decimal value '$dec'" >&2
        return 1
    fi
    printf "%02X" "$dec"
}

# Function to darken/lighten color based on index
generate_color() {
    local color=$1
    local index=$2

    # Validate index
    if [[ ! $index =~ ^-?[0-9]+$ ]]; then
        echo "Error: Invalid index '$index'" >&2
        return 1
    fi

    # Remove # from hex color if present
    color=${color#\#}

    # Validate hex color (must be exactly 6 characters)
    if [[ ! $color =~ ^[0-9A-Fa-f]{6}$ ]]; then
        echo "Error: Invalid hex color '$color'" >&2
        return 1
    fi

    # Extract R, G, B components
    r_hex=${color:0:2}
    g_hex=${color:2:2}
    b_hex=${color:4:2}

    # Convert to decimal
    r=$(hex_to_dec "$r_hex") || return 1
    g=$(hex_to_dec "$g_hex") || return 1
    b=$(hex_to_dec "$b_hex") || return 1

    # Adjust brightness based on index (e.g., index=-10 darkens, index=10 lightens)
    # Each index point changes brightness by ~4 (255/64)
    adjustment=$((index * 4))
    r=$((r + adjustment))
    g=$((g + adjustment))
    b=$((b + adjustment))

    # Clamp values to 0-255
    r=$((r < 0 ? 0 : (r > 255 ? 255 : r)))
    g=$((g < 0 ? 0 : (g > 255 ? 255 : g)))
    b=$((b < 0 ? 0 : (b > 255 ? 255 : b)))

    # Convert back to hex
    r_hex=$(dec_to_hex "$r") || return 1
    g_hex=$(dec_to_hex "$g") || return 1
    b_hex=$(dec_to_hex "$b") || return 1

    # Output new hex color
    echo "#${r_hex}${g_hex}${b_hex}"
}

source ~/.cache/wal/colors.sh
i=" "
seed=$background
color_good="#00ff00"
color_bad="#ff0000"
color_degraded="#ff5500"

# top values 
bcolor1=$(generate_color $seed 50)
bcolor2=$(generate_color $seed 40)
bcolor3=$(generate_color $seed 30)
bcolor4=$(generate_color $seed 20)
bcolor5=$(generate_color $seed 10)
bcolor6=$(generate_color $seed 5)


# bottom values 
bcolor7=$(generate_color $seed 40)
bcolor8=$(generate_color $seed 30)
bcolor9=$(generate_color $seed 20)
bcolor10=$(generate_color $seed 10)
bcolor11=$(generate_color $seed 5)
fi

#!/bin/bash

dpi=25
gap=0
border_size=10
workspace_width=50
refresh_i3status="killall -SIGUSR1 i3status"
primary_monitor=$(xrandr | grep "primary" | awk '{print $1}')
i3bar_height=$(xprop -name "i3bar for output $primary_monitor" | grep "_NET_WM_STRUT_PARTIAL" | awk '{print $5}' | tr -d ',')

if [[ "$1" = "--reload-config" ]];then 
read -r -d '' I3_CONF << EOM
# -- VARS
set \$dpi             $(echo $dpi'px')
set \$font_size       $(echo $font_size'px')
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
bindsym \$mod+Shift+Ctrl+r exec --no-startup-id "/home/$USER/.config/i3.sh --reload-config"
bindsym \$mod+Ctrl+w       exec --no-startup-id "/home/$USER/.config/i3/src/alttab.sh"  
bindsym \$mod+Shift+r      exec --no-startup-id "/home/$USER/.config/i3/src/rename_workspace.sh"
bindsym \$mod+r            exec --no-startup-id "/home/$USER/.config/i3/src/dmenu.sh"
bindsym \$mod+Shift+q      exec --no-startup-id "/home/$USER/.config/i3/src/forcequit.sh"
bindsym \$mod+Shift+s      exec --no-startup-id "/home/$USER/.config/i3/src/screenshot.sh"
bindsym \$mod+Return       exec --no-startup-id "/home/$USER/.config/i3/src/alacritty.sh"
bindsym \$mod+Shift+Return exec --no-startup-id "/home/$USER/.config/i3/src/alacritty.sh -isolate"
bindsym \$mod+x            exec --no-startup-id "/home/$USER/.config/i3/src/lock.sh"
bindsym \$mod+m            exec --no-startup-id "/home/$USER/.config/i3/src/lock.sh --image"
bindsym \$mod+Ctrl+x       exec --no-startup-id "shutdown now"
bindsym \$mod+Shift+t      exec --no-startup-id "/home/$USER/.config/i3/src/wal.sh"
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
exec_always --no-startup-id killall unclutter; unclutter --timeout 0.01
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
set \$ws1 "1:󰲠 "
set \$ws2 "2:󰲢 "
set \$ws3 "3:󰲤 "
set \$ws4 "4:󰲦 "
set \$ws5 "5:󰲨 "
set \$ws6 "6:󰲪 "
set \$ws7 "7:󰲬 "
set \$ws8 "8:󰲮 "
set \$ws9 "9:󰲰 "
set \$ws10 "10:󰿬 "
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

font pango:Victor Mono Nerd Font Bold Italic \$dpi

# -- CLIENT COLORS --   border       bg        fg           indicator    child_border
client.focused_inactive \$color5     \$color5  \$color1     \$background \$color5
client.unfocused        \$color5     \$color5  \$background \$background \$color5
client.urgent           #ff0000      #ff0000   #ff0000      #ff0000      #ff0000 
client.focused          \$color5     \$color5  \$color1     \$background \$color5

bar {
    status_command exec ~/.config/i3/src/i3status_top.sh
		bindsym button3 exec "dunstctl set-paused toggle && $refresh_i3status"
		bindsym button1 exec "exec playerctl play-pause  && $refresh_i3status"
		i3bar_command exec i3bar --transparency --bar_id bar-0
		position top
		separator_symbol "|"
		strip_workspace_numbers yes
		strip_workspace_name no 
		tray_padding \$gap 
		font pango: Mononoki Nerd Font Bold \$dpi
		workspace_min_width \$workspace_width
		workspace_buttons yes 
		binding_mode_indicator no


		padding \$gap \$dpi \$gap \$dpi 
		colors {
			background \$color5
			statusline \$background
			separator \$color2
			focused_workspace \$color1 \$color1 \$background
			inactive_workspace \$color5 \$color5 \$color2
		}
}

bar {
	position bottom
	i3bar_command i3bar --transparency --bar_id bar-1
	status_command exec ~/.config/i3/src/i3status_bottom.sh
	workspace_buttons no
	padding \$gap \$dpi \$gap \$dpi 
	separator_symbol "|"
	font pango: Mononoki Nerd Font Bold \$dpi
	tray_output none

	colors {
		background \$color5
		statusline \$background
		separator \$color2
	}
}
EOM

echo "$I3_CONF" > ~/.config/i3/config
i3-msg reload
fi

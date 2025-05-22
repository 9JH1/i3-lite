# update system
yay -Syu --noconfirm
pacman_used="$(du -sh /var/cache/pacman/pkg/)"
echo "Space currently in use: $pacman_used"
paccache -vrk2
paccache -ruk0
pacman_after="$(du -sh /var/cache/pacman/pkg/)"
echo "Space currently in use: $pacman_after"

# attempt removing orphaned packages
orphaned=$(yay -Qdtq)
if [ -n "$orphaned" ]; then
    echo "$orphaned" | yay -Rns -
else
    echo "No orphaned packages to remove."
fi

home_cache_used="$(du -sh ~/.cache)"
rm -rf ~/.cache/
echo "Clearing ~/.cache/..."
echo "Spaced saved: $home_cache_used"

sudo journalctl --vacuum-time=7d

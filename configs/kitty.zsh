# =============================================================================
echo                                     Kitty
# =============================================================================

# Symlink kitty config from shell-config into XDG config directory.
# This runs on every shell init so new machines pick it up automatically.
if [[ -d ~/.shell-config/kitty && ! -e ~/.config/kitty && ! -L ~/.config/kitty ]]; then
  mkdir -p ~/.config
  ln -s ~/.shell-config/kitty ~/.config/kitty
  echo "linked ~/.config/kitty -> ~/.shell-config/kitty"
fi

# Symlink kitty helper scripts into ~/.local/bin.
mkdir -p ~/.local/bin
for _kitty_script in jump-kitty kitty-theme-sync; do
  if [[ ! -e ~/.local/bin/$_kitty_script ]]; then
    ln -s ~/.shell-config/kitty/$_kitty_script ~/.local/bin/$_kitty_script
    chmod +x ~/.shell-config/kitty/$_kitty_script
    echo "linked ~/.local/bin/$_kitty_script"
  fi
done
unset _kitty_script

# Install and enable the kitty theme sync systemd user service.
if [[ -f ~/.shell-config/kitty/systemd/kitty-theme-sync.service ]]; then
  mkdir -p ~/.config/systemd/user
  ln -sfn ~/.shell-config/kitty/systemd/kitty-theme-sync.service \
    ~/.config/systemd/user/kitty-theme-sync.service
  systemctl --user enable --now kitty-theme-sync.service 2>/dev/null || true
fi

# Install the window-calls GNOME extension (needed by jump-kitty on Wayland).
# After install on a fresh machine, log out/in and run:
#   gnome-extensions enable window-calls@domandoman.xyz
_wc_dir=~/.local/share/gnome-shell/extensions/window-calls@domandoman.xyz
if [[ ! -d "$_wc_dir" ]] && command -v gnome-extensions &>/dev/null; then
  _wc_zip=$(mktemp --suffix=.zip)
  curl -fsSL -o "$_wc_zip" \
    'https://extensions.gnome.org/download-extension/window-calls@domandoman.xyz.shell-extension.zip?version_tag=69219' \
    && gnome-extensions install --force "$_wc_zip" \
    && echo "installed window-calls extension (enable after next login)"
  rm -f "$_wc_zip"
fi
unset _wc_dir _wc_zip

# Set GNOME keybindings.
if command -v gsettings &>/dev/null; then
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
    "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/',
      '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/',
      '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"
  _kb="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
  gsettings set "${_kb}:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" name    'Terminal'
  gsettings set "${_kb}:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" binding '<Control>grave'
  gsettings set "${_kb}:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" command "$HOME/.local/bin/jump-kitty"
  gsettings set "${_kb}:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" name    'mouse wheel up'
  gsettings set "${_kb}:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" binding '<Alt>Page_Up'
  gsettings set "${_kb}:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" command 'xdotool click 4'
  gsettings set "${_kb}:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" name    'mouse wheel down'
  gsettings set "${_kb}:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" binding '<Alt>Page_Down'
  gsettings set "${_kb}:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" command 'xdotool click 5'
  unset _kb
fi

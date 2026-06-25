# =============================================================================
echo                                    Neovim
# =============================================================================

# Symlink nvim config from shell-config into XDG config directory.
# This runs on every shell init so new machines pick it up automatically.
if [[ -d ~/.shell-config/nvim && ! -e ~/.config/nvim && ! -L ~/.config/nvim ]]; then
  mkdir -p ~/.config
  ln -s ~/.shell-config/nvim ~/.config/nvim
  echo "linked ~/.config/nvim -> ~/.shell-config/nvim"
fi

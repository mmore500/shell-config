# =============================================================================
echo                                  SETUP SHELL-CONFIG
# =============================================================================

if [ -d ~/.shell-config ]; then
 timeout 10 git -C ~/.shell-config pull origin master && echo "checked for shell-config update" || echo "shell-config update timeout"
fi

if [ ! -d ~/.shell-config ]; then
  git clone https://github.com/mmore500/shell-config ~/.shell-config && echo "collected shell-config" || echo "failed to collect shell-config" && exit 1
fi

# =============================================================================
echo                                 SETUP OH-MY-ZSH
# =============================================================================

[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# =============================================================================
echo                                  SETUP .zshrc
# =============================================================================

curl -m 5 -L https://raw.githubusercontent.com/mmore500/shell-config/master/init.zsh > ~/.zshrc.remote || echo "curl timeout" && rm -f ~/.zshrc.remote

if [ -f ~/.zshrc.remote ]; then
  cmp ~/.zshrc ~/.zshrc.remote || cp ~/.zshrc.remote ~/.zshrc && source ~/.zshrc
fi

rm -f ~/.zshrc.remote && "cleaned up temp .zshrc.remote"

# =============================================================================
echo                                  SETUP DOTFILES
# =============================================================================

for file in ~/.shell-config/dotfiles/*; do ln -sfn $(basename $file); done

# =============================================================================
echo                                   ALL CONFIGS
# =============================================================================

for file in ~/.shell-config/configs/*.zsh; do source $file; done

echo "DONE!"

clear

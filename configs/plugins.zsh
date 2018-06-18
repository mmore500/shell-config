# =============================================================================
echo                                   Plugins
# =============================================================================
# Check if zplug is installed

[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# oh-my-zsh
#zplug "zplug/zplug"
#zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"

zplug "plugins/common-aliase",     from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize",          from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/copydir",           from:oh-my-zsh
zplug "plugins/copyfile",          from:oh-my-zsh
zplug "plugins/cp",                from:oh-my-zsh
zplug "plugins/dircycle",          from:oh-my-zsh
zplug "plugins/encode64",          from:oh-my-zsh
zplug "plugins/extract",           from:oh-my-zsh
zplug "plugins/history",           from:oh-my-zsh
zplug "plugins/tmux",              from:oh-my-zsh
zplug "plugins/tmuxinator",        from:oh-my-zsh
zplug "plugins/urltools",          from:oh-my-zsh
zplug "plugins/web-search",        from:oh-my-zsh
zplug "plugins/z",                 from:oh-my-zsh
zplug "plugins/fancy-ctrl-z",      from:oh-my-zsh

# Supports oh-my-zsh plugins and the like
if [[ $OSTYPE = (linux)* ]]; then
    zplug "plugins/archlinux",     from:oh-my-zsh, if:"whence pacman"
    zplug "plugins/dnf",           from:oh-my-zsh, if:"whence dnf"
fi

if [[ $OSTYPE = (darwin)* ]]; then
    zplug "lib/clipboard",         from:oh-my-zsh
    zplug "plugins/osx",           from:oh-my-zsh
    zplug "plugins/brew",          from:oh-my-zsh, if:"whence brew"
    zplug "plugins/macports",      from:oh-my-zsh, if:"whence port"
fi

zplug "plugins/git",               from:oh-my-zsh, if:"whence git"
zplug "plugins/golang",            from:oh-my-zsh, if:"whence go"
zplug "plugins/svn",               from:oh-my-zsh, if:"whence svn"
zplug "plugins/node",              from:oh-my-zsh, if:"whence node"
zplug "plugins/npm",               from:oh-my-zsh, if:"whence npm"
zplug "plugins/bundler",           from:oh-my-zsh, if:"whence bundler"
zplug "plugins/gem",               from:oh-my-zsh, if:"whence gem"
zplug "plugins/rbenv",             from:oh-my-zsh, if:"whence rbenv"
zplug "plugins/rvm",               from:oh-my-zsh, if:"whence rvm"
zplug "plugins/pip",               from:oh-my-zsh, if:"whence pip"
zplug "plugins/sudo",              from:oh-my-zsh, if:"whence sudo"
zplug "plugins/gpg-agent",         from:oh-my-zsh, if:"whence gpg-agent"
zplug "plugins/systemd",           from:oh-my-zsh, if:"whence systemctl"
zplug "plugins/docker",            from:oh-my-zsh, if:"whence docker"
zplug "plugins/docker-compose",    from:oh-my-zsh, if:"whence docker-compose"

zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", use:"shell/*.zsh", as:plugin
zplug "andrewferrier/fzf-z"

# Enhanced cd
zplug "b4b4r07/enhancd", use:init.sh

# Bookmarks and jump
zplug "jocelynmallon/zshmarks"

# Enhanced dir list with git features
zplug "supercrabtree/k"

# Jump back to parent directory
zplug "tarrasch/zsh-bd"

# Simple zsh calculator
zplug "arzzen/calc.plugin.zsh"

# Directory colors
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin

# Load theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

#zplug "djui/alias-tips"
zplug "hlissner/zsh-autopair", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
# zsh-syntax-highlighting must be loaded after executing compinit command
# and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:3

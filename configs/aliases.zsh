# =============================================================================
echo                                   Aliases
# =============================================================================

# In the definitions below, you will see use of function definitions instead of
# aliases for some cases. We use this method to avoid expansion of the alias in
# combination with the globalias plugin.

# Directory coloring
if [[ $OSTYPE = (darwin|freebsd)* ]]; then
	export CLICOLOR="YES" # Equivalent to passing -G to ls.
	export LSCOLORS="exgxdHdHcxaHaHhBhDeaec"

	[ -d "/opt/local/bin" ] && export PATH="/opt/local/bin:$PATH"

	# Prefer GNU version, since it respects dircolors.
	if which gls &>/dev/null; then
		alias ls='() { $(whence -p gls) -Ctr --file-type --color=auto $@ }'
	else
		alias ls='() { $(whence -p ls) -CFtr $@ }'
	fi
else
	alias ls='() { $(whence -p ls) -Ctr --file-type --color=auto $@ }'
fi

# Set editor preference to nvim if available.
if which nvim &>/dev/null; then
	alias vim='() { $(whence -p nvim) $@ }'
else
	alias vim='() { $(whence -p vim) $@ }'
fi

# Generic command adaptations
alias grep='() { $(whence -p grep) --color=auto $@ }'
alias egrep='() { $(whence -p egrep) --color=auto $@ }'

# Custom helper aliases
alias ccat='highlight -O ansi'
alias rm='rm -v'

# Directory management
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -al'
alias d='dirs -v'
alias 1='pu'
alias 2='pu -2'
alias 3='pu -3'
alias 4='pu -4'
alias 5='pu -5'
alias 6='pu -6'
alias 7='pu -7'
alias 8='pu -8'
alias 9='pu -9'
alias pu='() { pushd $1 &> /dev/null; dirs -v; }'
alias po='() { popd &> /dev/null; dirs -v; }'

zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

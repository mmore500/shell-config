# =============================================================================
echo                                   Functions
# =============================================================================
powerlevel9k_random_color(){
	local code
	#for code ({000..255}) echo -n "$%F{$code}"
	#code=$[${RANDOM}%11+10]    # random between 10-20
	code=$[${RANDOM}%211+20]    # random between 20-230
	printf "%03d" $code
}

zsh_wifi_signal(){
	local signal=$(nmcli -t device wifi | grep '^*' | awk -F':' '{print $6}')
    local color="yellow"
    [[ $signal -gt 75 ]] && color="green"
    [[ $signal -lt 50 ]] && color="red"
    echo -n "%F{$color}\uf1eb" # \uf1eb is 
}

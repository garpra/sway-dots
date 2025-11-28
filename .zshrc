############################
# Login Session
############################

if [[ -o login ]]; then
    [[ -f ~/.profile ]] && source ~/.profile
    bash ~/.config/sway/gsetting.sh
fi

############################
# Interactive Shell
############################

if [[ $- == *i* ]]; then

    # Tools
    eval "$(starship init zsh)"
    eval "$(zoxide init zsh)"


    # Completion
    autoload -Uz compinit
    compinit

    # Plugins
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fi

############################
# Greeting
############################

if [[ "$TERM" == "foot" ]]; then
    fastfetch -c ~/.config/fastfetch/presets/simple.jsonc
fi

############################
# Alias
############################

alias sudo='sudo '
alias c='clear'
alias vi='nvim'
alias start='sudo systemctl start '
alias stop='sudo systemctl stop '

alias ff='fastfetch'
alias fishconfig='nvim ~/.config/fish/config.fish'

# Sway
alias getappid="swaymsg -t get_tree | jq '.. | select(.app_id?) | .app_id' | sort -u"
alias getapptitle="swaymsg -t get_tree | jq '.. | select(.name?) | .name' | sort -u"

# Paket
alias paccek='yay -Q | grep '
alias upgrade='yay -Syu && flatpak upgrade'
alias update='sudo pacman -Syu'

# Git
alias gi='git init'
alias gs='git status'
alias ga='git add .'
alias gcm='git commit -m '
alias gp='git push'
alias gc='git clone '
alias gf='git fetch'
alias grh='git reset --hard '
alias grr='git remote remove '

# Docker
alias cleandock='docker container prune -f && docker volume prune -f && docker network prune -f'

# System
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias hw='hwinfo --short'

alias mirror='sudo reflector --country Indonesia --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

alias ls='eza -al --color=always --group-directories-first --icons'

# Journal
alias jctl="journalctl -p 3 -xb"
alias clrjctl="sudo journalctl --vacuum-time=1s"

############################
# Functions
############################

cleanup() {
    local orphaned
    orphaned=$(pacman -Qtdq)

    if [[ -n "$orphaned" ]]; then
        sudo pacman -Rns $orphaned
    else
        echo "There are no packages to clean."
    fi
}

############################
# Login Session
############################

if [[ -o login ]]; then
  bash ~/.config/sway/gsetting.sh
fi

############################
# Interactive Shell
############################

if [[ $- == *i* ]]; then

  # Tools
  eval "$(starship init zsh)"
  eval "$(zoxide init zsh)"

  # History
  HISTFILE=~/.zsh_history
  HISTSIZE=10000
  SAVEHIST=10000
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_IGNORE_SPACE
  setopt SHARE_HISTORY
  setopt INC_APPEND_HISTORY
  setopt HIST_REDUCE_BLANKS

  # Keybindings
  bindkey "^[[A" history-search-backward
  bindkey "^[[B" history-search-forward

  # Enable undo / redo like fish
  bindkey '^Z' undo
  bindkey '^R' redo

  # Completion
  autoload -Uz compinit
  compinit

  # Case-insensitive completion
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'

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
alias ..="z .."
alias ...="z ../.."

alias ff='fastfetch'

# Sway
alias getappid="swaymsg -t get_tree | jq '.. | select(.app_id?) | .app_id' | sort -u"
alias getapptitle="swaymsg -t get_tree | jq '.. | select(.name?) | .name' | sort -u"

# Paket
alias paccek='yay -Q | grep '
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
alias gl='git log'
alias gr='git rebase'

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

y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

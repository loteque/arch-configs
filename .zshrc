# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# init environment vars
# set zinit HOME
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# set EDITOR 
EDITOR="micro"

# DL zinit if not exists
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# add zsh plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# add snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# load competions
autoload -U compinit; compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# initialize history widget
zle -N history-search-foward

# keybindings
bindkey -e
bindkey 'UPAR' history-search-backward
bindkey 'DOWNAR' history-search-foward

# shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(register-python-argcomplete pipx)"

# aliases
alias ls='ls --color'
alias -g ll="ls -Alph --group-directories-first --sort=extension --color=auto"
alias -g code="vscodium -r"
alias -g ff="firefox-developer-edition --new-window --search"
alias -g config="$EDITOR ~/.zshrc"
alias -g e="$EDITOR"
alias -g ce='cd_by_xplr_tmux_popup'
alias -g ge='lazygit'

# default extension handlers
# system
alias -s zshrc="code"
alias -s txt="code"
# rust
alias -s toml="code"
alias -s rs="code"
# godot
alias -s gd="code"
alias -s tscn="code"
alias -s tres="code"
# Created by `pipx` on 2024-12-19 09:32:55
export PATH="$PATH:/home/drusr/.local/bin"

## alias definitions with params
# grep $2 inside manpages of $1
mans() {
  man $1 | grep -- $2
}

# grep $2 from ll of $1
lg() {
  
  list_and_grep_pretty(){
    if [ $# -eq 1 ]
    then
      ll . | grep -- $1
    else
      ll $1 | grep -- $2
    fi
  }  
  
  list_and_grep_pretty $1 $2

}

# xplr in a tmux popup, cd on exit with selection
cd_by_xplr_tmux_popup() {
	tmux popup -d "#{pane_current_path}" -E -b rounded 'xcd=$(xplr) && [[ -n $xcd ]] && tmux send-keys "cd " $xcd  "enter" || echo 0 > /dev/null'
}

# yazi
# provides the ability to change the current working directory when exiting Yazi
# press q to quit, you'll see the CWD changed. Sometimes, you don't want to change, press Q to quit.
function li() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


# Shell-GPT integration ZSH v0.2
_sgpt_zsh() {
if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey ^l _sgpt_zsh


# pyenv shims
if command -v pyenv 1>/dev/null 2>&1; then
   eval "$(pyenv init -)"
fi

# find and install packages
fpac() { 
cmd=$(pacman -Slq | fzf --prompt 'pacman> ' \
  --header 'Install packages. CTRL+[P/Y/R/I/Q] (Pacman/Yay/Installed/Quit)' \
  --bind 'ctrl-p:change-prompt(pacman> )+reload(pacman -Slq)' \
  --bind 'ctrl-y:change-prompt(yay> )+reload(yay -Slq)' \
  --bind 'ctrl-i:change-prompt(inst> )+reload(yay -Qq)' \
  --multi --height=80% --preview 'sleep 2; yay -Si {1}' \
  --preview-window right) #| xargs -ro pacman -S
cmd=${cmd//$'\n'/ }       # newline -> space
if [ -n "$cmd" ]; then
  yay -S "$cmd"
fi
}

# tmux.
# quietly determine whether tmux is installed on our system
# check if already in a tmux session, the -z option returns 
# true if the length of the $TMUX variable is 0 (not a tmux session)
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  # attempts to attach to an existing tmux session called default
  # if no such session exists, creates a new session named default.	
  tmux attach-session -t default || tmux new-session -f ~/.tmux.conf -s default
fi

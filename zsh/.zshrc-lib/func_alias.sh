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
ce() {
	tmux popup -d "#{pane_current_path}" -E -b rounded -w80% -h80% \
	'xcd=$(xplr) && [[ -n $xcd ]] && tmux send-keys "cd " $xcd  "enter" || echo 0 > /dev/null'
}

# find and install packages
fpac() { 
if [ $# -gt 0 ]; then
  echo "usage: fpac"
  echo "opens an fzf menu to select packages to install"
  echo "takes no arguments"
  return 1;
fi
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

# open a file or directory in vscodium 
# if arg is directory, open current dir
# if arg is file, open file
# if no argument is specified, open current file in vscodium

codium() {
  if [ $# -gt 1 ]; then
    echo "usage: codium [<file>|<dir>]"
    echo "if no argument, opens current dir in vscodium"
    return 1;
  fi
  if [ $# -eq 1 ]; then
    vscodium -r $1
  elif [ $# -eq 0 ]; then
    vscodium -r .
  fi
}
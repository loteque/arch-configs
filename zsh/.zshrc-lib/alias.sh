# ls with colors
alias ls='ls -1 --color=always'
# ls full expansion, directories on top, by extension
alias -g ll="ls -GAlph --group-directories-first --sort=extension --color=always"
# reuse vcurrent vscode window by default, `vscodium` left default
alias -g c="codium"
# open firefox and search for a term given by this alias' argument
alias -g ff="firefox-developer-edition --new-window --search"
# open the default editor, files as args
alias -g e="$EDITOR"
# open lazygit
alias -g ge='lazygit'

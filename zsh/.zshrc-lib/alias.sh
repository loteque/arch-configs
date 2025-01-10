# ls with colors
alias ls='ls --color'
# ls full expansion, directories on top, by extension
alias -g ll="ls -Alph --group-directories-first --sort=extension --color=auto"
# reuse vcurrent vscode window by default, `vscodium` left default
alias -g code="vscodium -r"
# open firefox and search for a term given by this alias' argument
alias -g ff="firefox-developer-edition --new-window --search"
# open the default editor, files as args
alias -g e="$EDITOR"
# open lazygit
alias -g ge='lazygit'

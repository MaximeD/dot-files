# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="max" # custom theme

alias ls='ls --group-directories-first'
alias lltag_rename='lltag --rename "%n. %t"'
alias bit='git'
alias bim='vim'
alias dmesg='dmesg --color'
# remove local merged branches
alias prunelocal="git branch --no-color --merged | grep -v '^*' | xargs git branch -d"
# remove merged branches on origin
alias pruneorigin="!sh -c 'git branch --no-color -r --merged | grep \"^  origin/\" | grep -v \"/master$\" | sed \"s/origin./:/g\" | xargs git push origin'"

# Uncomment following line if you want to disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# golang
export GOPATH="$HOME/code/go"
export PATH="$PATH:$GOPATH/bin"

# rbenv
unset RUBYOPT
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# no more `bundle exec`
export RUBYGEMS_GEMDEPS=-

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# zsh syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=green
ZSH_HIGHLIGHT_STYLES[alias]=none
ZSH_HIGHLIGHT_STYLES[builtin]=none
ZSH_HIGHLIGHT_STYLES[function]=none
ZSH_HIGHLIGHT_STYLES[command]=none
ZSH_HIGHLIGHT_STYLES[precommand]=none
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=none
ZSH_HIGHLIGHT_STYLES[path]=bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan

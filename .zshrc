# Created by newuser for 4.3.10
export PS1="%{$fg[grey]$bold_color%}╸%b%{$fg[blue]$bold_color%}%n%{$fg[yellow]%}@%{$fg[white]%}%m%{$fg[black]$bold_color%}╺─╸%b%{$fg[green]$bold_color%}%~%{$fg[black]$bold_color%} ╸%{$reset_color%}"

# Allow for functions in the prompt.
setopt PROMPT_SUBST

# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# Set the prompt.
PROMPT=$'%{$fg[grey]$bold_color%}╸%b%{$fg[blue]$bold_color%}%n%{$fg[yellow]%}@%{$fg[white]%}%m%{$fg[black]$bold_color%}╺─╸%b%{$fg[green]$bold_color%}%~%b$(prompt_git_info)%{$fg[black]$bold_color%} ╸%{$reset_color%} '


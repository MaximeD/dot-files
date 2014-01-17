local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='
%{$fg[grey]%}%c \
$(git_prompt_info)\
%{$fg[green]%}%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='%{$fg[blue]%}%~%{$reset_color%} ${return_code} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}:: %{$fg[grey]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}⚡%{$fg[grey]%}"
ZSH_THEME_GIT_PROMPT_STASH="%{$fg[yellow]%}⚓%{$fg[grey]%}"
ZSH_THEME_GIT_PROMPT_NOSTASH=""

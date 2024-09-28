alias vim="nvim"
alias vi="nvim"

# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"
export FZF_COMPLETION_TRIGGER='**'

########
# PROMPT
########

function git_branch() {
    local branch
    branch="$(git symbolic-ref --short HEAD 2>/dev/null)"
    if [[ -n "$branch" ]]; then
        echo -n "$branch"
        return 0
    fi
    return 1
}

function git_name() {
    git config user.name 2>/dev/null
}

function git_has_diff() {
    git diff --quiet HEAD 2>/dev/null
}

export WHITE='\[\033[1;37m\]'
export LIGHT_GREEN='\[\033[0;32m\]'
export LIGHT_BLUE='\[\033[0;94m\]'
export LIGHT_BLUE_BOLD='\[\033[1;94m\]'
export RED_BOLD='\[\033[1;31m\]'
export GREEN_BOLD='\[\033[1;32m\]'
export YELLOW_BOLD='\[\033[1;33m\]'
export COLOUR_OFF='\[\033[0m\]'

function prompt_command() {
    local P=()
    # P+="[\$?]"
    # P+=" "
    # P+="${LIGHT_GREEN}\$(git_name || echo -n \$USER)"
    # P+="${WHITE} ➜ "
    P+="${debian_chroot:+($debian_chroot)}"
    P+="${GREEN_BOLD}\u@\h"
    P+="${COLOUR_OFF}:"
    P+="${LIGHT_BLUE_BOLD}\w"
    P+=" "
    P+="${LIGHT_BLUE}("
    P+="${RED_BOLD}\$(git_branch)"
    P+="${YELLOW_BOLD}\$(git_has_diff || echo -n '✗')"
    P+="${LIGHT_BLUE})"
    P+="${COLOUR_OFF}"
    P+="\$"
    P+=" "
    export PS1=${P[@]}
}

export PROMPT_COMMAND='prompt_command'

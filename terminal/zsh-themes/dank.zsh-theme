PROMPT=$'%{$fg_bold[blue]%}%n %{$fg[white]%}at %{$fg_bold[cyan]%}%M %{$fg[white]%}in %{$reset_color%}%~%b%{$reset_color%} %{$fg[cyan]%}$(check_git_prompt_info)%{$fg[white]%}%{$reset_color%}$(git_prompt_status)%{$fg[blue]%})%{$reset_color%}
%{$fg_bold[yellow]%}%D{[%I:%M:%S]} %{$fg[white]%}⚛$ %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}(%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_DIRTY=""

# Text to display if the branch is clean
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✅"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[green]%}"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[yellow]%}.🔱."
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}+∕−"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}➜"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}.✂️."
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[red]%}+∕−"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}.Ⓜ️."
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}.♨️."

ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}●"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}✚"
ZSH_THEME_GIT_PROMPT_REMOTE=""
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

function rbenv_prompt_info() { echo "$(ruby -v | cut -f 2 -d ' ')" }

# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[magenta]%}detached-head%{$reset_color%})"
        else
            echo "$(git_prompt_info)"
        fi
    fi
}

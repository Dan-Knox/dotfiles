# This is really a mashup of the 3den.zsh-theme and the Soliah.zsh-theme.
#
# Thanks for doing all the hard work :)

PROMPT=$'\n$(user_at_host)% %{$reset_color%}$(my_git_prompt) : %~\n$(colorized_time) [${ret_status}] $ '

function update_clock_every_second() {
  #autoload -X
  #setopt PROMPT_SUBST
  TMOUT=1

  TRAPALRM() {
      zle reset-prompt
  }
}
update_clock_every_second

function my_git_prompt() {
  tester=$(git rev-parse --git-dir 2> /dev/null) || return

  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""

  # is branch ahead?
  if $(echo "$(git log origin/$(current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi

  # is anything staged?
  if $(echo "$INDEX" | command grep -E -e '^(D[ M]|[MARC][ MD]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi

  # is anything unstaged?
  if $(echo "$INDEX" | command grep -E -e '^[ MARC][MD] ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi

  # is anything untracked?
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi

  # is anything unmerged?
  if $(echo "$INDEX" | command grep -E -e '^(A[AU]|D[DU]|U[ADU]) ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi

  if [[ -n $STATUS ]]; then
    STATUS=" $STATUS"
  fi

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(my_current_branch)$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function my_current_branch() {
  echo $(current_branch || echo "(no branch)")
}

function user_at_host() {
  echo "%{$fg_bold[blue]%}%n %{$fg[white]%}at %{$fg_bold[blue]%}%M"
}

function colorized_time {
  local background="%{$bg[selection]%}"
  local yellow="%{$fg_bold[yellow]%}"
  local red="%{$fg_bold[red]%}"

  local sep=":"

  local hour="%D{%I}"
  local min="%D{%M}"
  local sec="%D{%S}"


  echo "${background}${red}[${hour}${sep}${min}${sep}${sec}]${reset_color}"
}

local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})%?%{$reset_color%}"


if [ "$(uname -s)" = "Darwin" ]; then
  local eyes='👀'
  local tounge='👅'
  #RPROMPT=$'${eyes}\n${tounge}'
fi

#PROMPT=$'%{$fg[blue]%}%n %{$fg[white]%}at %{$fg_bold[cyan]%}%M %{$fg[white]%}in %{$reset_color%}%~%b%{$reset_color%} %{$fg[cyan]%}$(check_git_prompt_info)%{$fg[white]%}%{$reset_color%}$(git_prompt_status)%{$fg[blue]%})%{$reset_color%}
#$(colorized_time} %{$fg[white]%}⚛$ %{$reset_color%}'

ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" $fg_bold[blue](%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[red]%}●"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[white]%}●"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%}✕"
ZSH_THEME_GIT_PROMPT_SUFFIX="$fg_bold[blue])%{$reset_color%}"

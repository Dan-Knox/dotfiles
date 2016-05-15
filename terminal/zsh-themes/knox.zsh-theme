# Directory info.
local current_dir='%{$fg_bold[white]%}in %{$fg[yellow]%}%3(c:…/:)%2c'
#local current_dir='$fg_bold[white]in $fg[yellow]%30<..<%'

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg_bold[white]%}on%{$reset_color%}"
YS_VCS_PROMPT_PREFIX2="%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}+"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

function my_git_prompt_info() {
  tester=$(git rev-parse --git-dir 2> /dev/null) || return

  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""

  # is branch ahead?
  #if $(echo "$(git log origin/$(current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
  #  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  #fi

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
    STATUS="$STATUS"
  fi

  echo "$ZSH_THEME_GIT_PROMPT_PREFIX $(current_branch)$ZSH_THEME_GIT_PROMPT_AHEAD $STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}o"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}o"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}⇡"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]%}o"
local git_info='$(my_git_prompt_info)'

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

# Indicate wether prompt is in INSERT or VI mode
function my_prompt_mode_info() {
  local vi_mode="%{$fg_bold[yellow]%}💩%{$reset_color%}"
  local insert_mode="%{$fg_bold[green]%}💩%{$reset_color%}"

  if [[ $KEYMAP == vicmd ]]; then
    echo -n "${vi_mode}"
  else
    echo -n "${insert_mode}"
  fi
}
local prompt_mode_info='$(my_prompt_mode_info)'

# Redraw prompt when switching between INSERT modes
function zle-line-init zle-keymap-select {
  PS1="${PROMPT}"
  # ${${KEYMAP/vicmd/$vi_mode}/(main|viins)/$insert_mode}"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=0.1

# Return code
local return_color='%(1?;$fg[red];)%(1?;;%{$fg[green]%})'
local return_code="%{$return_color%} %?"

PROMPT="
%{$reset_color%}\
%{$fg[cyan]%}%n%{$fg_bold[white]%} at \
%{$reset_color%}\
%{$fg[green]%}%m \
$current_dir%{$reset_color%}${hg_info}${git_info} \

%{$return_color%}%?%{$reset_color%} !%! \
${prompt_mode_info} %{$fg_bold[red]%}$ %{$reset_color%}"

if [[ "$USER" == "root" ]]; then
PROMPT="
$reset_color\
$fg[red]%n$fg[white] at \
$reset_color\
$fg[red]%m$fg[red] \
$current_dir${hg_info}${git_info} \

$fg[red][$return_color%?$fg[red]] $reset_color!%! \
%{$fg[red]%}$INSERT_MODE $ %{$reset_color%}"
fi

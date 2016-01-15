# Directory info.
local current_dir='${PWD/#$HOME/~}'

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2="%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}+"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# TODO: Git info: Staged, Ahead and Unstaged are currently in progress.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[yellow]}+"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]}+"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]}o"

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

# Return code
local return_color='%(1?;$fg[red];)%(1?;;%{$fg[green]%})'
local return_code="$return_color %?"

PROMPT="
$reset_color\
$fg_bold[white][\
$reset_color\
$fg[blue]%n$fg_bold[white]@\
$reset_color\
$fg[blue]%m$fg_bold[white]] $fg_bold[yellow]\
$current_dir$reset_color${hg_info}${git_info} \

[$return_color%?$reset_color] !%! \
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"

if [[ "$USER" == "root" ]]; then
PROMPT="
$reset_color\
$fg[red][\
$reset_color\
$fg[blue]%n$fg[red]@\
$reset_color\
$fg[blue]%m$fg[red]] \
$current_dir${hg_info}${git_info} \

$fg[red][$return_color%?$fg[red]] $reset_color!%! \
%{$fg[red]%}$ %{$reset_color%}"
fi

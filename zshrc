if ($(alias -g run-help)) {
  unalias run-help
}

autoload run-help
HELPDIR=/usr/local/share/zsh/help

# ZSH Completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Add /usr/local/sbin to PATH
export PATH=$PATH:/usr/local/sbin

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="../zsh-themes/knox"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
ZSH_CUSTOM=$HOME/dotfiles/terminal/zsh-plugins

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
	git
  #git-hubflo
  #git-flo
  rbenv
	gem
  bundler
  nvm
	rbenv
  battery
  tmux
  colored-man-pages
  catimg
  colorize
  dircycle
  docker
  docker-compose
  history-substring-search
  kube-ps1
  kubectl
  otp
  perms
  web-search
  timer
  vi-mode
)

# Source Oh-My-ZSH
source $ZSH/oh-my-zsh.sh

# Load antigen for simpler plugin managment
source $HOME/dotfiles/antigen.zsh

# More plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/

# Workaround for Rust lacking color in test output.
export TERM=xterm-color

export PATH=$PATH:~/.local/bin

fpath+=~/.zfunc

# load cargo
source ~/.cargo/env

# Set zsh to use VI command mode
#bindkey -v
export KEYTIMEOUT=1

# Set up and down to search history based off of current word
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Configure z for fast directory switching
. /etc/profile.d/z.sh

# Set up terminal colors
export BASE16_SHELL=~/dotfiles/terminal/base16-builder/output/shell
[[ -f $BASE16_SHELL ]] && source "$BASE16_SHELL/base16-flat.light.sh"

#source "$(brew --prefix)/etc/grc.bashrc"

# Powerline
#. ~/.janus/powerline/powerline/bindings/zsh/powerline.zsh

#export JAVA_HOME="/usr"

# Set up the correct paths for Golang
export GO15VENDOREXPERIMENT=1
export GOROOT=/usr/local/go
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Load sensitive environment variables if they exist
if [ -f $HOME/.secrets.zsh ]; then
  source $HOME/.secrets.zsh
fi

# Load custom functions
if [ -f "$HOME/.functions.zsh" ]; then
  source "$HOME/.functions.zsh"
fi

if [ "$(uname -s)" = "Darwin" ]; then
  # OSX specific configuration
  alias vim="mvim -v"
  alias flushdns="dscacheutil -flushcache"

  # Set apple gcc path for RVM
  #export CC="/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/gcc-4.2"
  #export CXX="/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/g++-4.2"
  #export CPP="/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/cpp-4.2"
  #export CPPFLAGS=-I/opt/X11/include
  #export LDFLAGS=-L/usr/local/opt/openssl/lib

  export BUNDLER_EDITOR="mvim"
  export EDITOR="mvim"

  # Load 'z' for fast directory switching
  if [ -f `brew --prefix`/etc/profile.d/z.sh ] ; then
    . `brew --prefix`/etc/profile.d/z.sh
  fi

  function add_space_to_dock { defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}' }

  # Change the OS X tab color from the console.

  function tab_red () {
    set_tab_color 255 50 0
  }

  function tab_blue () {
    set_tab_color 0 50 100
  }

  function tab_green () {
    set_tab_color 50 100 0
  }

  function tab_yellow () {
    set_tab_color 140 140 0
  }

  function tab_teal () {
    set_tab_color 0 140 140
  }

  # Takes 3 integers representing R G B
  function set_tab_color () {
    local red="\033]6;1;bg;red;brightness;$1\a"
    local green="\033]6;1;bg;green;brightness;$2\a"
    local blue="\033]6;1;bg;blue;brightness;$3\a"
    echo -en $red
    echo -en $blue
    echo -en $green
  }

else
  # Linux specific configuration

  alias mvim="gvim"
  alias pbcopy="xclip -sel clip"
  alias apt="sudo apt"
  alias apti="sudo apt install"
  alias aptr="sudo apt remove"
  export PATH=$PATH:/opt/vagrant/bin

fi

# Fix zsh autocorrects
alias lein='nocorrect lein'
alias thin='nocorrect thin'
alias htop='nocorrect htop'
alias gulp='nocorrect gulp'
alias jest='nocorrect jest'
alias ava='nocorrect ava'
alias console='nocorrect console'

# Rails aliases
alias b='bundle exec'
alias bi='bundle install'
alias brc='bundle exec rails c'
alias brg='bundle exec rails g'

# Docker Rails aliases
alias db='docker-compose run web bundle exec'
alias dbi='docker-compose run web bundle install'
alias dbrc='docker-compose run web bundle exec rails c'
alias dbrg='docker-compose run web bundle exec rails g'
alias dguard='docker-compose run -e RAILS_ENV=test web guard'

# Enable terminal colors for common commands
alias c='pygmentize'

function git-fetch-all-branches { for remote in `git branch -r `; do git checkout --track $remote; done }

# Dash search straight from the console
function dash { open "dash://{$*}" }

# NPM aliases
alias npmig='npm install --global'
alias npmid='npm install --save-dev'
alias npmis='npm install --save'

# Docker aliases
alias docker='nocorrect docker'
alias dco='docker-compose'
alias dcm='docker-machine'
alias dcc='docker-cloud'

# Use jq for basic JSON formatting from the comamnd line
if [ -f "$(which jq)" ]; then
  function jcat { cat $@ | jq '.' }
fi

# Use hub wrapper for Git
if [ -f "$(which hub)" ]; then
  eval "$(hub alias -s)"
fi

# Use thefuck for quick shell command corrections
if [ -f "$(which thefuck)" ]; then
  eval $(thefuck --alias)
fi

# Use Pry as a rails console
alias pryr="pry -r ./config/environment -r rails/console/app -r rails/console/helpers"

# Use git-name-email-switcher to correctly set my author
# and committer name and email based on the directory I am
# working in.
#source $HOME/dotfiles/oh-my-zsh-custom/git-name-email-switcher.zsh

# Set default Thin port for foreman
export PORT=3000

# Set redis url
export REDISTOGO_URL='redis://localhost:6379'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add byobu to the path
export PATH=$HOME/.byobu/bin:$PATH

# Load rbenv
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Load nvm (Node Version Manager)
export NVM_DIR=~/.nvm
. $NVM_DIR/nvm.sh
export PATH="$PATH:./node_modules/.bin"

# Chromium Depot Tools
if [ -d $HOME/code/tools/depot_tools ]; then
  export PATH="$HOME/code/tools/depot_tools:$PATH"
fi

# Add user ~/bin to path if it exists
if [ -d $HOME/bin ] ; then
  export PATH=$HOME/bin:$PATH
fi

export PATH="./bin:$PATH"

# Add Inkdrop's plugin management executable: ipm
export PATH=$PATH:"/snap/inkdrop/current/usr/lib/inkdrop/resources/app/ipm/bin/"

# Set up the docker configuration
function activate_docker!() {
  eval $(docker-machine env default)
}

alias dcmp='docker-compose'

export PATH="$HOME/.bin:$PATH"

alias lsc="colorls"
alias colorize="pygmentize"
alias c="pygmentize"

alias dco="docker-compose"
#alias docker="sudo docker"
alias dguard="docker-compose run -e RAILS_ENV=test web bundle exec guard"
alias drails="docker-compose run web bundle exec rails"
alias truncate_docker_logs="sudo sh -c 'truncate -s 0 /var/lib/docker/containers/*/*-json.log'"

# Dockerized Neovim
alias dnvim="docker run -it -v $(pwd):/home/spacevim/src nvim /home/spacevim/src"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dknox/google-cloud-sdk/path.zsh.inc' ]; then . '/home/dknox/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dknox/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/dknox/google-cloud-sdk/completion.zsh.inc'; fi

# Export PlatformIO Binaries
export PATH=~/.platformio/penv/bin:$PATH

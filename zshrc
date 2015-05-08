# Start tmux in command mode when opening a new prompt
#export BYOBU_PREFIX=/usr/local
#[[ $TERM != "screen" ]] && exec tmux -CC new -s hot_key # && tmux set -g aggressive-resize off;

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/dotfiles/oh-my-zsh-custom

#export BYOBU_PREFIX=/usr/local/Cellar/byobu/5.70
export BYOBU_PREFIX=$(brew --prefix)

# My custom theme
ZSH_THEME="dank_two"
#. ~/.janus/powerline/powerline/bindings/zsh/powerline.zsh

export JAVA_HOME="$(/usr/libexec/java_home)"

# Set up the correct paths for Golang
export GOPATH="$HOME/code/go"
export PATH=$PATH:$GOPATH/bin

# Load sensitive environment variables if they exist
if [ -f $HOME/secrets.zsh ]; then
  source $HOME/secrets.zsh
fi

if [ "$(uname -s)" = "Darwin" ]; then
  # OSX specific configuration

  alias vim="mvim -v"
  alias flushdns="dscacheutil -flushcache"
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH

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

  # Enable byobu
  export BYOBU_PREFIX=$(brew --prefix)

else
  # Linux specific configuration

  alias mvim="gvim"
  export PATH=$PATH:/opt/vagrant/bin
  export PATH=$PATH:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

fi

# Fix zsh autocorrects
alias lein='nocorrect lein'
alias thin='nocorrect thin'
alias htop='nocorrect htop'

# Rails aliases
alias b='bundle exec'
alias bi='bundle install'
alias brc='bundle exec rails c'
alias brg='bundle exec rails g'

# Enable terminal colors for common commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias c='pygmentize'

function git-fetch-all-branches { for remote in `git branch -r `; do git checkout --track $remote; done }

# Dash search straight from the console
function dash { open "dash://{$*}" }

# NPM aliases
alias npmig='npm install --global'
alias npmid='npm install --save-dev'

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
  alias fuck='$(thefuck $(fc -ln -1))'
  #Or in config.fish:
  #function fuck
  #  eval (thefuck $history[1])
  #end
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

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-hubflow git-flow rbenv brew gem atom)

source $ZSH/oh-my-zsh.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add byobu to the path
export PATH=$HOME/.byobu/bin:$PATH

# Node.js Paths
export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/share/npm/bin:./node_modules/.bin:$PATH"

# Load rbenv
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Load nvm (Node Version Manager)
export NVM_DIR=~/.nvm
source "$(brew --prefix nvm)/nvm.sh"
export NODE_PATH=$NODE_PATH:"~/.nvm/v0.10.38/lib/node_modules"
export PATH="$PATH:/usr/local/share/npm/bin"

# Chromium Depot Tools
if [ -d $HOME/code/tools/depot_tools ]; then
  export PATH="$HOME/code/tools/depot_tools:$PATH"
fi

# Add user ~/bin to path if it exists
if [ -d $HOME/bin ] ; then
  export PATH=$HOME/bin:$PATH
fi

export PATH="./bin:$PATH"
export NODE_PATH="/usr/local/lib/node:/usr/local/lib/node_modules:./node_modules"

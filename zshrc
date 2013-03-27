# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/dotfiles/oh-my-zsh-custom

# My custom theme
ZSH_THEME="dank"

# Add user ~/bin to path if it exists
if [ -d $HOME/bin ] ; then
  export PATH=$HOME/bin:$PATH
fi

if [ "$(uname -s)" = "Darwin" ]; then
  # OSX specific configuration

  alias vim="mvim -v"
  alias flushdns="dscacheutil -flushcache"
  PATH=/usr/local/bin:/usr/local/sbin:$PATH

  # Set apple gcc path for RVM
  export CC=/usr/local/bin/gcc-4.2
  export CPPFLAGS=-I/opt/X11/include
  export LDFLAGS=-L/usr/local/opt/openssl/lib

else
  # Linux specific configuration

  alias mvim="gvim"
  export PATH=$PATH:/opt/vagrant/bin
  export PATH=$PATH:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

fi

alias lein='nocorrect lein'
alias thin='nocorrect thin'
alias htop='nocorrect htop'

function git-fetch-all-branches { for remote in `git branch -r `; do git checkout --track $remote; done }

# Use hub wrapper for Git
eval "$(hub alias -s)"

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
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git bundler brew gem)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH

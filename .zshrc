########################################################################
# zsh specific settings
########################################################################

# Path to oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# Set zsh theme here
ZSH_THEME="alanpeabody"

# Load and run compinit
autoload -U compinit
compinit -i

# Enable globbing for hidden files, advanced globbing
setopt GLOBDOTS
setopt EXTENDEDGLOB

# no clobbing
setopt NO_CLOBBER

# Enable piping to multiple outputs
setopt MULTIOS

# Automaticall cd into directories when typing their name
setopt AUTO_CD

setopt AUTO_PUSHD
setopt AUTO_MENU

# be quiet!
setopt NO_BEEP

# Source all zsh config files excluding the plugins directory
DOTFILES_DIR=$HOME/.dotfiles

for config_file ($DOTFILES_DIR/**/*.zsh~($DOTFILES_DIR/plugins/*.zsh)(.))
  source $config_file


########################################################################
# other config sources
########################################################################

# Path to mysql
export PATH="/usr/local/mysql/bin:$PATH"

# Path to sbt
export PATH="/Users/evan/bin:$PATH"

# Path to RubyGems
export PATH="/System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/bin:$PATH"

# We're going to need UTF-8, badly
export LANG=en_US.UTF-8

# Homebrew
if which brew > /dev/null 2>&1; then
  export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/sharepython:/usr/local/share/npm/bin:$PATH
fi

fpath=(~/.dotfiles/zsh/completions $fpath)

########################################################################
# aliases
########################################################################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# local dir aliases
alias dr="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias dv="cd ~/dev"
alias ds="cd ~/dev/data-shipment"
alias sc="cd ~/dev/scalding-jobs"
alias pg="cd ~/dev/pig"
alias dsb="cd ~/dev/DSP-backend/core"
alias dsf="cd ~/dev/DSP-frontend"
alias sn="cd ~/dev/snippets"
alias ca="cd ~/dev/creative-approval-api"

# standard aliases
alias vi="vim"
alias py="ipython"

########################################################################
# misc. tools
########################################################################

alias restart_mysql="sudo /usr/local/mysql/bin/mysqld_safe"
alias avrocat="~/Dropbox/avrocat.sh $1"
alias zshconf="vi ~/Dropbox/.zshrc"
alias zshreload="source ~/Dropbox/.zshrc"
alias tpconf="vi ~/Dropbox/.tapadrc"
alias vimconf="vi ~/Dropbox/.vimrc"

function grep_for_process() { 
  ps -ax | grep -i $1
}
alias psg=grep_for_process


########################################################################
# launchers
########################################################################

avroscore() {
  python ~/dev/avroscore/avroscore.py "$@"	
}

########################################################################
# finish
########################################################################

source $ZSH/oh-my-zsh.sh
source $HOME/Dropbox/.tapadrc

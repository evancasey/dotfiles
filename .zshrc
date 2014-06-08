# We're going to need UTF-8, badly
export LANG=en_US.UTF-8

# Load and run compinit
autoload -U compinit
compinit -i

# Enable globbing for hidden files, advanced globbing
setopt GLOBDOTS
setopt EXTENDEDGLOB

# no clobbing
setopt NO_CLOBBER

# Source all zsh config files excluding the plugins directory
DOTFILES_DIR=$HOME/.dotfiles

for config_file ($DOTFILES_DIR/**/*.zsh~($DOTFILES_DIR/plugins/*.zsh)(.))
  source $config_file

# Enable piping to multiple outputs
setopt MULTIOS

# Automaticall cd into directories when typing their name
setopt AUTO_CD
# no search for directories starting with ~
#setopt CDABLE_VARS

setopt AUTO_PUSHD
setopt AUTO_MENU

# be quiet!
setopt NO_BEEP

# Enable spelling correction
setopt CORRECT

# Homebrew
if which brew > /dev/null 2>&1; then
  export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/sharepython:/usr/local/share/npm/bin:$PATH
fi

export EDITOR=nano

fpath=(~/.dotfiles/zsh/completions $fpath)
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

alias dr="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias d="cd ~/dev"
alias g="git"
alias h="history"
alias j="jobs"
alias vi="vim"
alias py="ipython"


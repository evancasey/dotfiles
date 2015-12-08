########################################################################
# zsh specific settings
########################################################################

DOTFILES_HOME=$HOME/Dropbox/dotfiles

DISABLE_AUTO_UPDATE=true

# Path to oh-my-zsh configuration
ZSH=$DOTFILES_HOME/.oh-my-zsh

# Set zsh theme here
ZSH_THEME="alanpeabody"

# Load and run compinit
autoload -U compinit
compinit -i

# Source all zsh config files excluding the plugins directory
DOTFILES_DIR=$DOTFILES_HOME/.dotfiles

for config_file in $DOTFILES_DIR/zsh/*.zsh
do
  source $config_file
done

source $ZSH/oh-my-zsh.sh

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

setopt complete_aliases

# only enable autocorrect on commands
unsetopt correct_all
setopt correct

set -o vi

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

fpath=(~/$DOTFILES_DIR/zsh/completions $fpath)

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
alias sn="cd ~/dev/snippets"
alias ds="cd ~/dev/data-shipment"
alias sc="cd ~/dev/scalding-jobs"
alias pg="cd ~/dev/pig"
alias pf="cd ~/dev/programmatic-front-end"
alias dsb="cd ~/dev/DSP-backend/core"
alias dsf="cd ~/dev/DSP-frontend"
alias sn="cd ~/dev/snippets"
alias ca="cd ~/dev/creative-approval-api"
alias dg4="cd ~/dev/devicegraph-4"

# standard aliases
alias vi="mvim -v"
alias py="ipython"
alias ssh="sshrc $1"

########################################################################
# misc. tools
########################################################################

alias restart_mysql="sudo /usr/local/mysql/bin/mysqld_safe"
alias avt="java -jar ~/Dropbox/avro-tools-1.7.7.jar tojson $1"
alias zshreload="source $DOTFILES_HOME/.zshrc && rsync $DOTFILES_HOME/.zshrc $HOME/."
alias zshconf="vi $DOTFILES_HOME/.zshrc"
alias tpconf="vi $DOTFILES_HOME/.tapadrc"
alias viconf="vi $DOTFILES_HOME/.vimrc"
alias sshconf="vi $DOTFILES_HOME/.sshrc"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias kp="ps aux | percol | awk '{ print $2 }' | xargs kill -9"

psg() { 
  ps -ax | grep -i $1
}

find_big() {
  n=$1
  if [ $# -eq 0 ]; then
      n=5
  fi
  find . -type f -exec ls -s {} \; | sort -n -r | head -$n
}

gcl() {
  grep -i $1 $2 | wc -l
}  

########################################################################
# bash completions
########################################################################

autoload bashcompinit
bashcompinit
source /usr/local/etc/bash_completion.d
source $DOTFILES_HOME/snakebite_completion.sh

########################################################################
# key bindings
########################################################################

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

#copyline() { 
#  printf %s "$READLINE_LINE" | pbcopy; 
#}

#zle -N copyline
#bindkey '\C-k' copyline

########################################################################
# finish
########################################################################
source $DOTFILES_HOME/.tapadrc

# make sure sshrc is in sync
cp -f $DOTFILES_HOME/.sshrc $HOME/.

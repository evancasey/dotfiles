########################################################################
# zsh specific settings
########################################################################

DOTFILES_HOME=$HOME/Dropbox/dotfiles

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

# only enable autocorrect on commands
unsetopt correct_all
setopt correct

set -o emacs

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

fpath=(~/$DOTFILES_DIR/zsh/comletions $fpath)

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

# standard aliases
alias vi="mvim -v"
alias py="ipython"

########################################################################
# misc. tools
########################################################################

alias restart_mysql="sudo /usr/local/mysql/bin/mysqld_safe"
alias avt="java -jar ~/Dropbox/avro-tools-1.7.7.jar tojson $1"
alias zshconf="vi ~/Dropbox/dotfiles/.zshrc"
alias zshreload="source ~/Dropbox/dotfiles/.zshrc"
alias tpconf="vi ~/Dropbox/dotfiles/.tapadrc"
alias viconf="vi ~/Dropbox/dotfiles/.vimrc"
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
# key bindings
########################################################################

#copyline() { 
#  printf %s "$READLINE_LINE" | pbcopy; 
#}

#zle -N copyline
#bindkey '\C-k' copyline
#
bindkey -e

pb-kill-line () {
  zle kill-line
  echo -n $CUTBUFFER | pbcopy
}

pb-kill-whole-line () {
  zle kill-whole-line
  echo -n $CUTBUFFER | pbcopy
}

pb-backward-kill-word () {
  zle backward-kill-word
  echo -n $CUTBUFFER | pbcopy
}

pb-kill-word () {
  zle kill-word
  echo -n $CUTBUFFER | pbcopy
}

pb-kill-buffer () {
  zle kill-buffer
  echo -n $CUTBUFFER | pbcopy
}

pb-copy-region-as-kill-deactivate-mark () {
  zle copy-region-as-kill
  zle set-mark-command -n -1
  echo -n $CUTBUFFER | pbcopy
}

pb-yank () {
  CUTBUFFER=$(pbpaste)
  zle yank
}

zle -N pb-kill-line
zle -N pb-kill-whole-line
zle -N pb-backward-kill-word
zle -N pb-kill-word
zle -N pb-kill-buffer
zle -N pb-copy-region-as-kill-deactivate-mark
zle -N pb-yank

bindkey '^K'   pb-kill-line
bindkey '^U'   pb-kill-whole-line
bindkey '\e^?' pb-backward-kill-word
bindkey '\e^H' pb-backward-kill-word
bindkey '^W'   pb-backward-kill-word
bindkey '^D'   pb-kill-word
bindkey '^X^K' pb-kill-buffer
bindkey '\ew'  pb-copy-region-as-kill-deactivate-mark
bindkey '\eW'  pb-copy-region-as-kill-deactivate-mark
bindkey '^Y'   pb-yank

bindkey '^B' backward-word
bindkey '^W' forward-word
bindkey '^H' backward-char
bindkey '^L' forward-char

########################################################################
# finish
########################################################################

source $DOTFILES_HOME/.tapadrc

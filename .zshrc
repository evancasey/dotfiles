########################################################################
# zsh specific settings
########################################################################

DOTFILES_HOME=$HOME/Dropbox/dotfiles

DISABLE_AUTO_UPDATE=true

# Path to oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# Set zsh theme here
ZSH_THEME='fishy'

# Load and run compinit
autoload -U compinit
compinit -i

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

export PATH="/Users/evan/bin:$PATH"

# Path to mysql
export PATH="/usr/local/mysql/bin:$PATH"

# Path to jdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home

# Path to go
export GOROOT=/usr/local/go
export GOPATH=$HOME/go1.X
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin

# Path to Mujoco deps
export MUJOCO_PY_MJKEY_PATH=$HOME/bin/mjkey.txt
export MUJOCO_PY_MJPRO_PATH=$HOME/bin/mjpro131

# Path to virtualenvwrapper script
source /usr/local/bin/virtualenvwrapper.sh &> /dev/null

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
alias dm="cd ~/dev/demeter"
alias ar="cd ~/dev/aireverie_vision"

# standard aliases
alias vi="vim"
alias py="ipython"

# work aliases
alias pycharm="nohup $HOME/bin/pycharm-community-2017.1.2/bin/pycharm.sh >/dev/null 2>&1 &"

########################################################################
# misc. tools
########################################################################

alias zshreload="source $DOTFILES_HOME/.zshrc"
alias zshconf="vi $DOTFILES_HOME/.zshrc"
alias viconf="vi $DOTFILES_HOME/.vimrc"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias kp="ps aux | percol | awk '{ print $2 }' | xargs kill -9"
alias nvidia-smi="watch -n0.1 nvidia-smi"
#alias autopep="py $HOME/robotics_dev/dev_ws/src/cogitai_robotics/bin/autopep.py"

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

# gcl() {
#  grep -i $1 $2 | wc -l
#}  

ts() { python -c "from datetime import datetime; print(datetime.fromtimestamp($1/1000).strftime('%Y-%m-%d %H:%M:%S.%f'))" }

zulip() {
  pushd ~/opt/zulip-electron
  nohup npm start &
  popd
}

########################################################################
# bash completions
########################################################################

autoload bashcompinit
bashcompinit
#source $DOTFILES_HOME/bash_completion.d

########################################################################
# key bindings
########################################################################

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

########################################################################
# safe-paste plugin
########################################################################

# Code from Mikael Magnusson: http://www.zsh.org/mla/users/2011/msg00367.html
#
# Requires xterm, urxvt, iTerm2 or any other terminal that supports bracketed
# paste mode as documented: http://www.xfree86.org/current/ctlseqs.html

# create a new keymap to use while pasting
bindkey -N paste
# make everything in this keymap call our custom widget
bindkey -R -M paste "^@"-"\M-^?" paste-insert
# these are the codes sent around the pasted text in bracketed
# paste mode.
# do the first one with both -M viins and -M vicmd in vi mode
bindkey '^[[200~' _start_paste
bindkey -M paste '^[[201~' _end_paste
# insert newlines rather than carriage returns when pasting newlines
bindkey -M paste -s '^M' '^J'

zle -N _start_paste
zle -N _end_paste
zle -N zle-line-init _zle_line_init
zle -N zle-line-finish _zle_line_finish
zle -N paste-insert _paste_insert

# switch the active keymap to paste mode
function _start_paste() {
  bindkey -A paste main
}

# go back to our normal keymap, and insert all the pasted text in the
# command line. this has the nice effect of making the whole paste be
# a single undo/redo event.
function _end_paste() {
#use bindkey -v here with vi mode probably. maybe you want to track
#if you were in ins or cmd mode and restore the right one.
  bindkey -e
  LBUFFER+=$_paste_content
  unset _paste_content
}

function _paste_insert() {
  _paste_content+=$KEYS
}

function _zle_line_init() {
  # Tell terminal to send escape codes around pastes.
  [[ $TERM == rxvt-unicode || $TERM == xterm || $TERM = xterm-256color || $TERM = screen || $TERM = screen-256color ]] && printf '\e[?2004h'
}

function _zle_line_finish() {
  # Tell it to stop when we leave zle, so pasting in other programs
  # doesn't get the ^[[200~ codes around the pasted text.
  [[ $TERM == rxvt-unicode || $TERM == xterm || $TERM = xterm-256color || $TERM = screen || $TERM = screen-256color ]] && printf '\e[?2004l'
}

########################################################################
# misc
########################################################################

# gcloud
export PATH=$PATH:/usr/local/gcloud/google-cloud-sdk/bin

# cuda
export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# set pbcopy/pbpaste if on linux
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

# miniconda
export PATH=/home/evan/opt/miniconda3/bin:$PATH

# bin
export PATH=/home/evan/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Evan/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/Evan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Evan/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/Evan/google-cloud-sdk/completion.zsh.inc'; fi

# aireverie
export AIREVERIE_VISION_HOME=/home/evan/dev/aireverie_vision
#export DEMETER_HOME=/home/evan/dev/demeter
export PYTHONPATH=$AIREVERIE_VISION_HOME:$PYTHONPATH
#export PYTHONPATH=$DEMETER_HOME:$PYTHONPATH
export PATH=$AIREVERIE_VISION_HOME/airdrop/bin:$PATH
#export PATH=$DEMETER_HOME/airdrop/bin:$PATH
export TFSLIM=/home/evan/dev/aireverie_vision/third_party/models/research/slim
export PYTHONPATH=$TFSLIM:$PYTHONPATH

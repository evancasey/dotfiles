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

# Path to mysql
export PATH="/usr/local/mysql/bin:$PATH"

# Path to sbt
export PATH="/Users/evan/bin:$PATH"

# Path to jdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home

# Path to Mujoco deps
export MUJOCO_PY_MJKEY_PATH=$HOME/bin/mjkey.txt
export MUJOCO_PY_MJPRO_PATH=$HOME/bin/mjpro131

# Hadoop home
export HADOOP_CLASSPATH="$HOME/bin/hadoop-2.8.0/lib"

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
alias nr="cd ~/dev/narrative"
alias dm="cd ~/dev/demeter"
alias ai="cd ~/dev/aireverie"
alias nr="cd ~/dev/narrative"

# standard aliases
alias vi="vim"
alias py="ipython"

########################################################################
# misc. tools
########################################################################

alias restart_mysql="sudo /usr/local/mysql/bin/mysqld_safe"
alias avt="java -jar ~/Dropbox/avro-tools-1.7.7.jar tojson $1"
alias zshreload="source $DOTFILES_HOME/.zshrc"
alias zshconf="vi $DOTFILES_HOME/.zshrc"
alias viconf="vi $DOTFILES_HOME/.vimrc"
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

ts() { python -c "from datetime import datetime; print(datetime.fromtimestamp($1/1000).strftime('%Y-%m-%d %H:%M:%S.%f'))" }

start_zulip() {
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
# Cogitai 
# TODO: move to .cgtrc
########################################################################

export ROBO_HOME=$HOME/robotics_dev
export PATH=$PATH:$HOME/robotics_dev/docker/bin
# source $ROBO_HOME/dev_ws/devel/setup.zsh

alias pycharm="nohup $HOME/bin/pycharm-community-2017.1.2/bin/pycharm.sh >/dev/null 2>&1 &"
alias robo="$ROBO_HOME/dev_ws/src/cogitai_robotics"

build_robo() {
  cd $ROBO_HOME/dev_ws
  catkin_make -DCMAKE_BUILD_TYPE=RelWithDebInfo
  source $ROBO_HOME/dev_ws/devel/setup.zsh
}

# cuda
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

alias nvidia-smi="watch -n0.1 nvidia-smi"
alias autopep="py $ROBO_HOME/dev_ws/src/cogitai_robotics/config/autopep.py"

# TODO: do not set on osx
#alias pbcopy='xclip -selection clipboard'
#alias pbpaste='xclip -selection clipboard -o'

# miniconda
export PATH=/home/evan/miniconda3/bin:$PATH


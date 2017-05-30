########################################################################
# zsh specific settings
########################################################################

DOTFILES_HOME=$HOME/Dropbox/dotfiles

DISABLE_AUTO_UPDATE=true

# Path to oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

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
alias python="python3"
alias pip="pip3"
alias py="ipython3"
alias ssh="sshrc $1"

########################################################################
# misc. tools
########################################################################

alias restart_mysql="sudo /usr/local/mysql/bin/mysqld_safe"
alias avt="java -jar ~/Dropbox/avro-tools-1.7.7.jar tojson $1"
alias zshreload="source $DOTFILES_HOME/.zshrc && rsync $DOTFILES_HOME/.zshrc $HOME/."
alias zshconf="vi $DOTFILES_HOME/.zshrc && rsync $DOTFILES_HOME/.zshrc $HOME/."
alias viconf="vi $DOTFILES_HOME/.vimrc && rsync $DOTFILES_HOME/.vimrc $HOME/."
alias sshconf="vi $DOTFILES_HOME/.sshrc && rsync $DOTFILES_HOME/.sshrc $HOME/."
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias kp="ps aux | percol | awk '{ print $2 }' | xargs kill -9"
alias nr="cd ~/dev/narrative"

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
# Cogitai 
# TODO: move to .cgtrc
########################################################################

export SONY_HOME=$HOME/sony
export PATH=$PATH:$HOME/sony/docker/bin
source $SONY_HOME/sony_ws/devel/setup.zsh

alias pycharm="nohup $HOME/bin/pycharm-community-2017.1.2/bin/pycharm.sh >/dev/null 2>&1 &"
alias sn="cd $SONY_HOME"

build_sony() {
  source $SONY_HOME/ros_overlay_ws/install_isolated/setup.zsh
  cd ~/sony/sony_ws
  catkin_make -DCMAKE_BUILD_TYPE=RelWithDebInfo
  source $SONY_HOME/sony_ws/devel/setup.zsh
}

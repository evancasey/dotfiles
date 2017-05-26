curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | /usr/bin/zsh

DOTFILES_HOME=$HOME/Dropbox/dotfiles

cp $DOTFILES_HOME/.vimrc $HOME
cp $DOTFILES_HOME/.zshrc $HOME

wget https://github.com/VundleVim/Vundle.vim/archive/master.zip \
  && unzip master.zip -d ~/.vim/bundle/Vundle.vim \
  && rm master.zip

vim +PluginInstall +qall


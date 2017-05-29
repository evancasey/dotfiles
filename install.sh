curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | /usr/bin/zsh

wget https://github.com/evancasey/dotfiles/raw/master/.vimrc -P $HOME
wget https://github.com/evancasey/dotfiles/raw/master/.zshrc -P $HOME

VUNDLE_HOME='$HOME/.vim/bundle'

wget -P $VUNDLE_HOME https://github.com/VundleVim/Vundle.vim/archive/master.zip \

cd $VUNDLE_HOME \
  && unzip master.zip -d Vundle.vim \
  && rm master.zip

vim +PluginInstall +qall


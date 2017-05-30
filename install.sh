curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | /usr/bin/zsh

wget https://github.com/evancasey/dotfiles/raw/master/.vimrc -P $HOME
wget https://github.com/evancasey/dotfiles/raw/master/.zshrc -P $HOME

VUNDLE_HOME=$HOME/.vim/bundle

mkdir -p $VUNDLE_HOME && cd $VUNDLE_HOME

wget -O Vundle.vim.zip https://github.com/VundleVim/Vundle.vim/archive/master.zip

unzip Vundle.vim.zip \
  && mv Vundle.vim-master Vundle.vim \
  && rm Vundle.vim.zip

wget -O vim-colors-solarized https://github.com/altercation/vim-colors-solarized/archive/master.zip

unzip vim-colors-solarized.zip \
  && mv vim-colors-solarized-master vim-colors-solarized.vim \
  && rm Vundle.vim.zip

COLORS_HOME=$HOME/.vim/colors
mkdir -p $COLORS_HOME

wget https://github.com/evancasey/dotfiles/raw/master/solarized.vim -P $COLORS_HOME

vim +PluginInstall +qall


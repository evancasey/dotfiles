sudo apt-get install curl zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# absolute paths needed for symlinks
ln -sf /home/$(whoami)/Dropbox/dotfiles/.zshrc /home/$(whoami)/.zshrc
ln -sf /home/$(whoami)/Dropbox/dotfiles/.vimrc /home/$(whoami)/.vimrc

VUNDLE_HOME=$HOME/.vim/bundle

mkdir -p $VUNDLE_HOME && cd $VUNDLE_HOME

wget -O Vundle.vim.zip https://github.com/VundleVim/Vundle.vim/archive/master.zip

unzip Vundle.vim.zip \
  && mv Vundle.vim-master Vundle.vim \
  && rm Vundle.vim.zip

wget -O vim-atomified.zip https://github.com/siphalor/vim-atomified/archive/master.zip

unzip vim-atomified.zip \
  && mv vim-atomified-master vim-atomified \
  && rm vim-atomified.zip

COLORS_HOME=$HOME/.vim/colors
mkdir -p $COLORS_HOME

wget https://github.com/evancasey/dotfiles/raw/master/atomified.vim -P $COLORS_HOME

vim +PluginInstall +qall

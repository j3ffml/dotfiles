#!/usr/bin/sh

#copy .vimrc
cp vimrc ~/.vimrc

# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -so ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# install other plugins to be loaded by pathogen
cd ~/.vim/bundle

# NERDTree - directory explorer
git clone https://github.com/scrooloose/nerdtree.git
# ctrlp - full path fuzzy finder
git clone https://github.com/kien/ctrlp.vim.git

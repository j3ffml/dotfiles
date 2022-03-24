#!/bin/bash

# setup oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
if [ -e "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc_old"
fi

CONF_LIST="ackrc  bashrc  screenrc  vim  vimrc  zsh.prompt  zshrc"
for CONF in $CONF_LIST; do
    SRC="$PWD/$CONF"
    DEST="$HOME/.$CONF"
    if [[ -f "$DEST" ]]; then
	mv $DEST $DEST_old
    fi
    ln -sv $SRC $DEST
done
# i3config doesn't follow above pattern
ln -sv "$PWD/i3config" "$HOME/.config/i3/config"

# clone Vundle.
git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "run :VundleInstall from within vim to install bundles"

if [[ `uname -a` == *"Darwin"* ]]; then
  echo "Install iterm2 from iterm2.com"
  echo "Install fonts at $PWD/util/fonts"
# ubuntu customizations
elif [[ `uname -a` == *"ubuntu"* || `uname -a` == *"Linux"* ]]; then
  # install some powerline fonts. Menlo for Powerline preferred
  mkdir -p $HOME/.local/share/fonts/
  cp util/fonts/* $HOME/.local/share/fonts/

  gconftool --set --type string /apps/metacity/general/button_layout \
    :minimize,maximize,close
  #TODO test this next install
  git clone git://github.com/Anthony25/gnome-terminal-colors-solarized.git thirdparty/gnome-terminal-colors-solarized\
    && sh thirdparty/gnome-terminal-colors-solarized/set_dark.sh
elif [[ `uname -a` == *"Cygwin"* ]]; then
  # solarized dark colors for cygwin
  ln -sv "$PWD/.minttyrc" $HOME
fi


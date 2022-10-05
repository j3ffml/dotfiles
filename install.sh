#!/bin/bash

# setup oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
if [ -e "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc_old"
fi

CONF_LIST="bashrc  gitconfig vim  vimrc zshrc zsh.prompt"
for CONF in $CONF_LIST; do
    SRC="$PWD/$CONF"
    DEST="$HOME/.$CONF"
    DEST_OLD="$HOME/.$CONF""_old"
    if [[ -f "$DEST" ]]; then
	mv "$DEST" "$DEST_OLD"
    fi
    ln -sv "$SRC" "$DEST"
done
# i3config doesn't follow above pattern
#ln -sv "$PWD/i3config" "$HOME/.config/i3/config"

# clone Vundle.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "run :VundleInstall from within vim to install bundles"

OS="$(uname -a)"
if [[ "$OS" == *"Darwin"* ]]; then
  echo "Install iterm2 from iterm2.com"
  echo "Install fonts at $PWD/util/fonts"
# ubuntu customizations
elif [[ "$OS" == *"ubuntu"* || "$OS" == *"Linux"* ]]; then
  # install some powerline fonts. Menlo for Powerline preferred
  mkdir -p "$HOME/.local/share/fonts/"
  cp util/fonts/* "$HOME/.local/share/fonts/"

  #TODO test this next install
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git thirdparty/gnome-terminal-colors-solarized\
    && sh thirdparty/gnome-terminal-colors-solarized/set_dark.sh
elif [[ "$OS" == *"Cygwin"* ]]; then
  # solarized dark colors for cygwin
  ln -sv "$PWD/.minttyrc" "$HOME"
fi


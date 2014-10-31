#! /bin/bash

HOME="/Users/alan"
BASH_HOME=$(pwd)

echo "$BASH_HOME is my root"

if [ ! -d "$BASH_HOME/vim" ]; then
	git submodule add https://github.com/drmikehenry/vimfiles.git $BASH_HOME/vim
fi

ln -sf $BASH_HOME/vim $HOME/.vim
ln -sf $BASH_HOME/vim/vimrc $HOME/.vimrc
ln -sf $BASH_HOME/gvimrc $HOME/.gvimrc
ln -sf $BASH_HOME/gitconfig $HOME/.gitconfig

if [ ! -f "$HOME/.bashrc" ]; then
	touch $HOME/.bashrc
fi

echo ". $BASH_HOME/bash_profile" >> $HOME/.bashrc
source $HOME/.bashrc
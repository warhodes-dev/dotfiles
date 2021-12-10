#!/bin/bash
rm ~/.config/nvim/init.vim
rm ~/.vim/autoload/plug.vim
mkdir -p ~/.config/nvim
mkdir -p ~/.vim/autoload
ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/nvim/plug.vim ~/.vim/autoload/plug.vim

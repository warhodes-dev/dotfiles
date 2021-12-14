#!/bin/bash
rm ~/.config/nvim/init.vim
rm ~/.config/nvim/autoload/plug.vim
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/autoload
ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/nvim/plug.vim ~/.config/nvim/autoload/plug.vim

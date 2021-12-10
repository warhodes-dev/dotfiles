#!/bin/bash
rm ~/.config/yed/yedrc
rm ~/.config/yed/ypm_list
rm ~/.config/yed/my_styles/bourbon.fstyle
ln -s ~/dotfiles/yed/yedrc ~/.config/yed/yedrc
ln -s ~/dotfiles/yed/ypm_list ~/.config/yed/ypm_list
mkdir ~/.config/yed/my_styles
ln -s ~/dotfiles/yed/my_styles/bourbon.fstyle ~/.config/yed/my_styles/bourbon.fstyle

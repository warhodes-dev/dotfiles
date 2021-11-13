dotfiles=$(dirname "$0")
rm ~/.config/yed/yedrc
rm ~/.config/yed/ypm_list
ln -s ~/"$dotfiles"/.config/yed/yedrc ~/.config/yed/yedrc
ln -s ~/"$dotfiles"/.config/yed/ypm_list ~/.config/yed/ypm_list
ln -s ~/"$dotfiles"/.config/yed/my_styles/bourbon.fstyle ~/.config/yed/my_styles/bourbon.fstyle

#!/bin/bash

#bashrc symlink
ln -sf ~/config_files/.bashrc ~/.bashrc

#vimrc symlink
ln -sf ~/config_files/vim/.vimrc ~/.vimrc

#for xmledit in vim, link the xml.vim file to html.vim
#otherwise, tag completions won't work in erb and the like
ln -s ~/.vim/plugged/xmledit/ftplugin/xml.vim ~/.vim/plugged/xmledit/ftplugin/html.vim

#.vim/after symlink
mkdir -p ~/.vim/after/plugin
ln -sf ~/config_files/vim/after/plugin/disable_mappings.vim ~/.vim/after/plugin/disable_mappings.vim

#zshrc symlink
ln -sf ~/config_files/zsh/.zshrc ~/.zshrc

# inputrc - added so that IRB will use vi-mode
ln -sf ~/config_files/.inputrc ~/.inputrc
#gitconfig symlink
ln -sf ~/config_files/.gitconfig ~/.gitconfig

#elinks symlinks
#first is for mint/lubuntu, second is for arch
#ln -sf ~/config_files/.elinks_conf ~/.elinks/elinks.conf
ln -sf ~/config_files/.elinks_conf ~/.elinks.conf

#xinit symlink
ln -sf ~/config_files/.xinitrc ~/.xinitrc

#xmodmap symlink - for caps/esc
ln -sf ~/config_files/.xmodmap_custom_mappings ~/.Xmodmap

# toprc symlink
ln -sf ~/config_files/.toprc ~/.toprc

# i3 config symlink
ln -sf ~/config_files/i3/i3_config ~/.config/i3/config

# i3status/config symlink
ln -sf ~/config_files/i3/i3_status_config ~/.config/i3status/config

# compton config symlink
ln -sf ~/config_files/compton.conf ~/.config/compton.conf

# Xterm configuration - using Xresources
 ln -sf ~/config_files/.Xresources ~/.Xresources

# ranger config symlink
ln -sf ~/config_files/ranger/rc.conf ~/.config/ranger/rc.conf

# ranger commands symlink
ln -sf ~/config_files/ranger/commands.py ~/.config/ranger/commands.py

# ranger scope symlink (scope controls external scripts) ; mainly changing to enable pdf previews
ln -sf ~/config_files/ranger/scope.sh ~/.config/ranger/scope.sh

# tmux symlink
ln -sf ~/config_files/.tmux.conf ~/.tmux.conf

#ultisnips folder symlink
# T switch tells ln to treat any existing link as just a file (stop recursive
# nesting of UltiSnips dir)
ln -sfT ~/config_files/vim/UltiSnips/ ~/.vim/UltiSnips

# cmus rc symlink
ln -sf ~/config_files/cmus_rc ~/.config/cmus/rc

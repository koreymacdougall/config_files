#!/bin/bash

#terminator symlink
ln -sf ~/config_files/.terminator_config ~/.config/terminator/config

#bashrc symlink
ln -sf ~/config_files/.bashrc ~/.bashrc

#vimrc symlink
ln -sf ~/config_files/.vimrc ~/.vimrc

#.vim/after symlink
mkdir -p ~/.vim/after/plugin
ln -sf ~/config_files/.vim/after/plugin/disable_mappings.vim ~/.vim/after/plugin/disable_mappings.vim

#zshrc symlink
ln -sf ~/config_files/.zshrc ~/.zshrc

#zshenv symlink
ln -sf ~/config_files/.zprofile ~/.zprofile

#gitconfig symlink
ln -sf ~/config_files/.gitconfig ~/.gitconfig

#elinks symlinks
#first is for mint/lubuntu, second is for arch
ln -sf ~/config_files/.elinks_conf ~/.elinks/elinks.conf
ln -sf ~/config_files/.elinks_conf ~/.elinks.conf

#snippets symlink
ln -sf  ~/config_files/.vim_snippets/.skeleton.html ~/.vim/.skeleton.html

#xmledit plugin for vim - symlink so it works on html & erb
ln -sf ~/.vim/plugged/xmledit/ftplugin/xml.vim ~/.vim/plugged/xmledit/ftplugin/html.vim

#xinit symlink
ln -sf ~/config_files/.xinitrc ~/.xinitrc

#xmodmap symlink - for caps/esc
ln -sf ~/config_files/.xmodmap_custom_mappings ~/.Xmodmap

# toprc symlink
ln -sf ~/config_files/.toprc ~/.toprc

# xfce4 keyboard shortcuts symlink
ln -sf ~/config_files/xfce4-keyboard-shortcuts.xml \
    ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

# i3 config symlink
ln -sf ~/config_files/i3_config ~/.config/i3/config

# compton config symlink
ln -sf ~/config_files/compton.conf ~/.config/compton.conf

# Xterm configuration
ln -sf ~/config_files/.Xdefaults ~/.Xdefaults

# ranger config symlink
ln -sf ~/config_files/rc.conf ~/.config/ranger/rc.conf

# ranger scope symlink (scope controls external scripts)
# mainly changing to enable pdf previews
ln -sf ~/config_files/scope.sh ~/.config/ranger/scope.sh

#!/bin/bash
ln -sf ~/config_files/.terminator_config ~/.config/terminator/config

#rm ~/.vimrc
ln -sf ~/config_files/.vimrc ~/.vimrc

#first is for mint/lubuntu, second is for arch
ln -sf ~/config_files/.elinks_conf ~/.elinks/elinks.conf
ln -sf ~/config_files/.elinks_conf ~/.elinks.conf

ln -sf  ~/config_files/.vim_snippets/.skeleton.html ~/.vim/.skeleton.html

#make symlinks for xmledit to work on both html and erb files
ln -sf ~/.vim/plugged/xmledit/ftplugin/xml.vim ~/.vim/plugged/xmledit/ftplugin/html.vim

#this currently works on arch... I don't know about bunt/deb derivs
ln -sf ~/config_files/.us.map.custom.gz /usr/share/kbd/keymaps/i386/qwerty
sudo localectl set-keymap --no-convert us.map.custom

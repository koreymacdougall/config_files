#!/bin/bash
ln -sf ~/config_files/.terminator_config ~/.config/terminator/config

#bashrc symlink
ln -sf ~/config_files/.bashrc ~/.bashrc

#vimrc symlink
ln -sf ~/config_files/.vimrc ~/.vimrc

#zshrc symlink
ln -sf ~/config_files/.zshrc ~/.zshrc

#gitconfig symlink
ln -sf ~/config_files/.gitconfig ~/.gitconfig

#elinks eymlinks
#first is for mint/lubuntu, second is for arch
ln -sf ~/config_files/.elinks_conf ~/.elinks/elinks.conf
ln -sf ~/config_files/.elinks_conf ~/.elinks.conf

#snippets symlink
ln -sf  ~/config_files/.vim_snippets/.skeleton.html ~/.vim/.skeleton.html

#xmledit plugin for vim - symlink so it works on html & erb
ln -sf ~/.vim/plugged/xmledit/ftplugin/xml.vim ~/.vim/plugged/xmledit/ftplugin/html.vim

#keyboard map symlinks
#this currently works on arch... I don't know about bunt/deb derivs
ln -sf ~/config_files/.us.map.custom.gz /usr/share/kbd/keymaps/i386/qwerty

bash .xinitrc

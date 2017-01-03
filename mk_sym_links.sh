#!/bin/bash
rm ~/.config/terminator/config
ln -s ~/config_files/.terminator_config ~/.config/terminator/config
rm ~/.vimrc
ln -s ~/config_files/.vimrc ~/.vimrc
#make symlinks for xmledit to work on both html and erb files
ln -s ~/.vim/plugged/xmledit/ftplugin/xml.vim ~/.vim/plugged/xmledit/ftplugin/html.vim
rm ~/.elinks/elinks.conf
ln -s ~/config_files/.elinks_conf ~/.elinks/elinks.conf
#for xmodmap and xinitrc...run manually? 

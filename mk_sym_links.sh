#!/bin/bash
#rm ~/.config/terminator/config
ln -sf ~/config_files/.terminator_config ~/.config/terminator/config

#rm ~/.vimrc
ln -sf ~/config_files/.vimrc ~/.vimrc

#rm ~/.elinks/elinks.conf
ln -sf ~/config_files/.elinks_conf ~/.elinks/elinks.conf

#rm ~/.vim/.skeleton.html
ln -sf  ~/config_files/.vim_snippets/.skeleton.html ~/.vim/.skeleton.html

#make symlinks for xmledit to work on both html and erb files
#rm ~/.vim/plugged/xmledit/ftplugin/html.vim
ln -sf ~/.vim/plugged/xmledit/ftplugin/xml.vim ~/.vim/plugged/xmledit/ftplugin/html.vim

#for xmodmap and xinitrc...run manually? 



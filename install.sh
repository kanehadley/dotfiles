#! /bin/sh

ln -is $(readlink -f tmux.conf) ~/.tmux.conf;

mkdir -p ~/.config/ghostty/
ln -is $(readlink -f config/ghostty/config.ghostty) ~/.config/ghostty/config.ghostty;

mkdir -p ~/.emacs.d/
ln -is $(readlink -f emacs/emacs.d/init.el) ~/.emacs.d/init.el;
ln -is $(readlink -f emacs/emacs.d/early-init.el) ~/.emacs.d/early-init.el;

ln -is $(readlink -f vimrc) ~/.vimrc;
ln -is $(readlink -f zshrc) ~/.zshrc;

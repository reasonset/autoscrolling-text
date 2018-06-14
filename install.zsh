#!/usr/bin/zsh

install -m 755 -d ${XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text ~/bin
install -v -m 644 scrollingtext.css scrollingtext.js ${XDG_CONFIG_HOME:-$HOME/.config}/autoscroll-text
install -v -m 755 autoscroll-text.zsh ~/bin/autoscroll-text

#!/bin/sh

#setxkbmap jp

eval "$(dbus-launch --sh-syntax --exit-with-session)"

#export XDG_CONFIG_HOME=/home/sksat

export EDITOR=vim
export TERMINAL=tilix

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

fcitx-autostart
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

exec i3

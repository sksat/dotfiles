#!/bin/sh

session=${1:-i3}

fcitx-autostart
#[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
.screenlayout/default.sh

case $session in
	i3		) exec i3;;
	kde		) exec startplasma-x11;;
	gnome	) exec gnome-session ;;
	*) exec $1;;
esac

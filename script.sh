#!/bin/sh

if [ $# -ne 2 ]; then
	exit
fi

HOME=$1
CMD=$2

DIR=$(cd $(dirname $0); pwd)

install(){
	TARGET="$HOME/$1"
	TDIR=`dirname $TARGET`
	[ -d $TDIR ] || mkdir -p $TDIR
	DOTFILE=$DIR/$1
	#echo "install $DOTFILE..."
	ln -snbfv "$DOTFILE" "$HOME"/"$1"
}

dotfiles(){
	for f in `find . -type f -name '.*'`; do
		if [ $f = "./.gitignore" ]; then
			continue
		fi
		eval "$CMD ${f#./}"
	done
	for f in `find .config -type f`; do
		eval "$CMD $f"
	done
}

dotfiles install

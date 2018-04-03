#!/bin/sh

if [ $# -ne 2 ]; then
	exit
fi

HOME=$1
CMD=$2

install(){
	TARGET="$HOME/$1"
	TDIR=`dirname $TARGET`
	[ -d $TDIR ] || mkdir -p $TDIR
	#echo "install $1..."
	ln -snbfv "$1" "$HOME"/"$1"
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

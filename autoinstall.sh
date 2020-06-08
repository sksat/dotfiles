#!/bin/sh

GIT_REPO="https://github.com/sk2sat/dotfiles"
DOTPATH=/home/sksat/dotfiles

if [ -d $DOTPATH ];then
	cd $DOTPATH
	make update
	exit
fi
if [ ! `which git` ]; then
	echo "please install git"
	exit
fi

git clone $GIT_REPO $DOTPATH

cd $DOTPATH
make install

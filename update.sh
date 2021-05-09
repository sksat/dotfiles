#!/bin/bash
# vim: set ft=sh ff=unix fileencoding=utf-8 ts=4 sw=4 :
cd `dirname $0`

source install.sh

function print_if_not_exist(){
	local TARGET=$1
	local FILE=$2

	if [ ! -f $TARGET/$FILE ]; then
		echo $FILE
	fi
}

function main(){
	local DIR=$1
	local TARGET=$2

	export -f print_if_not_exist
	export -f install_file
	export -f create_target_dir
	export -f backup_exist

	echo "update"
	git pull origin master

	local FILES=`list_files files | xargs -i bash -c "print_if_not_exist $HOME '{}'"`
	if [ ! -z $FILES ]; then
		echo "install newly added dot files..."
		echo $FILES | xargs -i bash -c "install_file files $HOME '{}'"
	fi

	local CFGS=`list_files config | xargs -i bash -c "print_if_not_exist $XDG_CONFIG_HOME '{}'"`

	echo CFGS $CFGS
	if [ ! -z "$CFGS" ]; then
		echo "install newly added XDG config files..."
		echo $CFGS | xargs -i bash -c "install_file config $XDG_CONFIG_HOME '{}'"
	fi
}

# disable execute main when source
return 1 2>/dev/null || true

if [ ! -f ./config/environment.d/gen.conf ]; then
	echo "probably not yet installed"
	exit 1
fi

main | tee ${LOGDIR}/${DATE}-update.log

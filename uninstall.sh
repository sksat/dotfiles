#!/bin/bash
# vim: set ft=sh ff=unix fileencoding=utf-8 ts=4 sw=4 :
cd `dirname $0`

source install.sh

function restore_backup(){
	local TARGET=$1
	if [ -f $TARGET.bak ]; then
		echo -e "  [restore] ${TARGET} <=== ${TARGET}.bak"
		mv ${TARGET}.bak $TARGET
	fi
}

function uninstall_file(){
	local SRC=$1
	local TARGET=$2
	local FILE=$3

	echo -e "  [unlink]  ${TARGET}/${FILE}"
	unlink $TARGET/$FILE
	restore_backup $TARGET/$FILE
}

function uninstall_all(){
	echo "HOME = ${HOME}"
	echo "XDG_CONFIG_HOME = ${XDG_CONFIG_HOME}"
	echo ""

	export -f restore_backup
	export -f uninstall_file

	echo "uninstall dot files..."
	list_files files | xargs -i bash -c "uninstall_file files $HOME '{}'"
	echo ""

	echo "uninstall XDG config files..."
	list_files config | xargs -i bash -c "uninstall_file config $XDG_CONFIG_HOME '{}'"
}

function main(){
	uninstall_all
}

# disable execute main when source
return 1 2>/dev/null || true

if [ ! -f ./config/systemd/environment.d/base.conf ]; then
	echo "probably not yet installed"
	exit 1
fi
source ./config/systemd/environment.d/base.conf
main | tee ${LOGDIR}/${DATE}-uninstall.log

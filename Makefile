HOME		= /home/sksat
LOGDIR	= ./log

help:
	@echo help

install:
	@make list_files --no-print-directory | xargs -i make --no-print-directory install_file SRC="{}"
	make install_dconf

update:
	git fetch
	git pull origin master
	make install_dconf

uninstall:
	@make list_files --no-print-directory | xargs -i make --no-print-directory uninstall_file SRC="{}"

reinstall:
	make uninstall
	make install

list_dconf:
	@find dconf -type f | sed -e 's/dconf//'

dump_dconf:
	@make list_dconf --no-print-directory | tee /dev/stderr | xargs -i sh -c "dconf dump {}/ > ./dconf{}"

install_dconf:
	@make list_dconf --no-print-directory | tee /dev/stderr | xargs -i echo "dconf load {}/ < ./dconf{}"

list: list_files

install_file:
	@echo -e "install ${SRC}"
	@make --no-print-directory target_dir DIR=`dirname ${HOME}/${SRC}`
	@make check_exist TARGET="${HOME}/${SRC}"
	@echo -en "\tlink: "
	@ln -snbfvr files/${SRC} ${HOME}/${SRC}

uninstall_file:
	@if [ -f "${HOME}/${SRC}" ]; then echo "uninstall ${HOME}/${SRC}"; rm ${HOME}/${SRC}; fi
	@if [ -f "${HOME}/${SRC}.bak" ]; then echo -e "\trestore from backup: ${HOME}/${SRC}.bak"; mv ${HOME}/${SRC}.bak ${HOME}/${SRC}; fi

check_exist:
	@if [ -f ${TARGET} ]; then echo -e "\twarning: file exist"; make backup_file; fi

backup_file:
	@echo -e "\t${TARGET} -> ${TARGET}.bak"
	@mv ${TARGET} ${TARGET}.bak

target_dir:
	@if [ ! -d ${DIR} ]; then echo -e "\tcreate directory: ${DIR}";mkdir -p ${DIR}; fi

list_files:
	@find files/ -mindepth 1 -type f | sed 's/files\///'

list_notinstalled:
	@make --no-print-directory list_files | xargs -i make --no-print-directory file_notinstalled FILE={}

file_notinstalled:
	@if [ ! -f ${HOME}/${FILE} ]; then echo ${FILE}; fi

.ONESHELL:

HOME			?= /home/sksat
XDG_CONFIG_HOME	?= ${HOME}/.config
LOGDIR			?= ./log

help:
	@echo help

check:
	@echo "HOME = ${HOME}"
	@echo "XDG_CONFIG_HOME = ${XDG_CONFIG_HOME}"
	@echo "LOGDIR = ${LOGDIR}"

install:
	@make check
	@echo "install dot files"
	@make list_files --no-print-directory \
		| xargs -i make --no-print-directory install_file FILE="{}" SRC=files TARGET=${HOME}
	@echo "install XDG_CONFIG_HOME files"
	@make list_xdg_config_files --no-print-directory \
		| xargs -i make --no-print-directory install_file FILE="{}" SRC=config TARGET=${XDG_CONFIG_HOME}
	make install_dconf

update:
	git fetch
	git pull origin master
	make install_dconf

uninstall:
	@make list_files --no-print-directory \
		| xargs -i make --no-print-directory uninstall_file FILE="{}" TARGET=${HOME}
	@make list_xdg_config_files --no-print-directory \
		| xargs -i make --no-print-directory uninstall_file FILE="{}" TARGET=${XDG_CONFIG_HOME}

reinstall:
	make uninstall
	make install

list_xdg_config_files:
	@find config/ -mindepth 1 -type f | sed 's/config\///'

list_dconf:
	@find dconf -type f | sed -e 's/dconf//'

dump_dconf:
	@make list_dconf --no-print-directory | tee /dev/stderr | xargs -i sh -c "dconf dump {}/ > ./dconf{}"

install_dconf:
	@make list_dconf --no-print-directory | tee /dev/stderr | xargs -i echo "dconf load {}/ < ./dconf{}"

list: list_files

install_file:
	@echo -e "install ${FILE} to ${TARGET}"
	@make --no-print-directory target_dir DIR=`dirname ${TARGET}/${FILE}`
	@make check_exist TARGET="${TARGET}/${FILE}"
	@echo -en "\tlink: "
	@ln -snbfvr ${SRC}/${FILE} ${TARGET}/${FILE}

uninstall_file:
	@if [ -f "${TARGET}/${FILE}" ]; then \
		echo "uninstall ${TARGET}/${FILE}"; \
		rm ${TARGET}/${FILE}; \
	fi
	@if [ -f "${TARGET}/${FILE}.bak" ]; then \
		echo -e "\trestore from backup: ${TARGET}/${FILE}.bak"; \
		mv ${TARGET}/${FILE}.bak ${TARGET}/${FILE}; \
	fi

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

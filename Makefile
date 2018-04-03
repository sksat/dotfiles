HOME	= /home/sksat
#HOME	= ./test
LOGFILE	= ./log.txt

LOGGING	= tee -a $(LOGFILE)

default:
	make install

list:
	@sh list.sh

install:
	@make log
	@make install_main 2>&1 | $(LOGGING)

update: install
	@make log
	@make update_main 2>&1 | $(LOGGING)

uninstall:
	@make log
	@make uninstall_main 2>&1 | $(LOGGING)

log:
	@[ ! -f $(LOGFILE) ] || mv $(LOGFILE) $(LOGFILE).org

error:
	$(error $(MSG))

install_main:
	@echo "start install..."
	sh script.sh $(HOME) install
	@date > install
	@echo "install finished!"

update_main:
	@echo "start update..."
	git fetch
	git pull origin master
	@date > last_update
	@echo "update finished!"

uninstall_main:
	@echo "start uninstall..."
	@[ -f install ] || make error MSG="not installed"
	@[ ! -f last_update ] || rm last_update
	rm install
	@echo "uninstall finished!"

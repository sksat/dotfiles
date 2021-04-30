#!/bin/bash

GIT_REPO="https://github.com/sksat/dotfiles"
DOTPATH=$HOME/dotfiles
PUBKEYS=("https://sksat.net/pgp.txt" "https://sksat.pub/pgp")
FINGERPRINT="A5F9 5E92 A7EF B190 A818  9609 A450 0EC5 DD16 4E44"

if [ -z $DOTBRANCH ]; then
	DOTBRANCH="master"
fi

# check distro
if [ -e /etc/os-release ];then
	name=`cat /etc/os-release | head -n1`
	name=${name:6}
	distro=${name::-1}
else
	echo "/etc/os-release does not exist"
	exit
fi
echo "Distribution: "$distro

# check user
SUDO=""
if [ "$(whoami)" != "root" ]; then
	SUDO="sudo"
fi

# package manager
function install_pkg () {
	if [ $# = 0 ]; then
		return
	fi
	case $distro in
		"Ubuntu") $SUDO apt install -y $@ ;;
		"Arch Linux") {
			if (type yay > /dev/null 2>&1); then
				yay -S --noconfirm $@
			else
				$SUDO pacman -S --noconfirm $@
			fi
		} ;;
		*) exit
	esac
}

# check dependencies
cmd_deps=("curl" "git" "gpg")
#cmd_deps("")
pkgs=""
for d in ${cmd_deps[@]}; do
	if !(type $d > /dev/null 2>&1); then
		echo $d is not installed
		deps+=" $d"
	fi
done
echo "install packages: $deps"
install_pkg $deps

# check pubkeys
echo "import GitHub public key"
curl 'https://github.com/web-flow.gpg' | gpg --import

echo "pubkey fingerprint: $FINGERPRINT"
for url in $PUBKEYS; do
	echo -n "pubkey from $url: "
	p=$(curl $url 2>/dev/null)
	pubkey+=( "$p" )
	f=$(echo "$p" | gpg --show-keys --with-fingerprint | head -n2 | tail -n1)
	f=${f:6}
	echo $f
	if [ "$f" != "$FINGERPRINT" ]; then
		echo -e "\e[31mError. Human is Dead, mismatch.\e[m"
		exit -1
	fi
done
echo "$p" | gpg --import

if [ -d $DOTPATH ];then
	echo "$DOTPATH is already exists. execute update"
	cd $DOTPATH
	./update.sh
	exit
fi

git clone $GIT_REPO $DOTPATH
cd $DOTPATH
git switch $DOTBRANCH

echo "\nverify commit"
git verify-commit HEAD -v
echo ""

if [ $? -ne 0 ]; then
	echo -e "\e[31mError. Human is Dead, mismatch.\e[m"
	exit -1
fi

./install.sh

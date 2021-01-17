#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR=vim
export TERMINAL=tilix

export GTKIMMODULE_ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export QSYS_ROOTDIR="/home/sksat/.cache/yay/quartus-free/pkg/quartus-free/opt/altera/19.1/quartus/sopc_builder/bin"

gpgconf --launch gpg-agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

exec fish
source "$HOME/.cargo/env"

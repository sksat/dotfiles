#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=vim
export TERMINAL=tilix

export QSYS_ROOTDIR="$HOME/.cache/yay/quartus-free/pkg/quartus-free/opt/altera/19.1/quartus/sopc_builder/bin"

gpgconf --launch gpg-agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

exec fish
source "$HOME/.cargo/env"

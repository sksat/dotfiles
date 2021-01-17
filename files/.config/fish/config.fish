set PATH $HOME/.cargo/bin $PATH $HOME/go/bin "/opt/TD1909/bin" "/var/lib/snapd/snap/bin" "/opt/riscv-toolchain/bin"

alias vi="nvim"
alias vim="nvim"
alias vivado="/tools/Xilinx/Vivado/2019.1/bin/vivado"
alias tdide="/opt/TD1909/bin/td -gui"

alias 須藤="sudo"
alias 自害="shutdown -P now"

# opam configuration
source /home/sksat/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

status --is-interactive; and source (rbenv init -|psub)
thefuck --alias | source

set PATH $HOME/.cargo/bin $PATH $HOME/go/bin "/opt/TD1909/bin" "/var/lib/snapd/snap/bin" "/opt/riscv-toolchain/bin"

#eval (ssh-agent -c)
alias ssh=ssh-ident

alias vi="nvim"
alias vim="nvim"
alias vivado="/tools/Xilinx/Vivado/2019.1/bin/vivado"
alias tdide="/opt/TD1909/bin/td -gui"

alias 須藤="sudo"
alias 自害="shutdown -P now"
alias rust-musl-builder="sudo docker run --rm -it -v (pwd):/home/rust/src ekidd/rust-musl-builder"

# opam configuration
source /home/sksat/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

status --is-interactive; and source (rbenv init -|psub)
thefuck --alias | source

# fish plugin
fundle plugin 'edc/bass'
fundle plugin 'acomagu/fish-async-prompt'
fundle plugin 'oh-my-fish/plugin-peco'
fundle plugin 'oh-my-fish/plugin-bang-bang'
fundle plugin 'pure-fish/pure'

fundle init

# key bind

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

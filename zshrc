ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(vi-mode git bundler gem rbenv npm autojump thor)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

function gvim () { (/usr/bin/gvim -f "$@" 1> /dev/null &) }
function subl () { (/usr/bin/sublime "$@" 1> /dev/null &) }
function open () { (/usr/bin/xdg-open "$@" 1> /dev/null &) }

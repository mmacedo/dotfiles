ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git bundler gem rbenv npm autojump thor heroku pip virtualenvwrapper mvn)

source $ZSH/oh-my-zsh.sh

# annoying, don't enable
unsetopt correct_all
# necessary for git-achievements
setopt complete_aliases

function gvim () { (/usr/bin/gvim -f "$@" 1> /dev/null &) }
function subl () { (/usr/bin/subl "$@" 1> /dev/null &) }
function open () { (/usr/bin/xdg-open "$@" 1> /dev/null &) }
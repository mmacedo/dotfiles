ZSH=$HOME/.oh-my-zsh
ZSH_THEME="fino"

plugins=(git git-extras bundler gem rbenv npm autojump thor heroku pip virtualenvwrapper history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# annoying, don't enable
unsetopt correct_all
# necessary for git-achievements
setopt complete_aliases

# setup ADT paths
export ANDROID_SDK_HOME="/home/mmacedo/adt/sdk"
export PATH="$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$PATH"

# setup nodejs paths
export NODE_PATH=/usr/lib/node_modules

# rbenv overrides npm installed lessc
alias lessjs='/usr/bin/lessc'

function gvim () { (/usr/bin/gvim -f "$@" 1> /dev/null &) }
function subl () { (/usr/bin/subl "$@" 1> /dev/null &) }
function open () { (/usr/bin/xdg-open "$@" 1> /dev/null &) }

function newexe () {
  case $(basename $1) in
    *.js) sh=node;;
    *.*) sh=$(echo $(basename $1) | awk -F . '{print $NF}');;
    *) sh=sh;;
  esac

  mkdir -p $(dirname $1)
  if [ ! -f teste.txt ]; then echo "#!/usr/bin/env $sh" > $1; fi
  chmod +x $1
  subl $1
}
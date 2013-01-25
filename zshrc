ZSH=$HOME/.oh-my-zsh
ZSH_THEME="fino"

plugins=(git git-extras bundler gem rbenv npm autojump thor heroku pip virtualenvwrapper mvn history-substring-search zsh-syntax-highlighting)

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

# zsh already has .. and ...
alias ....='cd ../../..'
alias .....='cd ../../../..'

# rbenv overrides npm installed lessc
alias lessjs='/usr/bin/lessc'

function cd-git () {
  newwd=.
  while [[ ! -d $newwd/.git ]] && [[ "$(readlink -f $newwd)" != / ]]; do
    newwd=$newwd/..
  done
  [[ "$(readlink -f $newwd)" == / ]] || cd $newwd
}

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

function echo_red () { echo -e "\033[1;31m$@\033[0m" }
function echo_green () { echo -e "\033[1;32m$@\033[0m" }
function echo_gray () { echo -e "\033[1;30m$@\033[0m" }
function echo_doc () { echo_gray "$1 \t\t-- $2" }

function , () {
  echo_doc "cd-git()" "go to the root of the current git repository"
  echo_doc "gvim(file, args...)" "open file on gvim"
  echo_doc "subl(file, args...)" "open file on subl"
  echo_doc "open(file, args...)" "open file with X"
  echo_doc "newexe(file)" "create a executable file and open it on subl"
}

echo_gray "Run , to list commands."

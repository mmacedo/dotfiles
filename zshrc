ZSH=$HOME/.oh-my-zsh
ZSH_THEME="af-magic"

plugins=(git bundler gem rbenv npm autojump thor heroku pip virtualenvwrapper mvn)

source $ZSH/oh-my-zsh.sh

# annoying, don't enable
unsetopt correct_all
# necessary for git-achievements
setopt complete_aliases

# zsh already has .. and ...
alias ....='cd ../../..'
alias .....='cd ../../../..'

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

function nailgun () {
  sudo sh -c ""
  (JRUBY_OPTS="--1.9" sudo $(rbenv which jruby) --ng-server 1> /dev/null &)
  export JRUBY_OPTS="--ng --1.9"
}

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
  echo_doc "nailgun()" "start a nailgun server"
  echo_doc "newexe(file)" "create a executable file and open it on subl"
  echo_doc "echo_red(text)" "prints red"
  echo_doc "echo_green(text)" "prints green"
  echo_doc "echo_gray(text)" "prints gray"
  echo_doc "echo_doc(command, description)" "prints line autocomplete style documentation"
}

echo_gray "Run , to list commands."
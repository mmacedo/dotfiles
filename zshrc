ZSH=$HOME/.oh-my-zsh
ZSH_THEME="fino"

plugins=(git git-extras bundler gem rbenv npm autojump thor heroku pip virtualenvwrapper history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# annoying, don't enable
unsetopt correct_all
# necessary for git-achievements
setopt complete_aliases
# commands that start with space are not recorded
setopt hist_ignore_space
# enable comments on command line
setopt interactive_comments

# setup elixir path
export PATH="/home/mmacedo/elixir/bin:$PATH"

# setup ADT paths
export ANDROID_SDK_HOME="/home/mmacedo/adt/sdk"
export PATH="$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$PATH"

# rbenv overrides lessc installed through npm
alias lessjs='/usr/bin/lessc'

function gvim () { nohup /usr/bin/gvim -f "$@" &>/dev/null }
function subl () { nohup /usr/bin/subl "$@" &>/dev/null }
function open () { nohup /usr/bin/xdg-open "$@" &>/dev/null }

function newfile () {
  # ensure directory is created
  mkdir -p $(dirname $1)
  # ensure the file exists
  touch $(basename $1)
  # open in the editor
  subl $1
}

# create file with +x and #!
function newexe () {
  # guess shebang by file extension
  case $(basename $1) in
    *.js)  sh=node;;
    # add -mode(compile), it is usually faster
    *.erl) sh="escript\n\n-mode(compile).";;
    # DrRacket
    *.scm) sh="racket\n#lang racket";;
    *.rb)  sh=ruby;;
    *.py)  sh=python;;
    # no extension means default shell
    *)     sh=bash;;
  esac

  # ensure directory is created
  mkdir -p $(dirname $1)
  # create the file with the shebang
  if [ ! -f teste.txt ]; then echo -n "#!/usr/bin/env $sh\n\n" > $1; fi
  # add permissions to execute
  chmod +x $1
  # open in the editor
  subl $1
}

# mv with the last argument is guaranteed to be a directory
function mvtodir () {
  # last argument is the target directory
  dir="${@: -1}"
  # all but the last argument are the files/folders to move
  files="${@:1:-1}"
  # ensure target directory is created
  mkdir -p "$dir" || return $?
  # pass target directory explicitly
  mv --target-directory="$dir" $(echo $files)
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

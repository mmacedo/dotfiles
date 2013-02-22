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

# setup elixir path
export PATH="/home/mmacedo/elixir/bin:$PATH"

# setup ADT paths
export ANDROID_SDK_HOME="/home/mmacedo/adt/sdk"
export PATH="$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$PATH"

# rbenv overrides npm installed lessc
alias lessjs='/usr/bin/lessc'

function gvim () { (/usr/bin/gvim -f "$@" 1> /dev/null &) }
function subl () { (/usr/bin/subl "$@" 1> /dev/null &) }
function open () { (/usr/bin/xdg-open "$@" 1> /dev/null &) }

# Create file with +x and #!
function newexe () {
  case $(basename $1) in
    *.js) sh=node;;
    *.rb) sh=ruby;;
    *.py) sh=python;;
    *.*) sh=$(echo $(basename $1) | awk -F . '{print $NF}');;
    *) sh=sh;;
  esac

  mkdir -p $(dirname $1)
  if [ ! -f teste.txt ]; then echo "#!/usr/bin/env $sh" > $1; fi
  chmod +x $1
  subl $1
}

# mv with the last argument is guaranteed to be a directory
function mvtodir () {
  dir="${@: -1}"
  files="${@:1:-1}"
  mkdir -p "$dir" || return $?
  mv -t $dir $files
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

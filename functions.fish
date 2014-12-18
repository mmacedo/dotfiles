function be -d "bundle exec"
  bundle exec $argv
end

function rm -d "Send files to trash"
  trash-put $argv
end

function play -d "Play audio files on command-line (via (C)VLC)"
  cvlc --play-and-exit $argv >/dev/null ^&1
end

# better commands to open GUI apps
function gvim -d "Open gvim"
  eval (nohup /usr/bin/gvim $argv >/dev/null ^&1 &)
end
function subl -d "Open Sublime Text 2"
  eval (nohup /usr/bin/subl $argv >/dev/null ^&1 &)
end
function open -d "Open path with default application (xdg-open)"
  eval (nohup /usr/bin/xdg-open $argv >/dev/null ^&1 &)
end

function newfile -d "create folder, file and open it on sublime text"
  # ensure directory is created
  mkdir -p (dirname $argv[1])
  # ensure the file exists
  touch $argv[1]
  # open in the editor
  subl $argv[1]
end

function newexe -d "create file with +x and #!"
  # guess shebang by file extension
  switch (basename $argv[1])
    case '*.lua'
      set sh lua
    case '*.coffee'
      set sh coffee
    case '*.js'
      set sh node
    # add -mode(compile), it is usually faster
    case '*.erl'
      set sh escript\n\n\-mode\(compile\).
    case '*.scm'
      set sh racket\n\#lang scheme
    case '*.rkt'
      set sh racket\n\#lang racket
    case '*.rb'
      set sh ruby
    case '*.py'
      set sh python
    # defaults to bash
    case '*'
      set sh bash
  end

  # ensure directory is created
  mkdir -p (dirname $argv[1])
  # create the file with the shebang
  if not test -f $argv[1]
    echo -n \#\!/usr/bin/env {$sh}\n\n > $argv[1]
  end
  # add permissions to execute
  chmod +x $argv[1]
  # open in the editor
  subl $argv[1]
end

function mvtodir -d "move files with last argument guaranteed to be a directory"
  # last argument is the target folder
  set folder $argv[(count $argv)]
  # all but the last argument are the files/folders to move
  set files $argv[1..-2]
  # ensure target directory is created
  mkdir -p $folder; or return $status
  # pass target directory explicitly
  mv --target-directory="$folder" $files
end

function removeallgems -d "uninstall all gems from current ruby"
  gem list \
  | cut -d' ' -f1 \
  | grep -v '^minitest\|rake\|bigdecimal\|io-console\|json\|rdoc\|test-unit\|psych$' \
  | xargs gem uninstall -aIx
end

function git_update
  set remote $argv[1]
  if test -z "$remote"; echo "Usage: command REMOTE [BRANCH]" >&2; exit 1; end
  set branch $argv[2]
  if test -z "$branch"; set branch (git symbolic-ref --short HEAD ^/dev/null); end
  git fetch $remote; and git rebase -p $remote/$branch
end

function encode64
  set -l format
  set -l input_file
  if test (count $argv) -eq 2
    set format $argv[1]
    set input_file $argv[2]
  else
    set format png
    set input_file $argv[1]
  end
  set -l image_file (mktemp).$format
  convert $input_file -format $format $image_file
  echo -n "data:image/$format;base64,"
  python3 -c 'import sys;import urllib.parse;import base64;print(urllib.parse.quote(base64.b64encode(open(sys.argv[1], "rb").read())),end="")' $image_file
end

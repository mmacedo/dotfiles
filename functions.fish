function be -d "bundle exec"
  bundle exec $argv
end

function rm -d "Send files to trash"
  trash-put $argv
end

function play -d "Play audio files on command-line (via (C)VLC)"
  cvlc --play-and-exit $argv >/dev/null ^&1
end

function subl -d "Open Sublime Text 3"
  eval (nohup /usr/bin/subl $argv >/dev/null ^&1 &)
end

function open -d "Open path with default application (xdg-open)"
  eval (nohup /usr/bin/xdg-open $argv >/dev/null ^&1 &)
end

function newfile -d "create folder, file and open it on sublime text"
  if test (count $argv) -eq 0
    echo "Usage: newfile FILES" >&2
    exit 1
  end

  for file in $argv
    # ensure directory is created
    mkdir -p (dirname $file)
    # ensure the file exists
    touch $file
    # open in the editor
    subl $file
  end
end

function newexe -d "create file with +x and #!"
  if test (count $argv) -eq 0
    echo "Usage: newexe FILES" >&2
    exit 1
  end

  for file in $argv
    # guess shebang by file extension
    switch (basename $file)
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
      case '*.fish'
        set sh fish
      # defaults to bash
      case '*'
        set sh bash
    end

    # ensure directory is created
    mkdir -p (dirname $file)
    # create the file with the shebang
    if not test -f $file
      echo -n \#\!/usr/bin/env {$sh}\n\n > $file
    end
    # add permissions to execute
    chmod +x $file
    # open in the editor
    subl $file
  end
end

function removeallgems -d "uninstall all gems from current ruby"
  gem list \
  | cut -d' ' -f1 \
  | xargs gem uninstall -aIx
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

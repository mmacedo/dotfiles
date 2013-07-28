function pyenv_shell
  set -l ver $argv[1]

  switch "$ver"
    case '--complete'
      echo '--unset'
      echo 'system'
      exec pyenv-versions --bare
    case '--unset'
      set -e PYENV_VERSION
    case ''
      if [ -z "$PYENV_VERSION" ]
        echo "pyenv: no shell-specific version configured" >&2
        return 1
      else
        echo "$PYENV_VERSION"
      end
    case '*'
      pyenv prefix "$ver" > /dev/null
      set -g -x PYENV_VERSION "$ver"
  end
end

function pyenv
  set -l cmd $argv[1]
  [ (count $argv) -gt 1 ]; and set -l args $argv[2..-1]

  switch "$cmd"
    case shell
      pyenv_shell $args
    case '*'
      command pyenv $cmd $args
  end
end

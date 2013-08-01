set PATH ~/.rbenv/bin $PATH
set PATH ~/.rbenv/shims $PATH

function rbenv_shell
  set -l ver $argv[1]

  switch "$ver"
    case '--complete'
      echo '--unset'
      echo 'system'
      exec rbenv-versions --bare
    case '--unset'
      set -e RBENV_VERSION
    case ''
      if [ -z "$RBENV_VERSION" ]
        echo "rbenv: no shell-specific version configured" >&2
        return 1
      else
        echo "$RBENV_VERSION"
      end
    case '*'
      rbenv prefix "$ver" > /dev/null
      set -g -x RBENV_VERSION "$ver"
  end
end

function rbenv
  set -l cmd $argv[1]
  [ (count $argv) -gt 1 ]; and set -l args $argv[2..-1]

  switch "$cmd"
    case shell
      rbenv_shell $args
    case '*'
      command rbenv $cmd $args
  end
end

set PATH ~/.ndenv/bin $PATH
set PATH ~/.ndenv/shims $PATH

function ndenv_shell
  set -l ver $argv[1]

  switch "$ver"
    case '--complete'
      echo '--unset'
      echo 'system'
      exec ndenv-versions --bare
    case '--unset'
      set -e NDENV_VERSION
    case ''
      if [ -z "$NDENV_VERSION" ]
        echo "ndenv: no shell-specific version configured" >&2
        return 1
      else
        echo "$NDENV_VERSION"
      end
    case '*'
      ndenv prefix "$ver" > /dev/null
      set -g -x NDENV_VERSION "$ver"
  end
end

function ndenv
  set -l cmd $argv[1]
  [ (count $argv) -gt 1 ]; and set -l args $argv[2..-1]

  switch "$cmd"
    case shell
      ndenv_shell $args
    case '*'
      command ndenv $cmd $args
  end
end

# fish completion for ndenv

function __fish_ndenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'ndenv' ]
    return 0
  end

  return 1
end

function __fish_ndenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

function __fish_ndenv_executables
  ndenv exec --complete
end

function __fish_ndenv_installed_nodes
  ndenv versions --bare
end

function __fish_ndenv_official_nodes
  node-build --definitions
end

function __fish_ndenv_prefixes
  ndenv prefix --complete
end

### commands
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a commands -d 'List all ndenv commands'
complete -f -c ndenv -n '__fish_ndenv_using_command commands' -a '--complete --sh --no-sh'

### completions
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a completions

### exec
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a exec
complete -f -c ndenv -n '__fish_ndenv_using_command exec' -a '(__fish_ndenv_executables)'

### global
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a global -d 'Set or show the global Node version'
complete -f -c ndenv -n '__fish_ndenv_using_command global' -a '(__fish_ndenv_installed_nodes)'

### help
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a help

### hooks
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a hooks

### init
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a init

### install
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a install -d 'Install a Node version'
complete -f -c ndenv -n '__fish_ndenv_using_command install' -a '(__fish_ndenv_official_nodes)'

### local
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a local -d 'Set or show the local directory-specific Node version'
complete -f -c ndenv -n '__fish_ndenv_using_command local' -a '(__fish_ndenv_installed_nodes)'

### prefix
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a prefix -d 'Shows a Node version installed folder'
complete -f -c ndenv -n '__fish_ndenv_using_command prefix' -a '(__fish_ndenv_prefixes)'

### rehash
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a rehash -d 'Rehash ndenv shims (run this after installing binaries)'

### root
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a root -d 'ndenv root folder'

### shell
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a shell -d 'Set or show the shell-specific Node version'
complete -f -c ndenv -n '__fish_ndenv_using_command shell' -a '--unset (__fish_ndenv_installed_nodes)'

### shims
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a shims
complete -f -c ndenv -n '__fish_ndenv_using_command shims' -a '--short'

### version
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a version  -d 'Show the current Node version'

### version-file
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a version-file

### version-file-read
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a version-file-read

### version-file-write
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a version-file-write

### version-name
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a version-name

### version-origin
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a version-origin

### versions
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a versions -d 'List all Node versions known by ndenv'

### whence
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a whence -d 'List all Node versions with the given command'
complete -f -c ndenv -n '__fish_ndenv_using_command whence' -a '--complete --path'

### which
complete -f -c ndenv -n '__fish_ndenv_needs_command' -a which -d 'Show the full path for the given Node command'
complete -f -c ndenv -n '__fish_ndenv_using_command which' -a '(__fish_ndenv_executables)'

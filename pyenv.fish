# python-build binary is used from pyenv completion
function python-build
  if test -n "$PYENV_ROOT"
    eval $PYENV_ROOT/plugins/python-build/bin/python-build $argv
  else
    eval $HOME/.pyenv/plugins/python-build/bin/python-build $argv
  end
end


# fish completion for pyenv, copied from /usr/share/fish/completions/rbenv.fish

function __fish_pyenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'pyenv' ]
    return 0
  end

  return 1
end

function __fish_pyenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

function __fish_pyenv_executables
  pyenv exec --complete
end

function __fish_pyenv_installed_rubies
  pyenv versions --bare
end

function __fish_pyenv_official_rubies
  python-build --definitions
end

function __fish_pyenv_prefixes
  pyenv prefix --complete
end

### commands
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a commands -d 'List all pyenv commands'
complete -f -c pyenv -n '__fish_pyenv_using_command commands' -a '--complete --sh --no-sh'

### completions
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a completions

### exec
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a exec
complete -f -c pyenv -n '__fish_pyenv_using_command exec' -a '(__fish_pyenv_executables)'

### global
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a global -d 'Set or show the global Ruby version'
complete -f -c pyenv -n '__fish_pyenv_using_command global' -a '(__fish_pyenv_installed_rubies)'

### help
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a help

### hooks
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a hooks

### init
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a init

### install
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a install -d 'Install a python version'
complete -f -c pyenv -n '__fish_pyenv_using_command install' -a '(__fish_pyenv_official_rubies)'

### local
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a local -d 'Set or show the local directory-specific Ruby version'
complete -f -c pyenv -n '__fish_pyenv_using_command local' -a '(__fish_pyenv_installed_rubies)'

### prefix
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a prefix -d 'Shows a python version installed folder'
complete -f -c pyenv -n '__fish_pyenv_using_command prefix' -a '(__fish_pyenv_prefixes)'

### rehash
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a rehash -d 'Rehash pyenv shims (run this after installing binaries)'

### root
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a root -d 'pyenv root folder'

### shell
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a shell -d 'Set or show the shell-specific Ruby version'
complete -f -c pyenv -n '__fish_pyenv_using_command shell' -a '--unset (__fish_pyenv_installed_rubies)'

### shims
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a shims
complete -f -c pyenv -n '__fish_pyenv_using_command shims' -a '--short'

### version
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a version  -d 'Show the current Ruby version'

### version-file
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a version-file

### version-file-read
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a version-file-read

### version-file-write
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a version-file-write

### version-name
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a version-name

### version-origin
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a version-origin

### versions
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a versions -d 'List all Ruby versions known by pyenv'

### whence
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a whence -d 'List all Ruby versions with the given command'
complete -f -c pyenv -n '__fish_pyenv_using_command whence' -a '--complete --path'

### which
complete -f -c pyenv -n '__fish_pyenv_needs_command' -a which -d 'Show the full path for the given Ruby command'
complete -f -c pyenv -n '__fish_pyenv_using_command which' -a '(__fish_pyenv_executables)'

set -l MONO_PREFIX /opt/mono

set -x DYLD_FALLBACK_LIBRARY_PATH $MONO_PREFIX/lib $DYLD_LIBRARY_FALLBACK_PATH
set -x LD_LIBRARY_PATH $MONO_PREFIX/lib $LD_LIBRARY_PATH
set -x C_INCLUDE_PATH $MONO_PREFIX/include
set -x ACLOCAL_PATH $MONO_PREFIX/share/aclocal
set -x PKG_CONFIG_PATH $MONO_PREFIX/lib/pkgconfig

set PATH $MONO_PREFIX/bin $PATH

function mono
  switch "$argv[1]"
    # Cache version to save time printing prompt
    case '--version'
      set version_file /tmp/mono-version.(echo %self)
      [ -f $version_file ]; or command mono --version >$version_file
      cat $version_file
    case '*'
      command mono $argv
  end
end

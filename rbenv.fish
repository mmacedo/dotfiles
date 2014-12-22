# ruby-build binary is used from rbenv completion
function ruby-build
  if test -n "$RBENV_ROOT"
    eval $RBENV_ROOT/plugins/ruby-build/bin/ruby-build $argv
  else
    eval $HOME/.rbenv/plugins/ruby-build/bin/ruby-build $argv
  end
end

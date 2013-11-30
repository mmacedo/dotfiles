function scala
  switch "$argv[1]"
    # Cache version to save time printing prompt
    case '-version'
      set version_file /tmp/scala-version.(echo %self)
      [ -f $version_file ]; or command scala -version >$version_file ^&1
      cat $version_file
    case '*'
      command scala $argv
  end
end

function _exec_with
  set -l shell $argv[1]
  set -l file $argv[2]
  set -l code $argv[3]

  set -l source
  switch "$shell"
    case bash zsh ksh
      set source .
    case '*'
      echo "Unknown shell '$shell'" >&2
      return 1
  end

  # List variables, ignore $_, $PIPESTATUS, $COLUMNS and $SHLVL
  set -l variable_names "env | grep -v '^_|PIPESTATUS|COLUMNS|SHLVL\\\$' | sort"
  # List functions, find headers (lines with '()'), keep only the name of the
  #  function (remove after the first space or '('), ignore names with '$'
  set -l function_names "typeset -f | grep '^[^ (]\\+ \\?()' | sed 's/^\\([^ (]\\+\\).*/\\1/' | grep -v '\\\$' | sort"
  # List aliases, remove 'alias ' preffix if present and the value (everything after the =)
  set -l aliases_names "alias | sed 's/\\(alias \\)\\?\\([^=]\\+\\).*/\\2/' | sort"

  # Create temp files to catch the change of variables and functions
  set -l variables_before (mktemp)
  set -l variables_after (mktemp)
  set -l functions_before (mktemp)
  set -l functions_after (mktemp)
  set -l aliases_before (mktemp)
  set -l aliases_after (mktemp)

  set -l before "$variable_names > $variables_before; $function_names > $functions_before; $aliases_names > $aliases_before"
  set -l after "$variable_names > $variables_after; $function_names > $functions_after; $aliases_names > $aliases_after"

  /usr/bin/env $shell -c "$before; $source $file; $code $after"

  # Separator used by read to store a single line into several variables
  set -l IFS =

  # Diff of the env in the format (+|-)=(?<VAR>.+)=(?<VALUE>.+)
  set -l diffopts --old-line-format '-=%L' --new-line-format '+=%L' --unchanged-line-format ''

  diff $diffopts $variables_before $variables_after | while read -l state var value
    switch $state$var
      case -PATH -MANPATH
        continue
      case +PATH +MANPATH
        # split by colons into an array
        eval set value (echo $value | sed 's/:$//' | sed 's/:\?\([^:]\+\)/"\1" /g')
        # reverse array (because preprending will cause reversing again)
        set -l temp; for i in $value; set temp $i $temp; end; set value $temp

        # Sync dirs removed from the path
        for dir in $$var
          if contains $dir $value; continue; end

          # DEBUG:
          # echo remove \"$dir\" from the \${$var}

          eval set -e $var\[(contains -i $dir $$var)\]
        end

        # Sync dirs added to the path
        for dir in $value
          if contains $dir $$var; continue; end

          # DEBUG:
          # echo prepend \"$dir\" to the \${$var}

          set -gx $var "$dir" $$var
        end
      case '-*'
        # DEBUG:
        # echo unset $var \(old: \'{$$var}\'\)

        set -e $var
      case '+*'
        # DEBUG:
        # echo Set \${$var} to \'$value\' \(old: \'{$$var}\'\)

        set -gx $var $value
      case '*'
        echo "Source error! Invalid case '$state$var'" >&2
    end
  end

  diff $diffopts $functions_before $functions_after | while read -l state func
    switch $state$func
      case '-*'
        # Do nothing if a function was removed
        continue
      case '+*'
        # Create wrapper function
        eval "function $func; _exec_with $shell \"$file\" \"$func \$argv;\"; end"

        # DEBUG:
        # echo Create wrapper for function $func from $file
      case '*'
        echo "Source error! Invalid case '$func'" >&2
    end
  end

  diff $diffopts $aliases_before $aliases_after | while read -l state func
    switch $state$func
      case '-*'
        # Do nothing if an alias was removed
        continue
      case '+*'
        # code to manually execute an alias
        set -l exec_alias "eval \\\$(eval echo `alias $func | sed 's/\\(alias \\)\\?[^=]\\+=//'`) \\\$argv"

        # Create wrapper function
        eval "function $func; _exec_with $shell \"$file\" \"$exec_alias;\"; end"

        # DEBUG:
        # echo Create wrapper for alias $func from $file
      case '*'
        echo "Source error! Invalid case '$func'" >&2
    end
  end

  # Remove temporary files
  command rm $variables_before $variables_after $functions_before $functions_after $aliases_before $aliases_after >/dev/null
end

function source --description 'Source bash/zsh/ksh files'
  set -l type
  while true
    if test (count $argv) -eq 0
      echo "Called with no arguments" >&2
      return 1
    end
    switch $argv[1]
      case '--*'
        set type (echo $argv[1] | sed 's/^--//')
      case '*'
        break
    end
    set -e argv[1]
  end

  for file in $argv
    set -l file_type $type
    if not test "$file_type"
      switch (readlink -f $file)
        case '*.sh', '**/.bash*'
          set file_type bash
        case '*.zsh', '**/.zsh*'
          set file_type zsh
        case '*.ksh', '**/.ksh*'
          set file_type ksh
        case '**/.profile', '*'
          set file_type bash
      end
    end

    _exec_with $file_type "$file" ""
  end
end
